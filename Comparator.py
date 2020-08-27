import networkx as nx
import pydot
import os
import shutil
import copy
import CallGraphComp as cgc
import MemGraphComp as mgc
import compression_schemes as schemes
import llvmlite.binding as llvm
mem_graph = "./{seadsa} -sea-dsa=butd-cs  -sea-dsa-dot  {path} -sea-dsa-dot-outdir=mem_results_{number}"
call_graph = "./{seadsa}  --sea-dsa-callgraph-dot {path} -sea-dsa-dot-outdir=call_results_{number}"
class Comparator:
    #Takes the path to each llvm file and computes a similarity score
    def __init__(self,source_1_path,source_2_path,seadsa_location="seadsa"):
        abspath = os.path.abspath(__file__)
        dname = os.path.dirname(abspath)
        os.chdir(dname)
        self.__setup()
        self.__optimization_set = False
        self.__seadsa = seadsa_location
        self.__source_1_path = source_1_path
        self.__source_2_path = source_2_path
        self.__run_path = []
        self.metrics = {}
    pass
    def output(self):
        '''
        Print output
        '''
        for key in self.metrics.keys():
            print(key + ": "+str(self.metrics[key]))
    def run(self):
        '''
        Compute similarity between added graphs
        '''
        for f in self.__run_path:
            f()
        pass
    def __set_optimization_helper(self,path,pass_list):
        f = open(path,"r")
        llvm_ir = f.read()
        f.close()
        mod = llvm.parse_assembly(llvm_ir)
        mod.verify()
        moduleManager = llvm.ModulePassManager()
        for passes in pass_list:
            moduleManager = self.optimization_pass(moduleManager,passes)
            pass
        moduleManager.run(mod)
        return mod
    def set_optimization(self,appliedToOne,appliedToTwo):
        '''
        Add optional optimization passes for each input
        '''
        self.__optimization_set = True
        mod = self.__set_optimization_helper(self.__source_1_path,appliedToOne)
        a = open("optimized_module_1/module.ll","wt")
        a.write(str(mod))
        a.close()

        mod = self.__set_optimization_helper(self.__source_2_path,appliedToTwo)
        a = open("optimized_module_2/module.ll","wt")
        a.write(str(mod))
        a.close()
        pass
        
    def use_call_graphs(self,node_identifier = 'LABEL'):
        if self.__optimization_set == False:
            self.set_optimization([],[])
        self.g1_call = self.__get_call_graph("optimized_module_1/module.ll",1)
        self.g2_call = self.__get_call_graph("optimized_module_2/module.ll",2)
        if node_identifier == 'LABEL':
            self.__run_path.append(self.__use_call_graphs_string_compression)
        elif node_identifier == 'DEGREE':
            self.__run_path.append(self.__use_call_graphs_iterator)
        else:
            raise Exception("Unknown node identifier")
        pass
    def use_mem_graphs(self, node_identifier = 'LABEL',composing_functions="MAIN"):
        if self.__optimization_set == False:
            self.set_optimization([],[])
        if composing_functions == "MAIN":
            self.g1_mem = self.__get_mem_graph_main("optimized_module_1/module.ll",1)
            self.g2_mem = self.__get_mem_graph_main("optimized_module_2/module.ll",2)
        else:
            raise Exception("only main works for now")
        if node_identifier == 'LABEL':
            self.__run_path.append(self.__use_mem_graphs_string_compression)
        elif node_identifier == 'DEGREE':
            self.__run_path.append(self.__use_mem_graphs_iterator)
        else:
            raise Exception("Unknown node identifier")
        pass
    def use_control_flow_graphs(self,node_identifier = 'DEGREE',composing_functions="MAIN"):
        if self.__optimization_set == False:
            self.set_optimization([],[])
        if composing_functions == "MAIN":
            self.g1_cfg = self.__get_cfg_main("optimized_module_1/module.ll")
            self.g2_cfg = self.__get_cfg_main("optimized_module_2/module.ll")
        elif composing_functions == "ALL":
            self.g1_cfg = self.__get_cfg_all("optimized_module_1/module.ll")
            self.g2_cfg = self.__get_cfg_all("optimized_module_2/module.ll")
        else:
            raise Exception("unknown composing functions")
        if node_identifier == "DEGREE":
            self.__run_path.append(self.__use_cfg_iterator)
        elif node_identifier == "LABEL":
            self.__run_path.append(self.__use_cfg_str)
        else:
            raise Exception("unknown node identifier")
        pass
    def __remove_ignorable_functions(self,graph):
        ignorable_functions = [
            '"{llvm.dbg.declare}"',
            '"{llvm.lifetime.start.p0i8}"',
            '"{llvm.lifetime.end.p0i8}"',
            '"{llvm.memset.p0i8.i64}"',
            '"{Node',
            '"{external node}"'
        ]
        graph_copy = copy.deepcopy(graph)
        for node in graph.nodes():
            try:
                b = nx.get_node_attributes(graph,"label")[node]
                for string in ignorable_functions:
                    if b in string:
                        graph_copy.remove_node(node)
                pass
            except KeyError:
                pass
        return graph_copy
    def optimization_pass(self,moduleManager,applied_pass):
        if applied_pass == 'add_instruction_combining_pass':
            moduleManager.add_instruction_combining_pass()
        elif applied_pass == 'add_dead_arg_elimination_pass':
            moduleManager.add_dead_arg_elimination_pass()
        elif applied_pass == 'add_global_optimizer_pass':
            moduleManager.add_global_optimizer_pass()
        elif applied_pass == 'add_dead_code_elimination_pass':
            moduleManager.add_dead_code_elimination_pass()
        elif applied_pass == 'add_function_attrs_pass':
            moduleManager.add_function_attrs_pass()
        elif applied_pass == 'add_type_based_alias_analysis_pass':
            moduleManager.add_type_based_alias_analysis_pass()
        else:
            raise Exception("Unknown pass")
        return moduleManager
    def __get_cfg_main(self,path):
        f = open(path,"r")
        llvm_ir = f.read()
        f.close()
        mod = llvm.parse_assembly(llvm_ir)
        for function in mod.functions:
            if function.name == "main":
                cfg = llvm.get_function_cfg(function,show_inst=True)
                pass
        p = pydot.graph_from_dot_data(cfg)
        cfg_graph = nx.nx_pydot.from_pydot(p[0])
        return cfg_graph
    def __get_cfg_all(self,path):
        f = open(path,"r")
        llvm_ir = f.read()
        f.close()
        mod = llvm.parse_assembly(llvm_ir)
        graphs = []
        for function in mod.functions:
            cfg = llvm.get_function_cfg(function,show_inst=True)
            p = pydot.graph_from_dot_data(cfg)
            cfg_graph = nx.nx_pydot.from_pydot(p[0])
            graphs.append(cfg_graph)
        return nx.compose_all(graphs)
    def __get_call_graph(self,path,num):
        call = call_graph.format(path=path,number=str(num),seadsa=self.__seadsa)
        os.system(call)
        p = pydot.graph_from_dot_file("call_results_"+str(num)+"/callgraph.dot")
        callgraph_nx =  nx.nx_pydot.from_pydot(p[0])
        return self.__remove_ignorable_functions(callgraph_nx)
    def __get_mem_graph_main(self,path,num):
        call = mem_graph.format(path=path,number=str(num),seadsa=self.__seadsa)
        os.system(call)
        mem_graphs = []
        with os.scandir("mem_results_"+str(num)) as m:
            for mem_dot in m:
                if mem_dot.name == "main.mem.dot":
                    p = pydot.graph_from_dot_file("mem_results_"+str(num)+"/"+mem_dot.name)
                    memgraph_nx =  nx.nx_pydot.from_pydot(p[0])
                    mem_graphs.append(memgraph_nx)
                    return memgraph_nx
    def __use_cfg_str(self):
        scheme = schemes.StringCompressionScheme()
        cfg_comp = cgc.CallGraphComp(self.g1_cfg,self.g2_cfg,scheme)
        self.cfg_similarity_str = cfg_comp.score
        self.metrics["Control Flow Graph with Label Values for Distinction"]=cfg_comp.score
    def __use_cfg_iterator(self):
        scheme = schemes.IteratorScheme()
        cfg_comp = cgc.CallGraphComp(self.g1_cfg,self.g2_cfg,scheme)
        self.cfg_similarity_iterator = cfg_comp.score
        self.metrics["Control Flow Graph with Node Degree Values for Distinction"]=cfg_comp.score
        pass
    
    def __use_call_graphs_string_compression(self):
        scheme = schemes.StringCompressionScheme()
        call_comp = cgc.CallGraphComp(self.g1_call,self.g2_call,scheme)
        self.callgraph_similarity_string_compression = call_comp.score
        self.metrics["Call graph with Node Labels for Distinction"]= call_comp.score
        pass
    def __use_mem_graphs_string_compression(self):
        scheme = schemes.StringCompressionScheme()
        mem_comp = mgc.MemGraphCompare(self.g1_mem,self.g2_mem,scheme)
        self.memgraph_similarity_string_compression = mem_comp.score
        self.metrics["Memory graph with Node Labels for Distinction"]= mem_comp.score
        pass
    def __use_call_graphs_iterator(self):
        scheme = schemes.IteratorScheme()
        call_comp = cgc.CallGraphComp(self.g1_call,self.g2_call,scheme)
        self.callgraph_similarity_iterator = call_comp.score
        self.metrics["Call graph with Node Degree for Distinction"]= call_comp.score
        pass
    def __use_mem_graphs_iterator(self):
        scheme = schemes.IteratorScheme()
        mem_comp = mgc.MemGraphCompare(self.g1_mem,self.g2_mem,scheme)
        self.memgraph_similarity_iterator = mem_comp.score
        self.metrics["Memory graph with Node Degree for Distinction"]= mem_comp.score
        pass
    def __setup(self):
        self.__cleanup()
        os.mkdir("mem_results_1", mode=0o777)
        os.mkdir("call_results_1", mode=0o777)
        os.mkdir("mem_results_2", mode=0o777)
        os.mkdir("call_results_2", mode=0o777)
        os.mkdir("optimized_module_1", mode=0o777)
        os.mkdir("optimized_module_2", mode=0o777)
        pass
    def __cleanup(self):
        try:
            shutil.rmtree("mem_results_1")
        except:
            pass
        try:
            shutil.rmtree("mem_results_2")
        except:
            pass
        try:
            shutil.rmtree("call_results_1")
        except:
            pass
        try:
            shutil.rmtree("call_results_2")
        except:
            pass
        try:
            shutil.rmtree("optimized_module_1")
        except:
            pass
        try:
            shutil.rmtree("optimized_module_2")
        except:
            pass

pass
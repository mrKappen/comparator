
import Comparator as c
if __name__=="__main__":
    obj = c.Comparator("Palindrome_O1.ll","Palindrome_O0.ll")
    obj.use_call_graphs()
    obj.use_mem_graphs()
    obj.use_control_flow_graphs()
    obj.run()
    obj.output()           

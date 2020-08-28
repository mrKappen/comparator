'''
A test set to check whether the Weisfeiler-Leman Algorithm has been implemented as expected
'''
from WL_Wrapper import WL_Wrapper
from compression_schemes import StringCompressionScheme
from compression_schemes import IteratorScheme
import networkx as nx
test_status = '''
Test Name: {Name}
Result: {result}
'''
def TestIdenticalGraphs(scheme):
    result = ""
    g = nx.complete_graph(100)
    w = WL_Wrapper(g,g,scheme)
    if abs(w.score - 1 <0.01):
        result = result + test_status.format(Name="TestIdenticalGraphs",result="complete_graph: PASS")
    else:
        result = result + test_status.format(Name="TestIdenticalGraphs",result="complete_graph: FAIL")
    pass
    g = nx.complete_multipartite_graph(10)
    w = WL_Wrapper(g,g,scheme)
    if abs(w.score - 1 <0.01):
        result = result + test_status.format(Name="TestIdenticalGraphs",result="complete_multipartite_graph(10): PASS")
    else:
        result = result + test_status.format(Name="TestIdenticalGraphs",result="complete_multipartite_graph(10): FAIL")
    pass
    g = nx.empty_graph(100)
    w = WL_Wrapper(g,g,scheme)
    if abs(w.score - 1 <0.01):
        result = result + test_status.format(Name="TestIdenticalGraphs",result="empty_graph(100): PASS")
    else:
        result = result + test_status.format(Name="TestIdenticalGraphs",result="empty_graph(100): FAIL")
    pass
    return result
def TestBasic(scheme):
    result = ""
    g = nx.Graph()
    g.add_nodes_from([1,2,3,4,5,6])
    g.add_edge(1,2)
    g.add_edge(2,3)
    g.add_edge(3,4)
    g.add_edge(4,5)
    g.add_edge(5,6)

    s = nx.Graph()
    s.add_nodes_from([1,2,3,4,5,6])
    s.add_edge(1,2)
    s.add_edge(2,3)
    s.add_edge(2,4)
    s.add_edge(3,5)
    s.add_edge(4,6)
    s.add_edge(5,6)

    w = WL_Wrapper(g,s,scheme)
    if abs(w.score - 0.489 <0.01):
        result = result + test_status.format(Name="TestBasic",result="PASS")
    else:
        result = result + test_status.format(Name="TestBasic",result="FAIL")
    pass
    return result
def TestDifferentNumberOfNodes(scheme):
    result = ""
    g = nx.Graph()
    g.add_nodes_from([1,2,3,4,5])
    g.add_edge(1,2)
    g.add_edge(2,3)
    g.add_edge(2,4)
    g.add_edge(3,5)
    g.add_edge(4,5)
    s = nx.Graph()
    s.add_nodes_from([1,2,3,4,5,6])
    s.add_edge(1,2)
    s.add_edge(2,3)
    s.add_edge(3,4)
    s.add_edge(4,5)
    s.add_edge(5,6)

    w = WL_Wrapper(g,s,scheme)
    if abs(w.score - 0.80 <0.01):
        result = result + test_status.format(Name="TestDifferentNumberOfNodes",result="PASS")
    else:
        result = result + test_status.format(Name="TestDifferentNumberOfNodes",result="FAIL")
    pass
    return result
tests = [
    TestIdenticalGraphs,
    TestBasic,
    TestDifferentNumberOfNodes
]
for test in tests:
    print(test(IteratorScheme()))
    pass
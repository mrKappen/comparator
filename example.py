import Comparator as c
import os 
if __name__=="__main__":
    obj = c.Comparator("/home/tkappen/3ASummer/report/Palindrome_O1.ll","/home/tkappen/3ASummer/report/Palindrome_O0.ll")
    obj.use_call_graphs()
    obj.use_mem_graphs()
    obj.use_control_flow_graphs()
    obj.run()
    obj.output()           

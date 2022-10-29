
Pass  = [20, 40, 60, 80, 100, 120]
Defer = [20, 40]
Fail =  [20, 40, 60, 80, 100, 120]

def retriever():
    
    
    if Pass[3] == 80 and Defer[0] == 20 and Fail[0] == 20 :
        print("Do not Progress - module retriever\n")
    if Pass[2] == 60 and Defer[1] == 40 and Fail[0] == 20 :
        print("Do not Progress - module retriever\n")
    if Pass[1] == 40 and Defer[1] == 40 and Fail[1] == 40 :
        print("Do not Progress - module retriever\n")
    if Pass[0] == 20 and Defer[1] == 40 and Fail[2] == 60 :
        print("Do not Progress - module retriever\n")
        
         
retriever()

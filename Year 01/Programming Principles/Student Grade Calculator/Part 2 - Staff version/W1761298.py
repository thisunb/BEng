# I declare that my work contains no examples of misconduct, such as plagiarism, or collusion.
# Any code taken from other sources is referenced within my code solution.  
  
# Student ID: 17612988/1

# Date: 29.11.2019

count  = int(0)
count1 = int(0)
count2 = int(0)         
count3 = int(0)
count4 = int(0)


Pass = str(input("Enter your pass credit value:"))

while Pass != "q":      # Assigning q to terminate the program.
    
        try:                    # Qualifying the Pass value.
            Pass = int(Pass)
            if (Pass == 0) or (Pass == 20) or (Pass == 40) or (Pass == 60) or (Pass == 80) or (Pass == 100) or (Pass == 120):
                print()
                
            else:
                print("Range Error.")
                Pass = str(input("Enter your pass credit value:"))
                continue
        except ValueError:
            print("Integers required.")
            Pass = str(input("Enter your pass credit value:"))
            continue     

                
        while  True:            # Qualifying the Defer value.
            try:
                Defer = int(input("Enter your defer credit value:"))
                
                if (Defer == 0) or (Defer == 20) or (Defer == 40) or (Defer == 60) or (Defer == 80) or (Defer == 100) or (Defer == 120):
                     print()  
                     break
                    
                else:
                 print("Range Error.")
            except ValueError:
             print("Integers required.")
            

        while  True:            # Qualifying the Fail value.
            try:
                Fail = int(input("Enter your fail credit value:"))
                
                if (Fail == 0) or (Fail == 20) or (Fail == 40) or (Fail == 60) or (Fail == 80) or (Fail == 100) or (Fail == 120):
                     print()
                     break
                      
                else:
                 print("Range Error.")
            except ValueError:
             print("Integers required.")
             
            
        total = int(Pass + Defer + Fail)        # Calculating and validating the total.
        if total != 120:
            print("Total incorrect")
            Pass = str(input("Enter your pass credit value:"))
            continue
        
        else:
   
            if Pass == 120 and Defer == 0 and Fail == 0:
                print("Progress \n")
                count1 = count1 + 1
        

        def trailer(): 
            if Pass == 100 and 0 <= Defer <= 20 and 0 <= Fail <= 20:    # Defining trailer as a function. 
                print("Progress - module trailer \n")
                global count2                                           
                count2 = count2 + 1                                             
             
        trailer()    


        def retriever():
            if 0 <= Pass <= 80 and 0 <= Defer <= 120 and 0 <= Fail <= 60:       # Defining retriever as a function.
                print("Do not Progress - module retriever \n")
                global count3
                count3 = count3 + 1

        retriever()        
        
       
        def exclude():
            if 0 <= Pass <= 40 and 0 <= Defer <= 40 and 80 <= Fail <= 120:      # Defining exclude as a function.
                print ("Exclude \n")
                global count4
                count4 = count4 + 1

        exclude()        
        
        Pass = str(input("Enter your pass credit value:"))
    
count = count1 + count2 + count3 + count4                       # Displaying the histogram after the termination of the program.
print("Progress", count1 ,":", count1 * "*", "\n"
      "Trailing",count2 ,":", count2 * "*","\n"
      "Retriever",count3,":", count3 * "*","\n"
      "Excluded",count4, ":", count4 * "*","\n")

if count == 1:
    print(count,"outcome in total.")
else:
    print(count,"outcomes in total.")





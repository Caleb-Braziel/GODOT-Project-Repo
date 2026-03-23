import random
import inspect
import sys


rates = [0.5, 1, 1.5, 2, 4, 6, 8, 10, 12, 18]
label_list = []

BTN_WIDTH = 25
BTN_PAD = 12



################################################# Single Payment #################################################


def single_future_payment(F, n, i): # AKA Single Payment Present Worth
    
    question = "What is the present worth of $" + str(F) + " received " + str(n) + " years from now at an interest rate of " + str(i) + "% compounded annually?" 
    
    P = F / ((1 + (i / 100))**n)
    
    #return P
    question += '@' # symbol to separate question and answer for Godot parsing
    print(question)
    print(P)
    return P

def single_present_compound(P, n, i):
    question = "You invest $" + str(P) + " today in an account that earns "  + str(i) + "% annual interest compounded annually. What will be the future worth of this investment after " + str(n) + " years?" 
    
    F = P * ((1 + (i / 100))**n)
    
    #return P
    question += '@' # symbol to separate question and answer for Godot parsing
    print(question)
    print(F)



################################################# Uniform #################################################

def uni_A_F(A, n, i):
    
    question = "A piece of equipment requires uniform annual maintenance costs of $" + str(A) + " each year for " + str(n) + " years. If the interest rate is " + str(i) + "% per year, what is the future worth (F) of these costs at the end of year" + str(n) + "?"
    i = i / 100
    F = A * (((1 + i)**n - 1) / i)
    #return F
    question += '@' # symbol to separate question and answer for Godot parsing
    print(question)
    print(F)


def uni_P_A(P, n, i):
    
    question = "A machine costs $" + str(P) + " and has no salvage value at the end of its " + str(n) + "-year life. If the interest rate is " + str(i) + "% per year, determine the uniform annual worth (A) of the initial investment."

    
    i = i / 100
    A = P * ((i * (1 + i)**n ) / ((1+i)**n - 1))
    #return A
    question += '@' # symbol to separate question and answer for Godot parsing
    print(question)
    print(A)
    

def uni_F_A(F, n, i):
    
    question = "An investment is expected to yield a future amount of $" + str(F) + " after " + str(n) + " years. If the interest rate is " + str(i) + "% per year, what is the equivalent uniform annual amount (A) over the " + str(n) + " years?"

    
    i = i / 100
    A =  F * (i /((1 + i)**n - 1))
    #return A
    question += '@' # symbol to separate question and answer for Godot parsing
    print(question)
    print(A)

def uni_A_P(A, n, i):
    
    question = "A maintenance contract requires annual payments of $" + str(A) + " for " + str(n) + " years. If the interest rate is " + str(i) + "% per year, what is the present worth (P) of these payments?"

    
    i = i / 100
    P = A * (((1 + i)**n - 1) / (i * (1 + i)**n))
    #return P
    question += '@' # symbol to separate question and answer for Godot parsing
    print(question)
    print(P)
    
    
################################################# Salvage Value #################################################


def salvage_value(P, n, i): # AKA Capital Recovery problem
    min = P // 10
    max = P // 2
    
    sal_val = (random.randint(min, max) // 100) * 100
    
    question = "A machine costs $" + str(P) + " and has an estimated salvage value of $" + str(sal_val) + " at the end of " + str(n) + " years. If the interest rate is " + str(i) + "% per year, what is the equivalent uniform annual cost (A) of the machine?"
    i = i / 100

    
    cap_factor = ( i * (1 + i)**n ) / ((1 + i)**n -1) # Capital recovery factor
    salvage_factor = (i / ((1 + i)**n - 1 ))      
    
    #print(cap_factor)
    #print(salvage_factor)       
    
    A = (P * cap_factor) - (sal_val * salvage_factor)
    
    #return A
    question += '@' # symbol to separate question and answer for Godot parsing
    print(question)
    print(A)



################################################# Cost Benefit #################################################

def BC_one(P, n, i):
    if n < 5:
        n = 5 
        
        
    
    A_cost = random.randint(P // 20, 3 * (P // 20))
    A_benefit = random.randint(3 * (P // 20), 3 * (P // 10))
    
    question = "A highway improvement project requires an initial investment of $" + str(P) + " and annual maintenance costs of $" + str(A_cost) + " for " + str(n) + " years. "
    question += "The project is expected to generate annual benefits of $" + str(A_benefit) + " per year over the same period. " 
    question += "If the interest rate is " + str(i) + "% per year, determine the benefit–cost ratio (B/C) and decide whether the project is economically justified."

    
    PW_factor = (( (1 + i)**n - 1) / (i * (1 + i)**n)) 
    
    PW_benefit = A_benefit * PW_factor
    PW_cost = P + (A_cost * PW_factor)
    
    BC = PW_benefit / PW_cost
    
    if BC < 1:
        answer = "Not economically justified" 
    else: # Includes BC = 1 case
        answer = "Economically justified"
        
    #return answer
    question += '@' # symbol to separate question and answer for Godot parsing 
    print(question)
    print(answer)   
    
def BC_two(P_A, n, i):    
    if n < 5:
        n = 5  
        
    AA_cost = random.randint(P_A // 20, 3 * (P_A // 20))
    AA_benefit = random.randint(3 * (P_A // 20), 3 * (P_A // 10))    
    
    P_B = random.randint(int(0.8 * P_A), int(1.5 * P_A))
    
    if P_B < P_A:
        AB_cost = random.randint(3 * (P_A // 20), 4 * (P_A // 20))
        AB_benefit = random.randint(5 * (P_A // 20), 6 * (P_A // 10))
    else:
        AB_cost = random.randint(P_B // 20, 3 * (P_B // 20))
        AB_benefit = random.randint(3 * (P_B // 20), 3 * (P_B// 10)) 
        
        
        
    table = [
        ["Project", "Initial Cost ($)", "Annual Cost ($)"," Annual Benefit ($)"],
        ["@A", str(P_A), str(AA_cost), str(AA_benefit)],
        ["@B", str(P_B), str(AB_cost), str(AB_benefit)],
    ]    
    
    table_str = "@TABLE_START@"
    
    for i in range(len(table)):
        table_str += "@".join(table[i])
        
    table_str += "@TABLE_END@"      
        
        
    question = "Two road improvement alternatives, A and B, are being considered. Their costs and annual benefits are shown below."

    
    question = "The interest rate is " + str(i) + "% per year, and both projects have a " + str(n) + "-year life. Which project should be selected based on an incremental B/C analysis?"

    
    
    
    i = i / 100   
    
    PW_factor = (((1 + i)**n - 1) / (i * (1 + i)**n)) 
    
    PWA_benefit = AA_benefit * PW_factor
    PWA_cost = P_A + (AA_cost * PW_factor)
    
    PWB_benefit = AB_benefit * PW_factor
    PWB_cost = P_B + (AB_cost * PW_factor)
    
    PW_benefit = PWB_benefit - PWA_benefit
    PW_cost = PWB_cost - PWA_cost
        
    BC = PW_benefit / PW_cost
    
    print("B / C = " + str(BC)) # Checking logic for negatives  
    
    if BC < 1:
        if P_A < P_B:
            answer = "Select Alternative A"
        else:
            answer = "Select Alternative B"    
    else: # Includes BC = 1 case
        if P_A < P_B:
            answer = "Select Alternative B"   
        else:
            answer = "Select Alternative A"     
    
    print(question)
    print(table_str)
    print(answer)    
        
    #return answer    
      
        



################################################# Payback Period / Breakeven #################################################

def payback_equal(P):
    
    A = random.randint(P // 20, P // 3)

    question = "A company purchases a machine for $" + str(P) + ". It generates annual net cash inflows of $" + str(A)

    question = "What is the payback period for the machine?"

    
    n = P / A
    
    print(question)
    print(n)

def payback_unequal(P):
    
    A = []
    
    n = 0
    stay = True
    greater_year = 0
    greater_sum = 0
    
    A1 = random.randint(P // 8, P // 5)
    A.append(A1)
    sum = A1
    
    while stay != 0:
        
        A_next = A[n] + random.randint(A[n] // 6, A[n])
        sum += A_next
        A.append(A_next)
        n += 1
        
        if sum < P:
            stay = 1
        else:
            if greater_year == 0:
                greater_year = n # year where the sum is greater than P
                greater_sum = sum - A_next
                 
            if n < 6: # setting max table values to 6
                stay = random.randint(0, 3) # 50 / 50 if n continues when sum > P
            else:
                stay = 0   
    
    table = [
        ["TABLE_START","Year", "Net Cash Inflow ($)"] 
    ]
    
    for idx in range(len(A)):
        row = [str(idx + 1), str(A[idx])]
        table.append(row)    
    
    table_str = "@TABLE_START@"
    
    for i in range(len(table)):
        table_str += "@".join(table[i])
    
    table_str += "@TABLE_END@"    
    
    question = "A company is considering purchasing a new machine for $" + str(P) + ". The machine is expected to generate the following net cash inflows over the next " + str(len(A)) + "years:"
    

    
    question = "Calculate the payback period for the machine."
 
    exact_year = greater_year - 1 + ((P - greater_sum + A[greater_year]) / A[greater_year])
    
    print(question)
    print
    
    print(exact_year)
    #return exact_year
                  
def breakeven():
    
    A = random.randint(20, 100) * 100
    var_cost = random.randint(15, 60)
    sell_price = var_cost + random.randint(var_cost // 10, 2 * var_cost)
    
    question = "A company manufactures small electric fans. The company’s cost structure and selling price are as follows:"

    
    table = [
        ["Parameter", "Value"],
        ["Fixed Costs", "$" + str(A) + " per year"],
        ["Variable Cost", "$" + str(var_cost) + " per fan"],
        ["Selling Price", "$" + str(sell_price) + " per fan"]
    ]
    
    table_str = "@TABLE_START@"
    
    for i in range(len(table)):
        table_str += "@".join(table[i])
    
    table_str += "@TABLE_END@"     
    
    Q_BE = A / (sell_price - var_cost) # Break-Even Quantity
    
    units = random.choice([True, False]) # variable to determine whether answer is in dollars or units
    
    if units == True:
        question = "Determine the break-even quantity:"
        answer = Q_BE
    else:
        question = "Determine the break-even revenue:"
        answer = Q_BE * sell_price

    print(question)
    print(table_str)
    print(answer)
    #return answer


################################################# ROR / IRR #################################################

def single_ROR(P, n):
    
    F = P + random.randint(P // 10, 4 * P)
    
    question = "An engineer invests $" + str(P) + " and receives $" + str(F) + " after " + str(n) + " years. What is the rate of return?"

    
    i = (F / P)**(1 / n) - 1
    
    print(question)
    print(i * 100)
    #return i * 100
    
def uniform_ROR():
    pass

def increment_ROR():
    pass

def mixed_ROR():
    pass


################################################# Inflation / Real vs Nominal Interest Rates #################################################

def real_rate():
    d = random.randint(5, 11) # Nominal interest rate
    f = random.randint(1, 7) # inflation rate
    
    question = "If the nominal interest rate is " + str(d) + "% per year and the inflation rate is " + str(f) + "% per year, what is the real interest rate?"

    
    d = d / 100
    f = f / 100 
    
    i = ((d - f) / (1 + f)) * 100
    
    #return i * 100
    print(question)
    print(i * 100)

def nom_rate():
    i = random.randint(1, 14) / 2 # Real interest rate
    f = random.randint(1, 7) # Inflation rate
    
    question = "An investment offers a real rate of return of " + str(i) + "% per year when inflation is " + str(f) + "%. Find the nominal interest rate."

    
    i = i / 100
    f = f / 100 
    
    d = i + f + (i * f)
    
    print(question)
    print(d * 100)
    
    #return d * 100

def inflation(P, n):
    
    d = random.randint(5, 11) # Nominal interest rate
    f = random.randint(1, 7) # inflation rate
    
    d = 8
    f = 3
    P = 10000
    n = 4
    
    question = "You invest $" + str(P) + " for " + str(n) + " years at a nominal rate of " + str(d) + "%, while inflation averages " + str(f) + "% per year. Find the real future value in today’s dollars."

    
    d = d / 100
    f = f / 100
    
    F = P * (d + 1)**n
    #print(F)
    
    F_real = F / ((1 + f)**n)
    
    print(question)
    print(F_real)
    
    #return F_real
    


################################################# Loan / Sinking Fund / Mortgage Calculations #################################################

def loan(P, n, i):
    question = "A $" +  str(P) + " loan is to be repaid in equal annual payments over " + str(n) + " years at " + str(i) + "% interest."

    question = "What is the annual payment?"

    
    i = i / 100
    
    A = P * ((i * (1 + i)**n ) / ((1+i)**n - 1))
    
    print(question)
    print(A)
    
    #return A

def mortgage(P, n, i):
    question = "A $" + str(P) + " mortgage is issued at " + str(i) + "% annual interest, compounded monthly, for " + str(n) + " years."

    question = "Find the monthly payment."

    
    i = i / 100
    
    i_m = i / 12 # monthly interest
    
    N = n * 12
    
    A = P * ((i_m * (1 + i_m)**N ) / ((1+i_m)**N - 1))
    
    print(question)
    print(A)
    
    #return A
    
def sink_fund(F, n, i, frame):
    question = "You want $" + str(F) + " in " + str(n) + " years and can earn " + str(i) + "% interest per year."

    question = "How much must you deposit annually?"

    
    i = i / 100
    
    A = F * (i /((1 + i)**n - 1))
    
    print(question)
    print(A)
    #return A


################################################# Straight Line Depreciation #################################################

def SLD(P, n, frame):
    
    min = P // 10
    max = P // 2
    
    sal_val = (random.randint(min, max) // 100) * 100
    
    year = random.randint(1, n)
    
    question = "A machine costs $" + str(P) + " , has an estimated salvage value of $" + str(sal_val) + ", and a useful life of " + str(n) + " years."

    question = "Using the straight-line method, determine: "

    question = "1. The annual depreciation "

    question = "2. The book value at the end of year " + str(year)

    
    D = (P - sal_val) / n
    BV = P - (D * year)
    
    answer = "Annual Depreciation: " + str(D) + "Book Value: " + str(BV) # rework answer formatting for Godot parsing
    print(question)

    #return answer


################################################# Main For Questions #################################################

def question_maker(min, max):
    function_names = [
        # Single Payment (0 - 1)
        single_future_payment,
        single_present_compound,

        # Uniform (2 - 5)
        uni_A_F,
        uni_P_A,
        uni_F_A,
        uni_A_P,

        # Salvage Value (6)
        salvage_value,

        # Cost Benefit (7 - 8)
        BC_one,
        BC_two,

        # Payback Period / Breakeven (9 - 11)
        payback_equal,
        payback_unequal,
        breakeven,

        # ROR / IRR (12)
        single_ROR, 
        # uniform_ROR,
        # increment_ROR,
        # mixed_ROR,

        # Inflation / Real vs Nominal Interest Rates (13 - 15)
        real_rate,
        nom_rate,
        inflation,

        # Loan / Sinking Fund / Mortgage Calculations (16 - 18)
        loan,
        mortgage,
        sink_fund,

        # Straight Line Depreciation (19)
        SLD
    ]
    

    amount = (random.randint(100, 100001) // 100) * 100
    years = random.randint(1, 21)
    interest = random.choice(rates)
        
    
    if min == max:    
        test = min
    else:    
        test = random.randint(min,max)
    
    func = function_names[test]
    
    param_num = len((inspect.signature(func)).parameters)

    # commented out as fixing integration into Godot    
    if param_num == 3:
        func(amount, years, interest)
    elif param_num  == 2:
        func(amount, years)
    elif param_num  == 1:
        func(amount)
    else:
        print("Error: Function has incorrect number of parameters.")

    func(amount, years, interest)
        
        

def test():
    print("Made it here")
    return "Cool" 


#test()  
args = sys.argv
min = int(args[1])
max = int(args[2])
question_maker(min, max) # testing single future payment question generation  

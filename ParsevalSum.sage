from IPython.display import display, Math, Latex



### Compute zeta values



def matrix_entry(i,j):
    # Creates a matrix entry.
    return factorial(j)/factorial(j-i+1) if i<=j else 0

def build_matrix(A):
    # Builds the A x A coefficient matrix.
    return matrix([[matrix_entry(i,j) for j in range(A,0,-1)] for i in range(A,0,-1)])

def build_col_matrix(A):
    # Builds the column vector.
    return vector([-(2*pi*I)^A if i == 0 else 0 for i in range(A)])

def solve_system(A):
    # Row-reduces the coefficient matrix augmented with the column vector.
    return (build_matrix(A).inverse()*build_col_matrix(A))[::-1]

def required_function_zeta(S, tex = False):
    # Outputs the required function f; input a second parameter "True" for LaTeX, "False" for plain text.
    assert S%2 == 0 and S>0
    A = Integer(S/2)
    L = solve_system(A)
    x = var('x')
    if tex:
        S = 0
        for i in range(0,len(L)):
            S += L[i]*x^(i+1)
        display(Math(latex(S)))
        return None
    else:
        S = 0
        for i in range(0,len(L)):
            S += L[i]*x^(i+1)
        return S

def integral_square(L):
    # Computes the integral of |f|^2.
    A = len(L)
    S = 0
    for n in range(1,A+1):
        for m in range(1,A+1):
            S += L[m-1]*conjugate(L[n-1])/(m + n + 1)
    return S

def integral_of(L):
    # Computes the integral of f.
    A = len(L)
    S = 0
    for n in range(1,A+1):
        S += L[n-1]/(n + 1)
    return S

def SUM_zeta(S, tex = False):
    # Computes the exact value of zeta(S); input a second parameter "True" for LaTeX, "False" for plain text.
    assert S%2 == 0 and S>0
    A = Integer(S/2)
    solved_system = solve_system(A)
    value = (1/2)*integral_square(solved_system) - (1/2)*(abs(integral_of(solved_system)))^2
    if tex:
        display(Math(latex(value)))
        return None
    else:
        return value



### Non-negative rational functions



R.<n> = PolynomialRing(QQbar)

def exp_no_trig(expression):
    # This function avoids expressing the exact value in terms of hyperbolic trig functions.
    return exp(expression,hold=True).canonicalize_radical().unhold()

def f_hat(rational_function):
    # Determines f-hat such that g = |f-hat|^2.
    factored = factor(rational_function)
    L = list(factored)
    factored_unit = factored.unit()
    if factored_unit < 0:
        factored_unit = -factored_unit
    T = QQbar(sqrt(factored_unit))
    assert parent(T) is QQbar
    while L != []:
        Elem = L[0]
        R = QQbar(n - Elem[0])
        Expo = Elem[1]
        if R == conjugate(R):
            if Expo%2 == 1:
                raise ValueError('Rational function is not non-negative nor non-positive.  Use rational_SUM_1() or rational_SUM_2() instead.')
            else:
                L.remove((n - R, Expo))
                T *= (n - R)^(Expo/2)
        else:
            L.remove((n - R, Expo))
            L.remove((n - conjugate(R), Expo))
            T *= (n - R)^ceil(Expo/2)*(n - conjugate(R))^floor(Expo/2)
    f_hat_function = T
    return f_hat_function

def get_part_frac(f_hat_expression):
    # Decomposes f-hat into its partial fractions.
    decomp = f_hat_expression.partial_fraction_decomposition()
    assert decomp[0] == 0
    return decomp[1]
    
def get_coeff_A_r(rational_expression):
    # Finds "coeff," "A," and "r" for each partial fraction (coeff) / (r - 2*pi*I*n)^(A+1).
    A = R(1/rational_expression).degree() - 1
    try:
        coeff = (QQbar(rational_expression.numerator())).radical_expression()*(-2*pi*I)^(A+1)
    except TypeError:
        raise Exception((QQbar(rational_expression.numerator())).radical_expression()) # There are some rational functions for which Sage cannot express the factors in terms of radicals.
    r = (2*pi*I)*((rational_expression.denominator().roots())[0][0]).radical_expression()
    return A, coeff, r

def matrix_entry_2(i,j,r):
    # Creates a metrix entry.
    if i<j:
        return factorial(j-1)*(exp_no_trig(r))/factorial(j-i)
    elif i == j:
        return factorial(j-1)*(exp_no_trig(r)-1)
    else:
        return 0

def build_matrix_2(A,r):
    # Builds the (A+1) x (A+1) coefficient matrix.
    return matrix([[matrix_entry_2(i,j,r) for j in range(A+1,0,-1)] for i in range(A+1,0,-1)])

def build_col_matrix_2(A):
    # Builds the column vector.
    return vector([(-1)^A if i == 0 else 0 for i in range(A+1)])

def solve_system_2(A,r):
    # Row-reduces the coefficient matrix augmented with the column vector.
    return (build_matrix_2(A,r).inverse()*build_col_matrix_2(A))[::-1]

def function_of_x(pfd_list, symbolic = True):
    # Builds the required function f; the second parameter is explained in the next function.
    x = var('x')
    if symbolic:
        S = 0
        for i in pfd_list:
            A,coeff,r = get_coeff_A_r(i)
            L = solve_system_2(A,r)
            for j in range(0,A+1):
                S += coeff*L[j]*x^j*exp_no_trig(r*x)
        return S
    else:
        T = []
        for i in pfd_list:
            A,coeff,r = get_coeff_A_r(i)
            L = solve_system_2(A,r)
            for j in range(0,A+1):
                T.append((coeff*L[j], j, r))
        return T
    
def required_function(summand, symbolic = True, tex = False):
    # Outputs the required function f; input a second parameter "True" to express the function normally, "False" to express the function as the numbers required to build it; input a third parameter "True" for LaTeX, "False" for plain text.
    final_function = function_of_x(get_part_frac(f_hat(summand)), symbolic)
    if tex:
        display(Math(latex(final_function)))
        return None
    else:
        return final_function
    
def exact_sum(tuple_list):
    # Computes and builds the exact value of the series.
    S = 0
    for i in tuple_list:
        for j in tuple_list:
            N = i[2]+conjugate(j[2])
            if N != 0:
                M = 0
                Temp = (exp_no_trig(N)-1)/N
                while M < i[1]+j[1]:
                    M += 1
                    Temp = exp_no_trig(N)/N - M*Temp/N
                S += i[0]*conjugate(j[0])*Temp
            else:
                S += i[0]*conjugate(j[0])/(i[1]+j[1]+1)
    return S

def SUM(summand, approx = True, tex = False):
    # Outputs the exact value of the series; input a second parameter "True" to display an approximation, "False" to hide the approximation; input a third parameter "True" for LaTeX, "False" for plain text.
    unit_sign = 1
    if summand == 0 and tex:
        display(Math(latex(0)))
        return None
    if summand == 0 and not tex:
        return 0
    if (factor(summand)).unit() < 0:
        unit_sign = -1
    if tex:
        answer = (abs(exact_sum(required_function(summand,False,False))).canonicalize_radical())*(unit_sign)
        if approx:
            display(Math(latex(answer.n(200))))
        display(Math(latex(answer)))
        return None
    else:
        answer = (abs(exact_sum(required_function(summand,False,False))).canonicalize_radical())*(unit_sign)
        if approx:
            print(answer.n(200))
        return answer



### General rational functions (linear combination)



def required_lin_comb(rational_expression, tex = False):
    # Expresses the summand as a linear combination of non-negative and non-positive rational functions; input a second parameter "True" for LaTeX, "False" for plain text.
    numer = rational_expression.numerator()
    denom = rational_expression.denominator()
    product = numer*denom
    coeff_list = []
    for i in range(0,product.degree()+1):
        if product[i] != 0:
            coeff_list.append([product[i], i])
    nonneg_list = []
    for i in coeff_list:
        if i[1]%2 == 1:
            nonneg_list.append((i[0]*(n^(i[1]+1)+n^(i[1])+n^(i[1]-1)))/((denom)^2))
            nonneg_list.append((-i[0]*(n^(i[1]+1)))/((denom)^2))
            nonneg_list.append((-i[0]*(n^(i[1]-1)))/((denom)^2))
        else:
            nonneg_list.append((i[0]*(n^(i[1])))/((denom)^2))
    if tex:
        display(Math(latex(nonneg_list)))
        return None
    else:
        return nonneg_list

def SUM_rational_1(rational_expression, sub_approx = False, tex = False):
    # Outputs the exact value of the series; input a second parameter "True" to display approximate values each time a non-negative or non-positive rational function is fed into the SUM function, "False" to hide the approximations; input a third parameter "True" for LaTeX, "False" for plain text.
    list_of_nonneg = required_lin_comb(rational_expression)
    answer = 0
    for i in list_of_nonneg:
        answer += SUM(i, sub_approx)
    print(answer.n(200))
    if tex:
        display(Math(latex((answer).canonicalize_radical())))
        return None
    else:
        return (answer).canonicalize_radical()



### General rational functions (difference of two)



def difference_of_two(rational_expression, tex = False):
    # Expresses the summand as a sum of a non-negative rational function and a non-positive rational function; input a second parameter "True" for LaTeX, "False" for plain text.
    numer = rational_expression.numerator()
    denom = rational_expression.denominator()
    product = numer*denom
    coeff_list_pos = []
    coeff_list_neg = []
    for i in range(0,product.degree()+1):
        if product[i] != 0:
            if product[i] > 0:
                coeff_list_pos.append([product[i], i])
            else:
                coeff_list_neg.append([product[i], i])
    nonneg_part = 0
    nonpos_part = 0
    for i in coeff_list_pos:
        if i[1]%2 == 1:
            nonneg_part += ((i[0]*(n^(i[1]+1)+n^(i[1])+n^(i[1]-1)))/((denom)^2))
            nonpos_part += ((-i[0]*(n^(i[1]+1))-i[0]*(n^(i[1]-1)))/((denom)^2))
        else:
            nonneg_part += ((i[0]*(n^(i[1])))/((denom)^2))
    for i in coeff_list_neg:
        if i[1]%2 == 1:
            nonpos_part += ((i[0]*(n^(i[1]+1)+n^(i[1])+n^(i[1]-1)))/((denom)^2))
            nonneg_part += ((-i[0]*(n^(i[1]+1))-i[0]*(n^(i[1]-1)))/((denom)^2))
        else:
            nonpos_part += ((i[0]*(n^(i[1])))/((denom)^2))
    if tex:
        display(Math(latex([nonneg_part,nonpos_part])))
        return None
    else:
        return [nonneg_part,nonpos_part]

def SUM_rational_2(rational_expression, sub_approx = False, tex = False):
    # Outputs the exact value of the series; input a second parameter "True" to display approximate values when the non-negative and non-positive rational functions are fed into the SUM function, "False" to hide the approximations; input a third parameter "True" for LaTeX, "False" for plain text.
    list_of_nonneg = difference_of_two(rational_expression)
    answer = 0
    for i in list_of_nonneg:
        answer += SUM(i, sub_approx)
    print(answer.n(200))
    if tex:
        display(Math(latex((answer).canonicalize_radical())))
        return None
    else:
        return (answer).canonicalize_radical()


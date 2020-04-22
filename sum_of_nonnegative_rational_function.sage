from IPython.display import display, Math, Latex
from sympy import Sum, Symbol

R.<n> = PolynomialRing(QQbar)

def exp_no_trig(expression):
    return exp(expression,hold=True).canonicalize_radical().unhold()

def f_hat(rational_function):
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
                raise ValueError('Rational function is not nonnegative')
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
    decomp = f_hat_expression.partial_fraction_decomposition()
    assert decomp[0] == 0
    return decomp[1]
    
def get_coeff_A_r(rational_expression):
    A = R(1/rational_expression).degree() - 1
    try:
        coeff = (QQbar(rational_expression.numerator())).radical_expression()*(-2*pi*I)^(A+1)
    except TypeError:
        raise Exception((QQbar(rational_expression.numerator())).radical_expression())
    r = (2*pi*I)*((rational_expression.denominator().roots())[0][0]).radical_expression()
    return A, coeff, r

def matrix_entry_2(i,j,r):
    if i<j:
        return factorial(j-1)*(exp_no_trig(r))/factorial(j-i)
    elif i == j:
        return factorial(j-1)*(exp_no_trig(r)-1)
    else:
        return 0

def build_matrix_2(A,r):
    return matrix([[matrix_entry_2(i,j,r) for j in range(A+1,0,-1)] for i in range(A+1,0,-1)])

def build_col_matrix_2(A):
    return vector([(-1)^A if i == 0 else 0 for i in range(A+1)])

def solve_system_2(A,r):
    return (build_matrix_2(A,r).inverse()*build_col_matrix_2(A))[::-1]

def function_of_x(pfd_list, symbolic = True):
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
    
def required_function(summand, symbolic = True, tex = True):
    final_function = function_of_x(get_part_frac(f_hat(summand)), symbolic)
    if tex:
        display(Math(latex(final_function)))
        return None
    else:
        return final_function
    
def exact_sum_2(tuple_list, symbolic = True):
    #Inputs tuples (coeff, A, r), outputs the calculated integral of the norm-squared of f(x).
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
    if symbolic:
        final_exact_sum = S
        display(Math(latex(S)))
        return None
    else:
        final_exact_sum = S
        return S

def SUM(summand, approx = True, symbolic = False):
    unit_sign = 1
    if (factor(summand)).unit() < 0:
        unit_sign = -1
    if summand == 0 and symbolic:
        display(Math(latex(0)))
        return None
    elif summand == 0 and not symbolic:
        return 0
    elif symbolic:
        answer = (abs(exact_sum_2(required_function(summand,False,False),False)).canonicalize_radical())*(unit_sign)
        if approx:
            display(Math(latex(answer.n(200))))
        display(Math(latex(answer)))
        return None
    else:
        answer = (abs(exact_sum_2(required_function(summand,False,False),False)).canonicalize_radical())*(unit_sign)
        if approx:
            print(answer.n(200))
        return answer
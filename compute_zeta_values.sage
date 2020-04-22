from IPython.display import display, Math, Latex


def matrix_entry(i,j):
    return factorial(j)/factorial(j-i+1) if i<=j else 0

def build_matrix(A):
    return matrix([[matrix_entry(i,j) for j in range(A,0,-1)] for i in range(A,0,-1)])

def build_col_matrix(A):
    return vector([-(2*pi*I)^A if i == 0 else 0 for i in range(A)])

def solve_system(A):
    return (build_matrix(A).inverse()*build_col_matrix(A))[::-1]

def function_of_x_1(S, tex = False):
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
    A = len(L)
    S = 0
    for n in range(1,A+1):
        for m in range(1,A+1):
            S += L[m-1]*conjugate(L[n-1])/(m + n + 1)
    return S

def integral_of(L):
    A = len(L)
    S = 0
    for n in range(1,A+1):
        S += L[n-1]/(n + 1)
    return S

def exact_sum(S, tex = False):
    assert S%2 == 0 and S>0
    A = Integer(S/2)
    solved_system = solve_system(A)
    value = (1/2)*integral_square(solved_system) - (1/2)*(abs(integral_of(solved_system)))^2
    if tex:
        display(Math(latex(value)))
        return None
    else:
        return value

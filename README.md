# ParsevalSum

This SageMath code calculates the exact sum of an infinite series using Parseval's identity.  SageMath version 9.0 or higher is recommended.

To use this file, enter the code within a SageMath cell.  The following list of functions are used for the calculation:

"function_of_x_1(A, B)": input a number into "A" to determine the function of x such that the sum of |f-hat(n)|^2 over the integers is equal to the integral of |f(x)|^2 over [0,1], but only positive even integers are able to be handled.  If your SageMath software supports LaTeX, input "True" into "B" to display the function in LaTeX (the function defaults this parameter to "False" if no input is given).

Example: entering "function_of_x_1(2)" outputs "-2 * I * pi * x."

"exact_sum(A, B)": input a number s into "A" to compute zeta(s), but only positive even integers are able to be handled.  If your SageMath software supports LaTeX, input "True" into "B" to display the function in LaTeX (the function defaults this parameter to "False" if no input is given).

Example: entering "exact_sum(4, True)" outputs "1/90 * pi^4" in LaTeX format.

"required_function(A, B, C)": input a rational function of n into "A" to determine the function of x such that the sum of |f-hat(n)|^2 over the integers is equal to the integral of |f(x)|^2 over [0,1], but only non-negative or non-positive rational expressions can be handled.  The function defaults the parameter "B" to "True" if no input is given.

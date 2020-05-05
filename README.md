# ParsevalSum


This SageMath code calculates the exact sum of an infinite series using Parseval's identity.  SageMath version 9.0 or higher is recommended.


To use this file, enter the code within a SageMath cell.  The use can use following list of functions for the calculation.  Within this list, a function's name is in quotes, as well as its parameters A, B, C.  Each parameter is described below the function.  Some parameters have a default value, meaning providing no input into the parameter yields the pre-assigned value automatically.


"required_function_zeta(A, B)":

A (no default value): Input a number determine the function of x such that the sum of |f-hat(n)|^2 over the integers is equal to the integral of |f(x)|^2 over [0,1], but only positive even integers are able to be handled.

B (False by default): Input "True" to display the function in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays the function in standard text.


Example: entering "required_function_zeta(2)" outputs "-2 * I * pi * x."


"SUM_zeta(A, B)":

A (no default value): Input a number to compute the zeta value of that number, but only positive even integers are able to be handled.

B (False by default): Input "True" to display the value in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays the value in standard text.


Example: entering "SUM_zeta(4, True)" outputs "1/90 𝜋^4" in LaTeX format.


"required_function(A, B, C)":

A (no default value): Input a rational function of n to determine the function f such that the sum of |f-hat(n)|^2 over the integers is equal to the integral of |f(x)|^2 over [0,1], but only non-negative or non-positive rational expressions can be handled.

B (True by default): "True" displays the function normally in terms of x.  Input "False" to see the ordered tuple(s) of values (coefficient, degree, root) used to build the function f.

C (False by default): Input "True" to display the function in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays the function in standard text.  To input "True," type "tex = True" or include an explicit input for B.


Example: entering "required_function(1/(n^2 + 1), True, True)" outputs the function "−(2𝑖𝜋𝑒^(2𝜋𝑥)) / (𝑒(2𝜋)−1)" in LaTeX format.


"SUM(A, B, C)":

A (no default value): Input a rational function of n to compute its sum over the integers, but only non-negative or non-positive rational expressions can be handled.

B (True by default): "True" displays the decimal approximation of the sum before the exact value of the sum.  Input "False" to hide the approximation.

C (False by default): Input "True" to display the sum in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays the sum in standard text.  To input "True," type "tex = True" or include an explicit input for B.


Example: entering "SUM(1/(n^2 + 1))" outputs "3.1533480949371623482681015895000009808913125328076333311501" followed by "pi * (e^(2 * pi) + 1) / (e^(2 * pi) - 1)."


"required_lin_comb(A, B)":

A (no default value): Input any rational function of n to find a list (linear combination) of non-negative and non-positive rational functions equivalent to the input when added together.

B (False by default): Input "True" to display the list in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays the list in standard text.


Example: entering "required_lin_comb(1/(3 * n^3 + 1))" outputs "[1/9/(n^6 + 2/3 * n^3 + 1/9), (1/3 * n^4 + 1/3 * n^3 + 1/3 * n^2)/(n^6 + 2/3 * n^3 + 1/9),  (-1/3 * n^4)/(n^6 + 2/3 * n^3 + 1/9),  (-1/3 * n^2)/(n^6 + 2/3 * n^3 + 1/9)]."


"SUM_rational_1(A, B, C)":

A (no default value): Input any rational function of n to find its sum over the integers.

B (False by default): Input "True" to display the approximate sum of each non-negative rational function within the linear combination.  This can also be used to gage the function's progress.  Otherwise, "False" hides the approximations.

C (False by default): Input "True" to display the final sum in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays the sum in standard text.  To input "True," type "tex = True" or include an explicit input for B.


Example: entering "SUM_rational_1(1/(n^2 - 3/2))" outputs "-3.0082248408742298898189201508281522147399096789435318883944" followed by "-1/3 * (2 * (sqrt(3) * sqrt(2) * pi * cos(sqrt(3) * sqrt(2) * pi) - sqrt(3) * sqrt(2) * pi) * cos(2 * sqrt(3) * sqrt(2) * pi) * sin(sqrt(3) * sqrt(2) * pi) - (sqrt(3) * sqrt(2) * pi * cos(sqrt(3) * sqrt(2) * pi)^2 - sqrt(3) * sqrt(2) * pi * sin(sqrt(3) * sqrt(2) * pi)^2 - 2 * sqrt(3) * sqrt(2) * pi * cos(sqrt(3) * sqrt(2) * pi) + sqrt(3) * sqrt(2) * pi) * sin(2 * sqrt(3) * sqrt(2) * pi) - 2 * (sqrt(3) * sqrt(2) * pi * cos(sqrt(3) * sqrt(2) * pi) - sqrt(3) * sqrt(2) * pi) * sin(sqrt(3) * sqrt(2) * pi))/(cos(sqrt(3) * sqrt(2) * pi)^4 + sin(sqrt(3) * sqrt(2) * pi)^4 - 4 * cos(sqrt(3) * sqrt(2) * pi)^3 + 2 * (cos(sqrt(3) * sqrt(2) * pi)^2 - 2 * cos(sqrt(3) * sqrt(2) * pi) + 1) * sin(sqrt(3) * sqrt(2) * pi)^2 + 6 * cos(sqrt(3) * sqrt(2) * pi)^2 - 4 * cos(sqrt(3) * sqrt(2) *pi) + 1)"


"difference_of_two(A, B)":

A (no default value): Input any rational function of n to find a non-negative rational functions and a non-positive rational function whose sum is equivalent to the input.

B (False by default): Input "True" to display the two rational functions in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays them in standard text.


Example: entering "difference_of_two(1/(n^3 + 2))" outputs "[(n^4 + n^3 + n^2 + 2)/(n^6 + 4 * n^3 + 4), (-n^4 - n^2)/(n^6 + 4 * n^3 + 4)]."


"SUM_rational_2(A, B, C)":

A (no default value): Input any rational function of n to find its sum over the integers.

B (False by default): Input "True" to display the approximate sum of the non-negative rational function and the non-positive rational function.  This can also be used to gage the function's progress.  Otherwise, "False" hides the approximations.

C (False by default): Input "True" to display the final sum in LaTeX (if your SageMath software supports LaTeX).  Otherwise, "False" displays the sum in standard text.  To input "True," type "tex = True" or include an explicit input for B.


Example: entering "SUM_rational_2(1/(3 * n^3 + 1))" outputs "4/243 * sqrt(3) * pi^3."



When entering certain inputs, the following possible errors may occur:


"DivisionByZero": the input has a pole at an integer.

"ValueError": the input is not a non-negative nor non-positive rational function (when using "SUM(A, B, C)").

"AssertionError": the input is not summable over the integers (if this occurred when calculating a zeta value, then the number is not a positive even integer).

"TypeError": Sage cannot express the factorization of the input in terms of radicals (the offending factor also raises an exception).

"RuntimeError": Sage cannot handle the number of computations.

# THE ENERGYNATOR
This is a model that applies random sampling and lineal optimization to a table of products and prices of energy drinks on a supermarket catalog, taking an input price value and applying a small coins machine commission.

## HOW TO USE THE MODEL
An input value is written on _importecald_ (on euro cents).
The _comis_ variable is has a fixed value and gives the _importevale_ product, that's the value of the redeemable voucher.
The code then returns and output table with the specific catalog products with their individual quantitites and prices, that have to be bought in order to be equal to the _importevale_ product (the voucher).

### WHAT THIS MODEL ACTUALLY DOES
*THE ENERGYNATOR* imports a local table on .csv, .xml, .xlsx... formats, separates columns into the string values column vector _nombres_ and the numeric values columns vector _precios_, then does a random sampling _combiRandom_ of vector precios resulting on a subset _preciosSubconjunto_ with equal _precios_ length.

Each price value on _preciosSubconjunto_ is assigned by _varsSubconjunto_ to an integer variable _x_, with _x_ going from 0 to _n_, on array format. This is the general modeling of the optimizable lineal function:

_solucion_(_preciosSubconjunto_,_varsSubconjunto_) = _Sum((c_i)*(x_i)) from i=1 to n = (c_1)*(x_1) + (c_2)*(x_2) + ... +  (c_n)*(x_n)_

Then the restrictions _restriccionNeg_, _restriccionCantidad_, and _restriccionEntera_ are considered:
_restriccionNeg_ and _restriccionEntera_ define _solucion_ as a natural (non-negative integer) number set, while _restriccionCantidad_ define the maximum of the natural number _x_, that's the domain of the _solucion_ lineal sum function starting from 0. _restriccionCantidad_ can be manually modified to set the maximum of different catalog products to buy.

All these restrictions are put within the _LinearOptimization_ Wolfram Mathematica built-in function.

At the time of reporting the results, the function _solucion_ gives an array of format "_x[p_i]->x_i_", where _p_i_ being the position of each value in _preciosSubconjunto_, _x_ is the bounded integer-valued decision variables vector, and _x_i_ is the output value telling how many units of each _preciosSubconjunto_ product with _x_i_ greater then zero, to buy.

This format is cleaned and expressed to vector form _{x_1,x_2...,x_n}_ with the _Flatten_ built-in Mathematica function by the _indicesActivos_ variable. Now we have the _solucion_ solution vector.

The table _datos_ is called as a function of _indicesActivos_, assigning each of the _solucion_ values on the vector, to its corresponding string value of the column vector _nombres_ by the _nombresElegidos_ variable.
In the same way, the _preciosElegidos_ variable is made based on the same principle, to assign each _indicesActivos_ value to this variable.
A third variable _cantidadComprar_ is assigned as a product of each _indicesActivos_ value times its _solucion_ output value, that tells how many units to buy which are greater than zero.

The result is then reported, with the _Print_ function that writes the _"Hoy tienes que comprar: "_ message and then makes a visual table with the rows representing name, quantity and price of each product, so on each column the product and its information can be easily read and interpreted.

A simple arithmetic sum can be made manually to check that the prices are equal to the input variable product _importecald_*_comis_.


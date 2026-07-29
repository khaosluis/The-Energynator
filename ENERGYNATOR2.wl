(* ::Package:: *)

(* ::Input:: *)
(*(*ENERGYNATOR: EL PROGRAMA QUE CALCULA COMBINACIONES ALEATORIAS DE UNA TABLA PRECONSTRUIDA DE REFRESCOS Y BEBIDAS ENERG\[CapitalEAcute]TICAS DEL CAT\[CapitalAAcute]LOGO WEB DE CARREFOUR,CUYA SUMA ES EXACTA AL IMPORTE RESULTANTE DE INTRODUCIR CALDERILLA (importecald) EN LA M\[CapitalAAcute]QUINA DE CANJE 'COINSTAR', QUE APLICA UNA COMISI\[CapitalOAcute]N DEL 10.99% SOBRE EL IMPORTE APICADO (importevale) *)*)


(* ::Input:: *)
(*importecald=220; comis=0.8901; (*AQU\[CapitalIAcute] SE INTRODUCE MANUALMENTE EL IMPORTE NETO (EN C\[CapitalEAcute]NTIMOS DE EURO), LISTO PARA INTRODUCIR EN LA M\[CapitalAAcute]QUINA DE CALDERILLA*)*)


(* ::Input:: *)
(*importevale=Round[importecald*comis] (*SE DEDUCE LA COMISI\[CapitalOAcute]N DEL IMPORTE DE ENTRADA, GENERANDO UN SEGUNDO IMPORTE CON LA COMISI\[CapitalOAcute]N APLICADA. ES NUESTRO VALE CANJEABLE*)*)


(* ::Input:: *)
(*(*IMPORTACI\[CapitalOAcute]N DE LA TABLA*)*)


(* ::Input:: *)
(*datos=Import["tablaenergynator3.xlsx",{"Data",1}];*)
(**)


(* ::Input:: *)
(*(*VISUALIZACI\[CapitalOAcute]N DE LA TABLA PRODUCTO-PRECIO*)*)


(* ::Input:: *)
(*datos//TableForm*)


(* ::Input:: *)
(*(*EXTRACCI\[CapitalOAcute]N DE LA COLUMNA DE PRECIOS (precios) COMO VECTOR DE DIMENSI\[CapitalOAcute]N=\.08<N\.ba PRODUCTOS>*)*)


(* ::Input:: *)
(*precios=datos[[2 ;;, 2]];*)


(* ::Input:: *)
(**)
(*(*MISMO PROCEDIMIENTO PARA EL VECTOR nombres EN nombreslimp. AQU\[CapitalIAcute], NECESARIAMENTE Dim(precios)==Dim(nombres)*)*)
(*nombres=datos[[2 ;;,1]];*)


(* ::Input:: *)
(*(*COMPROBACI\[CapitalOAcute]N DE LA DIMENSIONALIDAD*)*)


(* ::Input:: *)
(*Length[nombres]==Length[precios]*)


(* ::Input:: *)
(*(*HAREMOS UN MUESTREO ALEATORIO CON REEMPLAZO DEL MISMO TAMA\[CapitalNTilde]O QUE EL VECTOR DE PRECIOS*)*)
(*combiRandom=RandomChoice[Range[Length[precios]],Length[precios]];*)
(*preciosSubconjunto=precios[[combiRandom]];*)


(* ::Input:: *)
(*(*ASIGNAMOS A CADA VARIABLE DEL SUBCONJUNTO MUESTREADO UNA VARIABLE ENTERA x, DE 0 A n, (NO SE COMPRAN/SE COMPRAN n UNIDADES)*)*)


(* ::Input:: *)
(*varsSubconjunto=Array[x,Length[precios]];*)
(*(*CONSTRUCCI\[CapitalOAcute]N DE LAS RESTRICCIONES RELATIVAS AL MODELO*)*)
(*restriccionNeg=Thread[varsSubconjunto>=0]; (*LOS PRECIOS NO PUEDEN SER VALORES NEGATIVOS*)*)


(* ::Input:: *)
(*restriccionCantidad=Thread[Total[varsSubconjunto]<=3]; (*L\[CapitalIAcute]MITE DE COMBINACIONES ENTRE PRODUCTOS DIFERENTES. MODIFICABLE A GUSTO*)*)


(* ::Input:: *)
(*restriccionEntera=Element[varsSubconjunto,Integers]; (*LOS PRECIOS HAN DE SER VALORES ENTEROS (NO PODEMOS COMPRAR MEDIO PRODUCTO)*)*)
(*(*CONSTRUIMOS LA FUNCI\[CapitalOAcute]N DE OPTIMIZACI\[CapitalOAcute]N LINEAL PARA LA MUESTRA SELECCIONADA*)*)
(*solucion=LinearOptimization[*)
(*preciosSubconjunto . varsSubconjunto,*)
(*{*)
(*precios . varsSubconjunto==importevale,*)
(*Element[varsSubconjunto,Integers],*)
(**)
(*Thread[varsSubconjunto>=0],*)
(*Thread[Total[varsSubconjunto]>=3]*)
(**)
(*},*)
(*varsSubconjunto*)
(*];*)


(* ::Input:: *)
(*solucion*)
(*(*REPORTE RESULTADOS*)*)


(* ::Input:: *)
(*indicesActivos=Flatten[Position[Values[solucion],_?(#>0&)]];(*SE EXTRAEN LOS VALORES MAYORES A 0 EN LA VARIABLE ENTERA x), Y LOS VALORES DEL VECTOR PRECIOS DEL SUBCONJUNTO QUE MULTIPLICAN A LOS VALORES n SE EXPRESAN EN FORMA DE VECTOR SOLUCI\[CapitalOAcute]N*)*)
(*nombresElegidos=datos[[indicesActivos+1,1]]; (*SE ASIGNA CADA UNO DE ESOS VALORES A SU RESPECTIVO VALOR CADENA QUE REPRESENTA EL NOMBRE DE ESE PRODUCTO*)*)


(* ::Input:: *)
(*preciosElegidos=datos[[indicesActivos+1,2]]; (*DE LA MISMA FORMA, SE ASIGNAN LOS VALORES OBTENIDOS A LOS PRECIOS DE ESOS PRODUCTOS*)*)


(* ::Input:: *)
(*cantidadComprar=Values[solucion][[indicesActivos]]; (*SE EXPRESA LA CANTIDAD n DE PRODUCTOS A COMPRAR CON SU PRECIO RESPECTIVO YA ASIGNADO*)*)


(* ::Input:: *)
(*(*SE IMPRIME LA ORDEN "Hoy tienes que comprar..." SEGUIDA DE UNA TABLA CON LOS NOMBRES DE CADA PRODUCTO, LA CANTIDAD A COMPRAR DE CADA UNO Y SUS RESPECTIVOS PRECIOS CONVERTIDOS DESDE C\[CapitalEAcute]NTIMOS DE EURO, A EUROS*)*)
(*Print["Hoy tienes que comprar: ",TableView[{nombresElegidos,cantidadComprar,preciosElegidos/100},ItemSize->{30,1},ImageSize->Full]]*)

@echo off
title Algorithme de Dantzig
setlocal EnableDelayedExpansion
:choixZ

cls
SET ZY=0
SET ZX=0
	SET /P ZX=Entrez la valeur X de la fonction Z (exemple : 3 ou -3) :
	SET /P Zcoeff=Entrez le signe math‚matique de la fonction Z (exemple : + ou - ) :
	SET /P ZY=Entrez la valeur Y de la fonction Z (exemple : 3 ou -3) :
echo.
	echo Voici la formule Z : %ZX%x %Zcoeff% %ZY%y
echo.
	echo 1- Oui
	echo 2- Non  
echo.
	SET /P confirmationZ= Est-ce bien cela ? :
	if %confirmationZ%==1 ( goto ApresZ ) else if %confirmationZ%==2 ( goto choixZ ) else ( echo choix incorrect, retour vers choixZ && timeout -t 4 > nul && goto choixZ )

:ApresZ
echo.
SET /P nbContraintes=Entrez le nombre de contraintes ( exemple 2 ) :
echo.
set /a "v=0"

:NbContraintes
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
echo.
SET /P VariableContrainteX%v%= Entrez la valeur de X de la contrainte %v% :
SET /P VariableContrainteCoeff%v%= Entrez la valeur du coefficient de la contrainte %v% :
SET /P VariableContrainteY%v%= Entrez la valeur de Y de la contrainte %v% : 
SET /P VariableContraintePartieDeDroite%v%= Entrez le resultat de la contrainte %v% : 
goto NbContraintes )
pause

set /a "v=0"

:AffichageFormesCanonique
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
echo.
echo la contrainte %v% est : !VariableContrainteX%v%!x !VariableContrainteCoeff%v%! !VariableContrainteY%v%!y = !VariableContraintePartieDeDroite%v%!
goto AffichageFormesCanonique )
pause
set /a "v=0"
goto CalculFormesStandard

:CalculFormesStandard
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
set z%v% = !VariableContraintePartieDeDroite%v%!
goto CalculFormesStandard )
pause
set /a "v=0"

:AffichageFormesStandard
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
echo.
echo z%v%
goto AffichageFormesStandard )
pause

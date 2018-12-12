@echo on
title Algorithme de Dantzig
setlocal EnableDelayedExpansion
:choixZ

cls
SET ZY=0
SET ZX=0
	SET /P ZX=Entrez  la  valeur  X  de  la  fonction  Z ( exemple : 3 ou -3 )  : 
	SET /P Zcoeff=Entrez le signe math‚matique de la fonction Z (exemple : + ou - ) : 
	SET /P ZY=Entrez  la  valeur  Y  de  la  fonction  Z ( exemple : 3 ou -3 )  : 
echo.
	echo Voici la formule Z : %ZX%x %Zcoeff% %ZY%y
echo.
	SET /P confirmationZ= Est-ce bien cela ? ( 1 - Oui // 2 - Non) : 
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
SET /P VariableContrainteX%v%=Entrez la valeur de X de la contrainte %v%            : 
SET /P VariableContrainteCoeff%v%=Entrez la valeur du coefficient de la contrainte %v%  : 
SET /P VariableContrainteY%v%=Entrez la valeur de Y de la contrainte %v%            : 
SET /P VariableContraintePartieDeDroite%v%=Entrez le resultat de la contrainte %v%               : 
goto NbContraintes )

set /a "v=0"

:AffichageFormesCanonique
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
echo.
echo la contrainte %v% est : !VariableContrainteX%v%!x !VariableContrainteCoeff%v%! !VariableContrainteY%v%!y = !VariableContraintePartieDeDroite%v%!
goto AffichageFormesCanonique )
set /a "v=0"
goto CalculFormesStandard

:CalculFormesStandard
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
set z%v% = !VariableContraintePartieDeDroite%v%!
goto CalculFormesStandard )
set /a "v=0"

:AffichageFormesStandard
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
echo.
echo z%v% + !VariableContrainteX%v%!x !VariableContrainteCoeff%v%! !VariableContrainteY%v%!y = !VariableContraintePartieDeDroite%v%!           soit z%v% = !VariableContraintePartieDeDroite%v%!	
echo.
goto AffichageFormesStandard )

:ChoixZ2
echo.
	SET /P confirmationZ= Est-ce bien cela ? ( 1 - Oui // 2 - Non) : 
	if %confirmationZ%==1 ( goto CalculVariableEntrante ) else if %confirmationZ%==2 ( goto ApresZ ) else ( echo choix incorrect, retour vers choixZ2 && timeout -t 4 > nul && goto choixZ2 )

:CalculVariableEntrante
echo.
SET MAXZ=0
if %ZX% == %ZY% ( set /a MAXZ = ZX ) else if %ZX% LSS %ZY% ( set /a MAXZ = ZY ) else ( set /a MAXZ = ZX )
if %ZX% == %ZY% ( echo Le maximum de Z est : X,Y = %MAXZ% ) else if %ZX% LSS %ZY% ( echo Le maximum de Z est : Y = %MAXZ% ) else ( echo Le maximum de Z est : X = %MAXZ% )
echo.

:DeterminationCalculRatio
set /a "v=0"
set /a nbContraintesPlus1=%nbContraintes%+1
if %MAXZ% == %ZX% ( goto CalculRatioX ) else ( goto CalculRatioY )

:CalculRatioX
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
set /a "r%v% = !VariableContraintePartieDeDroite%v%! / !VariableContrainteX%v%!"
echo R%v% = !r%v%!
goto CalculRatioX)
goto CalculMinimumRatio

:CalculRatioY
if %v% LSS %nbContraintes% (
set /a "v = v + 1"
set /a "r%v% = !VariableContraintePartieDeDroite%v%! / !VariableContrainteY%v%!"
echo R%v% = !r%v%!
goto CalculRatioY)
set /a "v=0"
set /a "candidat=%r0%"
pause

:CalculMinimumRatio
if %v% LSS %nbContraintesPlus1% (
if !r%v%! LSS %candidat% ( set /a candidat = !r%v%! )
set /a "v = v + 1"
)
echo la plus petite valeur de R est : %candidat%
pause
if !r%v%! LSS %candidat% ( set candidat = !r%v%! ) else ( )
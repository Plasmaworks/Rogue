@if not exist Build mkdir Build

cl /Ob2ity /GF /Gy /EHsc /nologo Source\RogueC\Bootstrap\RogueC.c /FoBuild\roguec.obj /FeBuild\roguec.exe
xcopy /I /S /Q /Y Source\Libraries Build\Libraries

@if "%~1" == "build" goto DONE
@echo Add the following to Environment Variables ^> User variables ^> Path:
@echo   %CD%\Build

:DONE

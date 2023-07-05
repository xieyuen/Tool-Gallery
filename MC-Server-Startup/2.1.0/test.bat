if exist .\mods\ (
        echo Mod 列表：
        echo.
        for %i in ( .\mods\*.jar ) do echo %i
        echo.
    )
    if exist .\plugins\ (
        echo Plugin 列表：
        echo.
        for %i in ( .\plugins\*.jar ) do echo %i
        echo.
    )

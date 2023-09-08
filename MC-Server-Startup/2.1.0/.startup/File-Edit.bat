:: File Edit

:: 检测跳转
if %0=="Config" goto :Config
if %0=="Config_Save" set "_exit=true" & goto :Config_Save
if %0=="Mods_Plgs" goto :Modify_MODs_PLGs

:: 配置文件
:Config

    if exist .\.startup if exist .\.startup\File-Edit.bat (
        cd .\.startup\
    ) else (
        if exist *.jar cd ../.startup
    )
    echo 目前的配置: 
    echo.
    echo 服务器核心: %_Server%
    echo 服务器最小内存占用: %_RAMmin% MB
    echo 服务器最大内存占用: %_RAMmin% MB
    echo Java 路径("java" 是默认Java): %_Java%
    :: echo 服务端工作路径：%_Server_Working%
    echo.
    echo 请选择操作:
    echo [1]更改配置
    echo [2]保存配置
    echo [9]读取配置
    echo [0]返回主操作中心
    choice /C:1902 /N
    set _erl=%ERRORLEVEL%
    if %_erl%==1 goto :Config_Change
    if %_erl%==2 goto :Config_read
    if %_erl%==3 cls & call main.bat
    if %_erl%==4 goto :Config_Save

    :Config_Change

        echo 更改项目: 
        echo [1]服务器核心
        echo [2]服务器最小内存占用
        echo [3]服务器最大内存占用
        echo [4]Java路径
        echo [5]EULA是否同意
        choice /N /C:12345
        set _erl=%ERRORLEVEL%
        if %_erl%==1 (
            
            :: 服务器核心
            :Config_Change_Server
            echo 搜索核心中...
            echo.
            for %%i in ( *.jar ) do echo %%i
            echo.
            echo 请输入核心名称: 
            set /p "_Server=服务器核心："
            cd ..\server\

            :: 循环检测
            :while-Config_Change_Server-NotExistServer
            if not exist .\%_Server% (
                echo 没有找到核心 :（
                echo 请重新输入.
                echo >其实你可以在命令行中复制粘贴的
                set /p "_Server=服务器核心："
                goto :while-Config_Change_Server-NotExistServer
            )
            

        ) else (

            if %_erl%==2 (

                :: 服务器最小内存占用
                :Config_Change_Min

                echo 请输入服务器最小内存占用(单位:MB,1GB=1024MB)
                set /p "_temp_RAMmin="

                :: GTR是大于
                if %_temp_RAMmin% GTR %_RAMmax% (
                    echo emmmm.....
                    echo 最小内存比最大内存还大？
                    echo 要改吗？
                    echo [1]改最大
                    echo [2]改最小
                    echo [3]用原来的
                    echo [4]用默认的
                    choice /N /C:1234
                    set _erl=%ERRORLEVEL%
                    if %_erl%==1 (
                        goto :Config_Change_Max
                    ) else (
                        if %_erl%==2 (
                            goto :Config_Change_Min
                        ) else (
                            if %_erl%==3 (
                                goto :if_exit-Config_Change_Min-MinMoreThanMax
                            ) else (
                                if %_erl%==4 (
                                    set _RAMmin=0
                                )
                            )
                        )
                    )
                ) else (
                    set "_RAMmin=%_temp_RAMmin%"
                )
                :if_exit-Config_Change_Min-MinMoreThanMax

            ) else (

                if %_erl%==3 (
                    
                    :: 服务器最大内存占用
                    :Config_Change_Max

                    echo 请输入服务器最大内存占用(单位:MB,1GB=1024MB)
                    set /p "_temp_RAMmax="
                    :: GTR是大于
                    if %_temp_RAMmin% GTR %_RAMmax% (
                        echo emmmm.....
                        echo 最小内存比最大内存还大？
                        echo 要改吗？
                        echo [1]改最大
                        echo [2]改最小
                        echo [3]用原来的
                        echo [4]用默认的
                        choice /N /C:1234
                        set _erl=%ERRORLEVEL%
                        if %_erl%==1 (
                            goto :Config_Change_Max
                        ) else (
                            if %_erl%==2 (
                                goto :Config_Change_Min
                            ) else (
                                if %_erl%==3 (
                                    goto :if_exit-Config_Change_Max-MinMoreThanMax
                                ) else (
                                    if %_erl%==4 (
                                        set _RAMmax=2048
                                    )
                                )
                            )
                        )
                    ) else (
                        set "_RAMmin=%_temp_RAMmin%"
                    )
                    :if_exit-Config_Change_Max-MinMoreThanMax

                ) else (

                    if %_erl%==4 (

                        :: Java路径
                        :Config_Change_Java
                        :: 搜索Java
                        echo 正在搜索可用的Java...
                        echo.
                        echo java
                        for %%i in ( A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ) do (
                            if exist %%i:\ (
                                :: “|” 这玩意是管道符号
                                dir /b /s %%i:\ | find "java.exe"
                            )
                        )
                        :: if exist D:\ (dir /b /s D:\ | find "java.exe")
                        :: if exist E:\ (dir /b /s E:\ | find "java.exe")
                        :: if exist F:\ (dir /b /s F:\ | find "java.exe")
                        :: if exist G:\ (dir /b /s G:\ | find "java.exe")
                        echo.
                        echo 搜索完成！
                        echo 一行一个Java, 可复制(“java”是默认Java)
                        echo 请输入Java路径: 
                        set /p "_temp_Java=Java路径："
                        :while-Config_Change_Java-NotExistJava
                        if not %_temp_Java%==java (
                            if not exist %_temp_Java% (
                                echo 没有找到Java :（
                                echo 请重新输入.(你可以复制粘贴的)
                                set /p "_temp_Java=Java路径："
                                goto :while-Config_Change_Java-NotExistJava
                            )
                        )

                    ) else (

                        if %_erl%==5 (
                            pass
                        )

                    )
                )
            )
        )
        echo.
        echo 设置完成!
        echo 保存中...
         
    :Config_Save

        :: 这一段代码是保存配置文件的代码
        :: >>config.bat 和 >config.bat 都是写入配置文件的
        :: ^^^^^^^^^^^^    ^^^^^^^^^^^
        ::   这个是           这个是
        ::  在下面加行        覆盖写入
        ::
        :: 'echo.' 作为换行
        :: 生成效果如 README 所示
        :: README链接: https://github.com/xieyuen/Tool-Gallery/tree/main/MC-Server-Startup#%E9%BB%98%E8%AE%A4%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6
        echo @rem 这是开服脚本的配置文件>config.bat
        echo @rem 每次保存都会覆盖掉你多余的字符>>config.bat
        echo @rem 不要乱改哦（特别是 “ = ” 前面的）>>config.bat
        echo @rem 要改也只能改每行 “=” 后面的>>config.bat
        echo. >>config.bat
        echo @rem 服务器核心名>>config.bat
        echo set _Server=%_Server%>>config.bat
        echo. >>config.bat
        echo @rem 最大内存占用, 单位MB>>config.bat
        echo set _RAMmax=%_RAMmax%>>config.bat
        echo. >>config.bat
        echo @rem 最小内存占用, 单位MB>>config.bat
        echo set _RAMmin=%_RAMmin%>>config.bat
        echo. >>config.bat
        echo @rem Java路径>>config.bat
        echo set "_Java=%_Java%">>config.bat
        echo. >>config.bat
        echo @rem EULA是否同意>>config.bat
        echo @rem 同意 true>>config.bat
        echo @rem 不同意 false>>config.bat
        echo set "_eula=%_eula%">>config.bat
        echo. >>config.bat
        :: echo @rem 服务端工作路径>>config.bat
        :: echo set "_Server_Working=%_Server_Working%">>config.bat

        if %_exit%==true echo The configuration file has been generated, please fill it in before running the script. The configuration file has been placed under the ".startup" folder and named "config.bat"

        echo 保存成功
        pause >nul
        goto :Config

    :Config_read

        if not exist config.bat (
            echo 未识别到配置文件, 
            echo 请按任意键返回...
            pause >nul
        ) else (
            echo 正在读取...
            call config.bat
            echo 读取完成!
        )
        goto :Config


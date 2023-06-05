@echo off
chcp 65001
title MCDReforged Installer
set "_pypi=https://pypi.tuna.tsinghua.edu.cn/simple"
cls

echo Please select a language:
echo 请选择语言:
echo   [1] zh_cn 简体中文
echo   [2] en_us English
choice /C:12 /N
set _erl=%ERRORLEVEL%
if %_erl%==1 goto :zh_cn
if %_erl%==2 goto :en_us

:zh_cn

    cls
    echo 安装 MCDR 前需要安装 Python 3.6 或更高版本!!
    echo 安装 MCDR 前需要安装 Python 3.6 或更高版本!!
    echo 安装 MCDR 前需要安装 Python 3.6 或更高版本!!
    echo.
    echo 请将脚本放置在要安装MCDR的文件夹内
    echo.
    echo 请选择操作:
    echo   [1]安装MCDR
    echo   [2]更新MCDR
    echo   [3]选择pypi下载源
    choice /C:123 /N
    set _erl=%ERRORLEVEL%
    if %_erl%==1 goto :cn_install
    if %_erl%==2 goto :cn_update
    if %_erl%==3 goto :pypi_download

    :cn_install

        echo 请按任意键安装MCDR...
        pause >nul
        pip install mcdreforged -i %_pypi%
        echo 正在初始化中...
        py -m mcdreforged init
        echo 安装完成!
        echo 使用命令 py -m mcdreforged 开启MCDR (记得用管理员权限)
        echo 按任意键生成启动脚本
        echo 或关闭窗口以退出...
        pause >nul
        goto :Export_startup_script

    :cn_update
    
        if exist mcdreforged.py (
            echo 你从源码启动？？？
            echo 如果你只是一个普通的 MCDR 用户，请按任意键继续更新
            echo 如果你是 MCDR 的开发者，那请关闭此脚本，这是为 MCDR 用户开发的安装脚本
            echo 接下来将会删除 MCDR 在此目录下的源代码
            echo.
            pause
            echo.
            echo 给你反悔的机会
            echo 这将会删除多余的文件
            echo 确定？
            echo 按下任意键代表你确定删除 MCDR 的源代码
            echo 否则请关闭窗口
            pause >nul

            @echo on 
            :: 删除文件夹下的 MCDR 源代码
            @del /q .\.github
            @del /q .\docs
            @del /q .\mcdreforged
            @del /q .\tests
            @del /q .\.gitignore
            @del /q .\.readthedocs.yml
            @del /q .\LICENSE
            @del /q .\logo_long
            @del /q .\MANIFEST.in
            @del /q .\MCDReforged.py
            @del /q .\README.md
            @del /q .\requirements.txt
            @del /q .\setup.py
            @echo off
            
            echo 准备更新...

        ) else (
            echo 请按任意键更新MCDR...
            pause >nul
        )
        pip install mcdreforged -U -i %_pypi%
        echo 更新完成!
        echo 使用命令 py -m mcdreforged 开启MCDR (记得用管理员权限)
        echo 按任意键退出...
        pause >nul
        exit /b

    :pypi_download

        echo 请选择下载源：(默认使用清华下载源)
        echo.
        echo [1]清华 pypi 镜像站
        echo [2]阿里云 pypi 镜像站
        echo [3]USTC pypi 镜像站
        echo [4]BFSU pypi 镜像站
        echo.
        choice /N /C:1234
        set _erl=%ERRORLEVEL%
        if %_erl%==1 set "_pypi=https://pypi.tuna.tsinghua.edu.cn/simple"
        if %_erl%==2 set "_pypi=https://mirrors.aliyun.com/pypi/simple/"
        if %_erl%==3 set "_pypi=https://mirrors.ustc.edu.cn/pypi/"
        if %_erl%==4 set "_pypi=https://mirrors.bfsu.edu.cn/pypi/web/simple"

:en_us
    
    cls
    echo Python 3.6 or later is required before installing MCDR!!!
    echo Python 3.6 or later is required before installing MCDR!!!
    echo Python 3.6 or later is required before installing MCDR!!!
    echo.
    echo Please place the script in the folder where you want to install MCDR.
    echo.
    echo Please select an action:
    echo   [1] Install MCDReforged
    echo   [2] Update MCDReforged
    choice /C:12 /N
    set _erl=%ERRORLEVEL%
    if %_erl%==1 goto :us_install
    if %_erl%==2 goto :us_update

    :us_install
    
        echo Please press any key to install MCDR...
        pause >nul
        pip install mcdreforged
        py -m mcdreforged init
        echo Installation complete!
        echo Use the command py -m mcdreforged to turn on MCDR! (Remember to use administrator privileges)
        echo Press any key to exit...
        pause >nul
        exit /b
    
    :us_update
    
        echo Please press any key to update MCDR...
        pause >nul
        pip install mcdreforged -U
        echo Update complete!
        echo Use the command "py -m mcdreforged" to turn on MCDR! (Remember to use administrator privileges)
        echo Press any key to exit...
        pause >nul
        exit /b

:Tools

    :Export_startup_script
    
        echo. >Startup_script.bat
        echo @echo off >>Startup_script.bat
        echo chcp 65001
        echo set _restart=0 >>Startup_script.bat
        echo title MCDReforged启动脚本 >Startup_script.bat
        echo echo 按下任意键开启服务端... >>Startup_script.bat
        echo pause >nul >>Startup_script.bat
        echo :start >>Startup_script.bat
        echo    title MCDReforged启动脚本 [重启次数:%_restart%] >>Startup_script.bat
        echo    py -X utf8 mcdreforged >>Startup_script.bat
        echo    echo MCDR将在5秒后启动... >>Startup_script.bat
        echo    @ping 127.0.0.1 -n 6 >>Startup_script.bat
        echo    set /a _restart=+1 >>Startup_script.bat
        echo    goto :start >>Startup_script.bat
        echo 启动脚本已生成！
        echo 按下任意键退出...
        pause >nul
        exit /b

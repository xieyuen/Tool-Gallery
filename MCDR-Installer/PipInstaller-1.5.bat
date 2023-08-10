@echo off
chcp 936
title Self-service Pypi Installer
set "_pypi=https://pypi.org/simple"
cls

:main
    cls
    echo.
    echo pip下载源: %_pypi%
    echo.
    echo 请选择操作:
    echo   [1]MCDR 选项
    echo   [2]选择 pypi下载源
    echo   [3]安装 Python 包
    echo   [4]更新 pip --NEW!
    echo   [0]退出此安装器
    choice /C:12340 /N
    set _erl=%ERRORLEVEL%
    if %_erl%==1 goto :MCDR
    if %_erl%==2 goto :pypi_download_from
    if %_erl%==3 goto :python_package_install
    if %_erl%==4 goto :pip_upgrade
    if %_erl%==5 exit /b

:MCDR

    echo 安装 MCDR 前需要安装 Python 3.8 或更高版本!!
    echo 安装 MCDR 前需要安装 Python 3.8 或更高版本!!
    echo 安装 MCDR 前需要安装 Python 3.8 或更高版本!!
    echo.
    echo 请将脚本放置在要安装MCDR的文件夹内
    echo.
    echo 请选择操作:
    echo   [1]安装 MCDR
    echo   [2]更新 MCDR
    echo   [0]返回主界面
    choice /C:120 /N
    set _erl=%ERRORLEVEL%
    if %_erl%==1 goto :MCDR_install
    if %_erl%==2 goto :MCDR_upgrade
    if %_erl%==3 goto :main


    :MCDR_install

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
        goto :Print_startup_script

    :MCDR_upgrade

        if exist .\mcdreforged.py (
            echo 你从源码启动？？？
            echo 如果你只是一个普通的 MCDR 用户，请按任意键继续更新
            echo 如果你是 MCDR 的开发者，那请关闭此脚本，这是为 MCDR 用户开发的安装脚本
            echo 接下来将会删除 MCDR 在此目录下的源代码
            echo.
            pause
            echo.
            color 04
            echo 给你反悔的机会
            echo 这将会删除多余的文件
            echo 确定？
            echo 按下任意键代表你确定删除此目录下 MCDR 的源代码
            echo 否则请关闭窗口
            pause >nul
            color 07

            @echo on 
            :: 删除文件夹下的 MCDR 源代码
            del /q .\.github
            del /q .\docs
            del /q .\mcdreforged
            del /q .\tests
            del .\.gitignore
            del .\.readthedocs.yml
            del .\LICENSE
            del /q .\logo_long
            del /q .\MANIFEST.in
            del .\MCDReforged.py
            del .\README.md
            del .\requirements.txt
            del .\setup.py
            @echo off
            
            echo 准备更新...

        ) else (
            echo 请按任意键更新MCDR...
            pause >nul
        )
        pip install mcdreforged -U -i %_pypi%
        echo 更新完成!
        echo 使用命令 py -m mcdreforged 开启MCDR (记得用管理员权限)
        echo 按任意键返回主界面...
        pause >nul
        goto :main

:pypi_download_from

    echo 请选择下载源：(默认使用官方源)
    echo.
    echo [0] 官方 pypi 源
    echo [1] 清华 pypi 镜像站
    echo [2] 阿里云 pypi 镜像站
    echo [3] USTC pypi 镜像站
    echo [4] BFSU pypi 镜像站
    echo [5] 豆瓣 pypi 镜像站
    echo [6] 华中科技大学 pypi 镜像站
    echo [7] 上海交通大学 pypi 镜像站
    echo [9] 自输入 pypi 源 URL
    echo.
    choice /N /C:012345679
    set _erl=%ERRORLEVEL%
    if %_erl%==1 set "_pypi=https://pypi.org/simple"
    if %_erl%==2 set "_pypi=https://pypi.tuna.tsinghua.edu.cn/simple"
    if %_erl%==3 set "_pypi=https://mirrors.aliyun.com/pypi/simple/"
    if %_erl%==4 set "_pypi=https://mirrors.ustc.edu.cn/pypi/"
    if %_erl%==5 set "_pypi=https://mirrors.bfsu.edu.cn/pypi/web/simple"
    if %_erl%==6 set "_pypi=http://pypi.douban.com/simple/"
    if %_erl%==7 set "_pypi=http://pypi.hustunique.com/simple/"
    if %_erl%==8 set "_pypi=https://mirror.sjtu.edu.cn/pypi/web/simple/"
    if %_erl%==9 set /p "_pypi=请输入 pypi 源的 URL: "
    :: if %_erl%== set "_pypi="

    echo 设置完成！
    goto :main

:python_package
    :python_package_install

        set /p "_ins=请输入需要下载的包ID："
        if %_ins% == "mcdreforged" (
            echo 即将跳转至 MCDR安装
            goto :MCDR_install
        )
        pip install %_ins% -i %_pypi%
        echo OK!
        pause >nul
        goto :main
    
    :python_package_upgrade

        set /p "_upd = 请输入需要更新的包ID:"
        if %_upd% == "mcdreforged" (
            echo 即将跳转至 MCDR更新
            goto :MCDR_upgrade
        )

:Tools

    :Print_startup_script
    
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

:pip_upgrade

    py -m pip install pip -U -i %_pypi%
    echo pip 更新完成！
    goto :main

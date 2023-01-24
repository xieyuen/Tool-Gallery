@echo off
@rem 更新目标
@rem 1.给文本上色!
@rem 2.优化EULA协议
@rem  2.1.读取EULA内容
@rem  2.2.自动同意EULA
@rem 3.将参数保存至Config文件
::===========================================================================================================================
:: 调试
set _version=2.0.0
if not exist config.bat (
   set "_ACS=AutoCheckingServer"
   :Initialize
      chcp 936 & :: 设置代码页 GBK
      set _RAMmax=4096
      set _RAMmin=0
      set _restart=0 & :: 设置重启变量
      set _error=0 & :: 设置重启显示次数
      set "_Java=.\Java18\bin\java.exe" & :: 设置 Java 路径
      set "_Frpc=.\MEFrp\frpc.exe"
      set "_Frpc_Config=.\MEFrp\Frpc.ini"
      :: 必须修改
      if exist eula.txt (
         set _eula=true 
      ) else ( 
         set _eula=false 
      )
   cls
) else (
   call config.bat
   set _config=true
)

::============================================================================================================================

:Welcome & ::欢迎界面
   title Hello! %username%, 欢迎使用此脚本
   echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
   echo 欢迎%username%使用此脚本!
   echo 脚本版本: %_version% snapshot GBK
   echo 此脚本为快照版, 有BUG请邮箱 xieyuen163@163.com
   echo.
   echo 这版本如果不出什么BUG那就升级成正式版把
   echo.
   echo --------------------------------------
   echo 更新日志:
   echo   去README.MD看(
   echo --------------------------------------
   echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++

:Main_Action_Center & :: 操作中心界面
   echo 请选择项目:
   echo   [1]服务器操作中心
   echo   [2]Frp操作中心[Under Development]
   echo   [9]配置文件相关[Under Development]
   echo   [0]退出
   choice /C:0129A /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto bye
   if %_erl%==2 goto Server_Action_Center
   if %_erl%==3 (
      cls 
      echo.
      echo This feature is under development!
      echo This feature is under development! 
      echo This feature is under development! 
      echo. 
      goto Main_Action_Center
   )
   if %_erl%==4 (
      cls 
      echo.
      echo This feature is under development! 
      echo This feature is under development! 
      echo This feature is under development! 
      echo.
      goto Main_Action_Center
   )
   if %_erl%==5 (
      set /p "_login.confirm="
      if "%_User.login.confirm%=login Admin" (
         set _User=Admin
         echo User: Admin
         echo Please enter you login password...
         set "_User.admin.loginpassword=" /p
         if %_User.admin.loginpassword%==%_version% (
            echo Login Successful!
            goto Admin_Action_Center
         ) else (
            echo WRONG PASSWORD!
            pause >nul
            exit /b
         )
      ) else (
         goto Main_Action_Center
      )
   )  

:Admin_Action_Center
   cls
   echo [1]Frp_Action_Center.
   echo [2]Config
   echo [0]exit
   choice /C:120 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Frp_Action_Center
   if %_erl%==2 goto Config
   if %_erl%==3 goto Main_Action_Center

:Frp_Action_Center
   cls
   echo 脚本现仅支持MEfrp(镜缘映射)!
   echo.
   echo  Frp当前设置:
   echo     frp路径:%_Frpc%
   echo     frp设置路径:%_Frpc_Config%
   echo. 
   echo  请选择操作:
   echo     [1]开启frp
   echo     [2]导出frp启动脚本
   echo     [0]返回主操作中心
   choice /C:012 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Main_Action_Center
   if %_erl%==2 goto Start_Frp
   if %_erl%==3 goto SaveFrp

:Server_Action_Center
   if not %_config%==true (
      if %_ACS%==AutoCheckingServer (
         set "%_ACS%=unAutoCheckingServer"
         goto AutoCheckingServer
      )
   )
   echo 服务器当前设置:
   echo   核心:%_Server% 
   echo   最大内存占用:%_RAMmax%MB 
   echo   初始内存占用:%_RAMmin%MB
   echo   Java路径:%_Java%
   echo 请选择操作:
   echo   [1]开启服务器
   echo   [2]调整服务器核心
   echo   [3]调整最大内存占用
   echo   [4]调整初始内存占用
   echo   [5]禁用/解禁模组和插件
   echo   [6]更改Java路径
   echo   [C]清屏
   echo   [0]返回主操作中心
   echo 输入选择的菜单项:
   choice /C:0123456C /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Main_Action_Center
   if %_erl%==2 goto Choose
   if %_erl%==3 goto setServer
   if %_erl%==4 goto set_RAMmax
   if %_erl%==5 goto set_RAMmin
   if %_erl%==6 goto Modify_MODs_PLGs
   if %_erl%==7 goto Modify_Java
   if %_erl%==8 (
      cls
      set "_ACS=unAutoCheckingServer"
      goto Server_Action_Center
   )

::============================================================================================================================

:bye
   cls
   echo 真的要离开了吗?
   echo 给你个机会撤销你的选择
   echo [y]确定撤销
   echo [n]白白
   choice /C:YN /N
   set _erl=%ERRORLEVEL%
   cls
   if %_erl%==1 (
      echo 耶!
      goto Welcome
   )
   if %_erl%==2 (
      echo 白白
      echo 你可以关闭这个窗口了
      echo 或者随便按些什么
      pause >nul
      exit /b
   )

:Modify_Java
   echo 请输入Java路径:
   set /p "_Java="
   ::检查Java路径存在性
   if exist %_Java% (
      echo 设置成功!
      goto Server_Action_Center
   )
   if exist "%_Java%\java.exe" (
      echo 你似乎是从资源管理器上复制的...?
      echo 别忘记了java.exe这东西
      echo 这次帮你补上哈~
      set "_Java='%_Java%\java.exe'"
      goto Server_Action_Center
   )
   set "_Java=java"
   echo 大老粗!这没有java.exe嘛
   echo 已经切换为默认java.
   goto Server_Action_Center

:set_RAMmin
   echo 请输入服务器初始内存占用(单位:MB,1GB=1024MB), 默认值:0
   set /p "_RAMmin="
   goto Check_RAM

:set_RAMmax
   echo 请输入服务器最大内存占用(单位:MB,1GB=1024MB), 默认值:4096
   set /p "_RAMmax="
   goto Check_RAM

:Choose & :: 开服方式选择
   set %ERRORLEVEL%=0
   echo 请选择开服方式:
   echo   [1]自动重启5次
   echo   [2]自动重启10次
   echo   [I]无限自动重启
   echo   [3]测试服务器(重启1次)
   echo   [4]测试服务器(不重启)
   echo   [0]返回服务器操作中心
   echo 输入选择的菜单项:
   choice /C:12I034 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 (
      set _chk_mod=5
      goto Start_Server
   )
   if %_erl%==2 (
      set _chk_mod=10 
      goto Start_Server
   ) 
   if %_erl%==3 (
      set _chk_mod=infinity 
      goto Confirm
   )
   if %_erl%==4 goto Server_Action_Center
   if %_erl%==5 (
      set _chk_mod=1
      goto Start_Server
   )
   if %_erl%==6 (
     set _chk_mod=0
     goto Start_Server
   )

:Confirm & :: 确认选择[infinity]
   cls
   set %ERRORLEVEL%=0
   echo 你确定选择无限模式吗?
   echo 无限模式只能用 Ctrl+C 或 关闭窗口(不推荐) 来关闭服务器
   echo 输入Y确认, 输入N回到选择界面
   choice /C:YN /N
   set _erl=%ERRORLEVEL%
   if %_erl%==2 goto Choose
   if %_erl%==1 goto Start_Server

:Modify_MODs_PLGs
   if %_mod%==nul (
      echo 似乎...这是Minecraft原版核心!
      echo 原版核心不可加载插件/模组
      echo 正在退回...
      goto Server_Action_Center
   )
   echo 请选择项目:
   echo   [1]MOD
   echo   [2]PLUGIN
   echo   [3]返回服务器操作中心
   echo 输入选择的菜单项:
   choice /C:120 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Modify_MODs
   if %_erl%==2 goto Modify_PLUGINs
   if %_erl%==3 goto Server_Action_Center
   :Modify_MODs
      if not exist ".\mods" (
        echo [ERROR]:没有mods文件夹 
        echo [INFO]:创建中...
        md .\mods
        echo [INFO]:创建完成!
      ) 
      cd ".\mods"
      dir
      goto un_ban
   :Modify_PLUGINs
      if not exist ".\plugins" ( 
         echo [ERROR]:没有plugins文件夹 
         echo [INFO]:创建中:
         md .\plugins
         echo [INfO]:创建完成!
      )
      cd ".\plugins"
      dir
   :un_ban
      echo 请输入模组/插件名称:
   echo 小提示: 在命令行中选中文字再右键两次即可完成复制和粘贴
   echo 注意: 不要复制后缀!
   set /p "_mods_plgs="
   if not exist ".\%_mods_plgs%" ( 
      if exist ".\%_mods_plgs%.jar" ( 
         set mods_plgs=%_mods_plgs%.jar 
      ) else ( 
         if exist ".\%_mods_plgs%.ban" ( 
            ren ".\%_mods_plgs%.ban" %_mods_plgs% 
            echo 模组/插件 %_mods_plgs% 已启用
            cd .. 
            goto Server_Action_Center
         ) else ( 
           if exist ".\%_mods_plgs%.disabled" (
              ren ".\%_mods_plgs%.disabled" %_mods_plgs%
              echo 模组/插件 %_mods_plgs% 已启用
              cd ..
              goto Server_Action_Center
           )
           echo [ERROR]:出现了一个致命错误
           echo [ERROR]:在解析文本%_mods_plgs%出错! 
           pause >nul 
           exit /b 
         ) 
      ) 
   )
   echo 请选择操作:
   echo [1]禁用模组
   echo [2]启用模组
   echo 直接输入序号
   choice /C:12 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 ( 
     ren ".\%_mods_plgs%" %_mods_plgs%.ban 
     echo 模组/插件 %_mods_plgs% 已禁用 
   )
   if %_erl%==2 ( 
     if exist ".\%_mods_plgs%.ban" (
         ren ".\%_mods_plgs%.ban" %_mods_plgs% 
     )
     if exist ".\%_mods_plgs%.disabled" (
         ren ".\%_mods_plgs%.disabled" %_mods_plgs% 
     )
     echo 模组/插件 %_mods_plgs% 已启用 
   )
   cd ..
   goto Server_Action_Center

:setServer & :: 设置核心(如果未检测到)
   echo 请输入核心名称:
   set /p "_Server="
::   if not exist ".\*.jar" (
::      echo 没有核心？
::      echo 赶紧去下载一个
::      echo 想要开什么服务器？
::      echo     [1] vanilla 原版服务器
::      echo     [2] Fabric 推荐高版本
::      echo     [3] Forge 推荐低版本
::      echo     [4] Carpet 
::      echo     [5] MCDR qb不是梦(但是 MCDR 只是服务器的壳子，里面还要装服务器...
::      echo     [6] Bukkit
::      echo     [7] Paper
::      echo     [8] Purpur
::      echo     [9] Arclight
::      echo     [0] 打开浏览器
::      choice /C:1234567890 /N
::      pause >nul
::   )
   if exist ".\%_Server%" (
      echo 检测到核心:%_Server% 
      set "_ACS=unAutoCheckingServer"
      goto Server_Action_Center
   ) 
   if exist ".\%_Server%.jar" (
      set _Server=%_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      echo 检测到核心:%_Server% 
      goto Server_Action_Center
   )
   if exist ".\%_Server%.ban" (
      ren ".\%_Server%.ban" %_Server% 
      echo 服务器核心 %_Server% 已启用并选择 
      set "_ACS=unAutoCheckingServer"
      goto Server_Action_Center
   )
   if exist ".\%_Server%.disabled" (
      ren ".\%_Server%.disabled" %_Server% 
      set "_ACS=unAutoCheckingServer"
      echo 服务器核心 %_Server% 已启用并选择 
      goto Server_Action_Center
   )
   if exist ".\%_Server%.jar.ban" (
      ren ".\%_Server%.jar.ban" %_Server%.jar 
      set _Server=%_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      echo 服务器核心 %_Server% 已启用并选择 
      goto Server_Action_Center
   )
   if exist ".\%_Server%.jar.disabled" (
      ren ".\%_Server%.jar.disabled" %_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      set _Server=%_Server%.jar 
      echo 服务器核心 %_Server% 已启用并选择 
      goto Server_Action_Center
   )
   echo [ERROR]:核心%_Server%不存在!
   if %_Chk_Server%==true (
      echo 请选择操作:
      echo  [1]自动检测
      echo  [2]手动输入
      echo  [3]跳过, 选择默认 Start.jar 核心
      choice /C:123 /N
      set _erl=%ERRORLEVEL%
      if %_erl%==3 (
         echo 正在执行操作...
         set "Server=Start.jar"
         goto Server_Action_Center
      )
      if %_erl%==2 goto AutoCheckingServer
      if %_erl%==1 goto setServer
   )
   set "_Server=Start.jar"
   echo 已选择默认核心:Start.jar
   set "_ACS=unAutoCheckingServer"
   goto Server_Action_Center
 
:Check_RAM
   if %_RAMmax%==0 (
     echo emmm...最大为0M...
     echo 服务器怎么跑?
     echo 应该是初始为0M吧...
     if %_RAMmin%==0 (
        echo 初始也是0M?
        echo 先给你重置了先
        set "_RAMmax=4096"
        goto Server_Action_Center
     )
     echo 我给你换了哈
     set "_RAMmax=%_RAMmin%"
     set _RAMmin=0
     goto Server_Action_Center
   )
   set /a "_temp=%_RAMmax%-%_RAMmin%"
   if %_temp% GEQ 0 (
      echo 设置成功! 
      goto Server_Action_Center
   )
   echo [ERROR]:服务器内存初始值大于最大值 ( max:%_RAMmax% min:%_RAMmin% )
   echo 请选择操作:
   echo   [1]重置值
   echo   [2]更改最大值
   echo   [3]更改初始值
   choice /C:123 /N
   if %ERRORLEVEL%==1 set _RAMmax=4096 & set _RAMmin=0 & goto Server_Action_Center
   if %ERRORLEVEL%==2 goto set_RAMmax
   if %ERRORLEVEL%==3 goto set_RAMmin
   if %ERRORLEVEL%==0 goto Server_Action_Center

:AutoCheckingServer & :: 检测核心
   echo 自动检测核心中......
   if exist ".\fabric-server-launch.jar" (
      set _Chk_Server=true
      set "_Server=fabric-server-launch.jar"
      set "_mod=true"
      echo 检测到核心:fabric-server-launch.jar
      goto Server_Action_Center
   )
   if exist ".\quilt-server-launch.jar" (
      set _Chk_Server=true
      set "_Server=quilt-server-launch.jar" 
      set "_mod=true"
      echo 检测到核心:quilt-server-launch.jar 
      goto Server_Action_Center
   )
   if exist ".\BungeeCord.jar" (
      set _Chk_Server=true
     set "_Server=BungeeCord.jar"
     set _mod=true
     set _RAMmax=512
     echo 咦,竟然有人用这个脚本跑BungeeCord
     echo 先砍内存占用（
     goto Server_Action_Center
   )
   if exist ".\Server.jar" (
      set _Chk_Server=true
      set "_Server=Server.jar" 
      set "_mod=false"
      echo 检测到核心:Server.jar 
      goto Server_Action_Center
   )
   if exist ".\minecraft_server.jar" (
      set _Chk_Server=true
      set "_Server=minecraft_server.jar"
      set "_mod=false" 
      echo 检测到核心:minecraft_server.jar 
      goto Server_Action_Center
   )
   if exist ".\minecraft-server.jar" (
      set _Chk_Server=true
      set "_Server=minecraft-server.jar"
      set "_mod=false"
      echo 检测到核心:minecraft-server.jar
      goto Server_Action_Center
   )
   echo 未检测到服务器核心! 
   goto setServer

::============================================================================================================================

:Config

   echo 请选择操作:
   echo [1]保存配置
   echo [2]读取配置
   echo [0]返回主操作中心
   choice /C:120 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto Save_Config
   if %_erl%==2 goto Read_Config
   if %_erl%==3 (
      if %User%==Admin goto Admin_Action_Center
      goto Main_Action_Center
   )
   
   :Save_Config
      echo @rem 这是开服脚本的配置文件 > config.bat
      echo @rem 每次保存都会覆盖掉你多余的字符 >> config.bat
      echo @rem 不要乱改哦（特别是 “ = ” 前面的） >>config.bat
      echo @rem 要改也只能改每行 “=” 后面的 >>config.bat
      echo. >>config.bat
      echo set _Server=%_Server% >> config.bat
      echo set _RAMmax=%_RAMmax% >> config.bat
      echo set _RAMmin=%_RAMmin% >> config.bat
      echo set _Java=%_Java% >> config.bat
      echo set _EULA=%_eula% >> config.bat
      echo set _Frpc=%_Frpc% >> config.bat
      echo set _Frpc_Config=%_Frpc_Config% >> config.bat
      echo. >>config.bat
   
   :Read_Config
      if not exist config.bat (
         echo 无法识别到配置文件，
         echo 请按任意键返回...
         pause >nul
         goto Config
      )
      call config.bat

::============================================================================================================================

:Start_Frp
   echo frp开启中...
   start %_Frpc% -c %_Frpc_Config%
   goto Frp_Action_Center

::============================================================================================================================

:Start_Server
   title 服务器运行中 [重启次数:%_error%次] 请勿关闭窗口!!!
   echo =========================================
   echo               服务器正在开启
   echo           The server is starting!
   echo =========================================
   powershell /C %_Java% -jar -Dfile.encoding=GBK -Xms%_RAMmin%M -Xmx%_RAMmax%M %_Server% nogui
   ::if %_eula%==false goto First_Start
   set /a _restart+=1
   set /a _error+=1
   if %_chk_mod%==infinity goto Start_Server
   if %_chk_mod%==1 goto restart_1
   if %_chk_mod%==5 goto restart_5
   if %_chk_mod%==10 goto restart_10
   if %_chk_mod%==0 goto Crash

   :restart_1
      if %_restart%==1 goto Crash
      goto Start_Server
   :restart_5
      if %_restart%==6 goto Crash 
      goto Start_Server
   :restart_10
      if %_restart%==11 goto Crash
      goto Start_Server

   :First_Start & :: 必须修改
      echo Minecraft EULA 协议未同意!
      echo 请同意协议, 协议文件在服务器根目录下的EULA.txt
      echo 同意协议方法: 打开eula.txt, 更改 eula=false 为 eula=true 并保存
      echo 同意协议后请按任意键继续...
      pause >nul
      if exist ".\EULA.TXT" set eula=true
      goto Start_Server

:Crash & :: 崩溃
   set _restart=0
   title 服务器已崩溃 :(
   echo =========================================
   echo             服务器总计崩溃%_error%次
   echo          服务器日志文件在.\logs\下
   echo        崩溃报告在.\crash-report\下
   echo =========================================
   echo 按C键关闭脚本
   echo 按R键重启服务器
   echo 按B键重新选择开服模式
   echo 按P键重启整个脚本
   choice /C:CRBP /N
   set _erl=%ERRORLEVEL%
   if %_erl%==4 (
     cls 
     set "_ACS=unAutoCheckingServer" 
     goto Initialize
   )
   if %_erl%==3 goto Choose
   if %_erl%==2 goto Check
   if %_erl%==1 exit /b

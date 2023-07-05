:: 主程序

:Welcome & ::欢迎界面

   title Hello! %USERNAME%, 欢迎使用此脚本
   echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
   echo 欢迎%USERNAME%使用此脚本!
   echo 脚本版本: %_version% snapshot GBK
   echo 此脚本为快照版, 有BUG请邮箱 xieyuen163@163.com
   echo.
   echo 这版本如果不出什么BUG那就升级成正式版把
   echo.
   echo --------------------------------------
   echo 更新日志:
   echo   去README.MD看(
   echo       README.MD: 
   echo   https://github.com/xieyuen/xieyuen/blob/main/开服脚本/README.MD
   echo --------------------------------------
   echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++

:Main_Action_Center & :: 操作中心界面

   echo.
   echo 请选择项目:
   echo   [1]服务器操作中心
   echo   [2]Frp操作中心[Under Development]
   echo   [9]配置文件相关
   echo   [0]退出
   echo.
   choice /C:0129C /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 exit /b
   if %_erl%==2 (
      cls
      goto :Server_Action_Center
   )
   if %_erl%==3 (
      cls 
      call 2.1.0-frp.bat
   )
   if %_erl%==4 (
      cls
      call ".\.startup\File-Edit.bat" Config
   )
   if %_erl%==5 (
      cls
      goto :Welcome
   )     

:Server_Action_Center

   if %_config%==false (
      if %_ACS%==AutoCheckingServer (
         set "%_ACS%=unAutoCheckingServer"
         goto :AutoCheckingServer
      )
   )

   echo 服务器当前设置:
   echo   核心:%_Server% 
   echo   最大内存占用:%_RAMmax%MB 
   echo   最小内存占用:%_RAMmin%MB
   echo   Java路径:%_Java%
   echo 请选择操作:
   echo   [1]开启服务器
   echo   [2]调整服务器核心
   echo   [3]调整最大内存占用
   echo   [4]调整最小内存占用
   echo   [5]禁用/解禁模组和插件
   echo   [6]更改Java路径
   echo   [C]清屏
   echo   [0]返回主操作中心
   echo 输入选择的菜单项:
   choice /C:0123456C /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto :Main_Action_Center
   if %_erl%==2 goto :Choose
   if %_erl%==3 goto :setServer
   if %_erl%==4 goto :set_RAMmax
   if %_erl%==5 goto :set_RAMmin
   if %_erl%==6 goto :Modify_MODs_PLGs
   if %_erl%==7 goto :Modify_Java
   if %_erl%==8 (
      cls
      set "_ACS=unAutoCheckingServer"
      goto :Server_Action_Center
   )

::============================================================================================================================

:Choose & :: 开服方式选择

   cls
   echo.
   echo 请选择开服方式:
   echo   [1]自动重启5次
   echo   [2]自动重启10次
   echo   [I]无限自动重启
   echo   [3]测试服务器(重启1次)
   echo   [4]测试服务器(不重启)
   echo   [5]自定义次数
   echo   [0]返回服务器操作中心
   echo 输入选择的菜单项:
   choice /C:12I0345 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 (
      set _chk_mod=5
      goto :Start_Server
   )
   if %_erl%==2 (
      set _chk_mod=10 
      goto :Start_Server
   ) 
   if %_erl%==3 (
      set _chk_mod=infinity 
      goto :Confirm
   )
   if %_erl%==4 goto :Server_Action_Center
   if %_erl%==5 (
      set _chk_mod=1
      goto :Start_Server
   )
   if %_erl%==6 (
     set _chk_mod=0
     goto :Start_Server
   )
   if %_erl%==7 (
      set _chk_mod=Custom
   )

:Confirm & :: 确认选择[infinity]

   cls
   set %ERRORLEVEL%=0
   echo 你确定选择无限模式吗?
   echo 无限模式只能用 Ctrl+C 或 关闭窗口(不推荐) 来关闭服务器
   echo 输入Y确认, 输入N回到选择界面
   choice /C:YN /N
   set _erl=%ERRORLEVEL%
   if %_erl%==2 goto :Choose
   if %_erl%==1 goto :Start_Server

:Modify_MODs_PLGs

 :: 代码写的稀烂...
 :: 我想 DISABLED 掉

   cls
   if %_mod%==false (
      echo 似乎...这是Minecraft原版核心!
      echo 原版核心不可加载插件/模组
      echo 正在退回...
      goto :Server_Action_Center
   )
   echo 请选择项目:
   echo   [1]MOD
   echo   [2]PLUGIN
   echo   [3]返回服务器操作中心
   echo 输入选择的菜单项:
   choice /C:120 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 goto :Modify_MODs
   if %_erl%==2 goto :Modify_PLUGINs
   if %_erl%==3 goto :Server_Action_Center

   :Modify_MODs

      if not exist ".\mods" (
        echo [ERROR]:没有mods文件夹 
        echo [INFO]:创建中...
        md .\mods
        echo [INFO]:创建完成!
      ) 
      cd ".\mods"
      dir
      goto :un_ban

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
               goto :Server_Action_Center
            ) else ( 
               if exist ".\%_mods_plgs%.disabled" (
                  ren ".\%_mods_plgs%.disabled" %_mods_plgs%
                  echo 模组/插件 %_mods_plgs% 已启用
                  cd ..
                  goto :Server_Action_Center
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
   goto :Server_Action_Center

:setServer & :: 设置核心(如果未检测到)

   echo 请输入核心名称:
   set /p "_Server="
   if not exist ".\*.jar" (
      echo 没有核心？
      echo 赶紧去下载一个
      echo 想要开什么服务器？
      echo     [1] vanilla 原版服务器
      echo     [2] Fabric 推荐高版本
      echo     [3] Forge 推荐低版本
      echo     [4] Carpet 必须安装Fabric
      echo     [5] MCDR qb不是梦(但是 MCDR 只是服务器的壳子，里面还要装服务器...)
      echo     [6] Bukkit
      echo     [7] Paper
      echo     [8] Purpur
      echo     [9] Arclight
      echo     [0] 打开浏览器
      choice /C:1234567890 /N
      pause >nul
      set _erl=%ERRORLEVEL%
      if %_erl%==1 (
         start https://www.fastmirror.net/#/download/Vanilla?coreVersion=release
      )
      if %_erl%==2 (
         start https://fabricmc.net
      )
      if %_erl%==3(
         start https://www.fastmirror.net/#/download/Forge?coreVersion=1.19.3
      )
      if %_erl%==4 (
         echo 先装 Fabric 再说
         echo Fabric 和 Fabric Api 是 Carpet 的前置要求
         echo 可以用 cmcl 的模组下载器下载
         echo 安装命令：cmcl mod --install --source=cf --id=349239
      )
      if %_erl%==5 (
         start https://github.com/xieyuen/Tool-Gallery/blob/main/MCDR-Installer/README.md
      )
      if %_erl%==8 (
         start https://www.fastmirror.net/#/download/Purpur?coreVersion=1.19.3
      )
      if %_erl%==9 (
         start https://www.fastmirror.net/#/download/Arclight?coreVersion=GreatHorn
      )
      if %_erl%==10 (
         start https://www.fastmirror.net
      )
      echo 去下载吧（
      echo 下完之后再开脚本
      pause >nul
      exit /b
   )
   if exist ".\%_Server%" (
      echo 检测到核心:%_Server% 
      set "_ACS=unAutoCheckingServer"
      goto :Server_Action_Center
   ) 
   if exist ".\%_Server%.jar" (
      set _Server=%_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      echo 检测到核心:%_Server% 
      goto :Server_Action_Center
   )
   if exist ".\%_Server%.ban" (
      ren ".\%_Server%.ban" %_Server% 
      echo 服务器核心 %_Server% 已启用并选择 
      set "_ACS=unAutoCheckingServer"
      goto :Server_Action_Center
   )
   if exist ".\%_Server%.disabled" (
      ren ".\%_Server%.disabled" %_Server% 
      set "_ACS=unAutoCheckingServer"
      echo 服务器核心 %_Server% 已启用并选择 
      goto :Server_Action_Center
   )
   if exist ".\%_Server%.jar.ban" (
      ren ".\%_Server%.jar.ban" %_Server%.jar 
      set _Server=%_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      echo 服务器核心 %_Server% 已启用并选择 
      goto :Server_Action_Center
   )
   if exist ".\%_Server%.jar.disabled" (
      ren ".\%_Server%.jar.disabled" %_Server%.jar 
      set "_ACS=unAutoCheckingServer"
      set _Server=%_Server%.jar 
      echo 服务器核心 %_Server% 已启用并选择 
      goto :Server_Action_Center
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
         goto :Server_Action_Center
      )
      if %_erl%==2 goto :AutoCheckingServer
      if %_erl%==1 goto :setServer
   )
   set "_Server=Start.jar"
   echo 已选择默认核心:Start.jar
   set "_ACS=unAutoCheckingServer"
   goto :Server_Action_Center

:AutoCheckingServer & :: 检测核心

   echo 自动检测核心中......
   :: Fabric 核心
   if exist ".\fabric-server-launch.jar" (
      set _Chk_Server=true
      set "_Server=fabric-server-launch.jar"
      set "_mod=true"
      echo 检测到核心:fabric-server-launch.jar
      goto :Server_Action_Center
   )
   :: Quilt 核心
   if exist ".\quilt-server-launch.jar" (
      set _Chk_Server=true
      set "_Server=quilt-server-launch.jar" 
      set "_mod=true"
      echo 检测到核心:quilt-server-launch.jar 
      goto :Server_Action_Center
   )
   :: Bungeecord 核心
   if exist ".\BungeeCord.jar" (
      set _Chk_Server=true
     set "_Server=BungeeCord.jar"
     set _mod=true
     set _RAMmax=512
     echo 咦,竟然有人用这个脚本跑BungeeCord
     echo 先砍内存占用（
     goto :Server_Action_Center
   )
   :: Vanilla 核心
   if exist ".\Server.jar" (
      set _Chk_Server=true
      set "_Server=Server.jar" 
      set "_mod=false"
      echo 检测到核心:Server.jar 
      goto :Server_Action_Center
   )
   if exist ".\minecraft_server.jar" (
      set _Chk_Server=true
      set "_Server=minecraft_server.jar"
      set "_mod=false" 
      echo 检测到核心:minecraft_server.jar 
      goto :Server_Action_Center
   )
   if exist ".\minecraft-server.jar" (
      set _Chk_Server=true
      set "_Server=minecraft-server.jar"
      set "_mod=false"
      echo 检测到核心:minecraft-server.jar
      goto :Server_Action_Center
   )
   echo 未检测到服务器核心! 
   goto :setServer

::============================================================================================================================

:Start_Server

   title 服务器运行中 [重启次数:%_restart_dp%次] 请勿关闭窗口!!!
   echo =========================================
   echo               服务器正在开启
   echo           The server is starting!
   echo =========================================
   powershell /C %_Java% -jar -Dfile.encoding=GBK -Xms%_RAMmin%M -Xmx%_RAMmax%M %_Server% nogui
   if "%_eula%==false" goto :First_Start
   set /a _restart+=1
   set /a _restart_dp+=1
   if %_chk_mod%==infinity goto :Start_Server
   if %_chk_mod%==1 goto :restart_1
   if %_chk_mod%==5 goto :restart_5
   if %_chk_mod%==10 goto :restart_10
   if %_chk_mod%==0 goto :Server_Crash
   if "%_chk_mod%==Custom" goto :restart_Custom

   :restart_1

      if %_restart%==1 goto :Server_Crash
      goto :Start_Server

   :restart_5

      if %_restart%==6 goto :Server_Crash 
      goto :Start_Server

   :restart_10

      if %_restart%==11 goto :Server_Crash
      goto :Start_Server

   :restart_Custom

      if %_restart%==%_restart_custom% goto :Server_Crash
      goto :Start_Server

   :First_Start & :: 必须修改

      echo Minecraft EULA 协议未同意!
      echo 请同意协议, 协议文件在服务器根目录下的EULA.txt
      echo 同意协议方法: 打开eula.txt, 更改 eula=false 为 eula=true 并保存
      echo 同意协议后请按任意键继续...
      pause >nul
      if exist ".\EULA.TXT" (
         set _eula=true
         set "_temp=eula-false"
         goto :Save_Config
      )
      goto :Start_Server

:Server_Crash & :: 崩溃

   set _restart=0
   title 服务器已停止 :(
   echo =========================================
   echo             服务器总计崩溃%_restart_dp%次
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
     goto :Welcome
   )
   if %_erl%==3 goto :Choose
   if %_erl%==2 goto :Initialize
   if %_erl%==1 exit /b

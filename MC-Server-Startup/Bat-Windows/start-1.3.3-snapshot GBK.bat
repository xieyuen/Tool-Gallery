:: 调试
 @echo off
 chcp 936 & :: 设置代码页 GBK
 set RAMmax=4096
 set RAMmin=0
 set restart=0 & :: 设置重启变量
 set error=0 & :: 设置重启显示次数
 if exist eula.txt (
   set eula=true 
 ) else ( 
   set eula=false 
 )
 cls

::============================================================================================================================

:Welcome & ::欢迎界面
 title Hello! %username%, 欢迎使用此脚本
 echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 echo 欢迎%username%使用此脚本!
 echo 脚本版本: 1.3.2 snapshot GBK
 echo 此脚本为快照版, 有BUG请邮箱 xieyuen163@163.com
 echo --------------------------------------
 echo 更新日志:
 echo 1.添加服务器开服方式选择
 echo --------------------------------------
 echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 goto CheckServer

:Settings & :: 设置界面
 echo 服务器当前设置:
 echo   核心:%Server% 最大内存占用:%RAMmax%MB 最小内存占用:%RAMmin%MB
 echo 请选择操作:
 echo   [1]开启服务器
 echo   [2]调整服务器核心
 echo   [3]调整最大内存占用
 echo   [4]调整最小内存占用
 echo   [5]禁用/解禁模组和插件
 echo 输入选择的菜单项:
 choice /C:12345 /N
 set _erl=%errorlevel%
 if %_erl%==1 goto Choose
 if %_erl%==2 goto setServer
 if %_erl%==3 goto setRAMmax
 if %_erl%==4 goto setRAMmin
 if %_erl%==5 goto Modify_MODs_PLUGINs

:setRAMmin
 echo 请输入服务器最小内存占用(单位:MB,1GB=1024MB), 默认值:0
 set /p "RAMmin="
 goto Check_RAM

:setRAMmax
 echo 请输入服务器最大内存占用(单位:MB,1GB=1024MB), 默认值:4096
 set /p "RAMmax="
 goto Check_RAM

:Choose & :: 开服方式选择
 set %ERRORLEVEL%=0
 echo 请选择开服方式:
 echo   [1]自动重启5次
 echo   [2]自动重启10次
 echo   [I]无限自动重启
 echo   [0]返回设置
 echo 输入选择的菜单项:
 choice /C:12I0 /N
 set _erl=%errorlevel%
:: 检测所选方式
 if %_erl%==1 set chk_mod=5 & goto Start
 if %_erl%==2 set chk_mod=10 & goto Start 
 if %_erl%==3 set chk_mod=infinity & goto Confirm
 if %_erl%==4 goto Settings

:Confirm & :: 确认选择[infinity]
 set %ERRORLEVEL%=0
 echo 你确定选择无限模式吗?
 echo 无限模式只能用 Ctrl+C 或 关闭窗口(不推荐) 来关闭服务器
 echo 输入Y确认, 输入N回到选择界面
 choice /C:YN /N
 set _erl=%errorlevel%
 if %_erl%==2 goto Choose
 if %_erl%==1 goto Start

:Modify_MODs_PLUGINs
if %Server%=minecraft_server (
  echo 似乎...这是Minecraft原版核心!
  echo 原版核心不可加载插件/模组
  echo 正在退回...
  goto Settings
)
 echo 请选择项目:
 echo   [1]MOD
 echo   [2]PLUGIN
 echo   [3]返回设置
 echo 输入选择的菜单项:
 choice /C:120 /N
 set _erl=%errorlevel%
 if %_erl%==1 goto Modify_MODs
 if %_erl%==2 goto Modify_PLUGINs
 if %_erl%==3 goto Settings
 :Modify_MODs
  if not exist ".\mods" (
    echo [ERROR]:没有mods文件夹 & echo 正在退回... & goto Settings 
  ) 
  cd ".\mods"
  dir
  goto un_ban
 :Modify_PLUGINs
  if not exist ".\plugins" ( 
    echo [ERROR]:没有plugins文件夹 & echo 正在退回... & goto Settings 
  )
  cd ".\plugins"
  dir
 :un_ban
  echo 请输入模组/插件名称:
  set /p "%mods_plugins%="
  if not exist ".\%mods_plugins%" ( 
    if exist ".\%mods_plugins%.jar" ( 
      set mods_plugins=%mods_plugins%.jar 
    ) else ( 
      if exist ".\%mods_plugins%.ban" ( 
        ren ".\%mods_plugins%.ban" %mods_plugins% & echo 模组/插件 %mods_plugins% 已启用 & cd .. & goto Settings
      ) else ( 
        echo [ERROR]:无法处理的错误[:(] & pause >nul & exit /b 
      ) 
    ) 
  )
  echo 请选择操作:{[1]禁用模组[2]启用模组}(直接输入序号)
  choice /C:12 /N
  if %errorlevel%==1 ( 
    ren ".\%mods_plugins%" %mods_plugins%.ban & echo 模组/插件 %mods_plugins% 已禁用 
  )
  if %errorlevel%==2 ( 
    ren ".\%mods_plugins%.ban" %mods_plugins% & echo 模组/插件 %mods_plugins% 已启用 
  )
  cd ..
  goto Settings

::============================================================================================================================

:CheckServer & :: 检测核心
 echo 自动检测核心中......
 if exist ".\fabric-server-launch.jar" set "Server=fabric-server-launch.jar" & echo 检测到核心:fabric-server-launch.jar & goto Settings
 if exist ".\quilt-server-launch.jar" set "Server=quilt-server-launch.jar" & echo 检测到核心:quilt-server-launch.jar & goto Settings
 if exist ".\Server.jar" set "Server=Server.jar" & echo 检测到核心:Server.jar & goto Settings
 if exist ".\minecraft_server.jar" set "Server=minecraft_server.jar" & echo 检测到核心:minecraft_server.jar & goto Settings
 echo 未检测到服务器核心! & goto setServer

:setServer & :: 设置核心(如果未检测到)
 echo 请输入核心名称(不要忘了.jar后缀)
 set /p "Server="
 
 ::if exist ".\%Server%" ( echo 检测到核心:%Server% & goto Settings) else ( if exist ".\%Server%.jar" ( set Server=%Server%.jar & echo 检测到核心:%Server% & goto Settings ) else ( if exist ".\%Server%.ban" ( ren ".\%Server%.ban" %Server% & echo 服务器核心 %Server% 已启用并选择 ) else ( echo [ERROR]:无法处理的错误[:(] & pause >nul & exit /b ) ) )
 if exist ".\%Server%" (
  echo 检测到核心:%Server% & goto Settings
 ) else (
  if exist ".\%Server%.jar" (
    set Server=%Server%.jar & echo 检测到核心:%Server% & goto Settings
  ) else (
    if exist ".\%Server%.ban" (
      ren ".\%Server%.ban" %Server% & echo 服务器核心 %Server% 已启用并选择 & goto Settings
    ) else (
      if exist ".\%Server%.jar.ban" (
        ren ".\%Server%.jar.ban" %Server%.jar & set Server=%Server%.jar & echo 服务器核心 %Server% 已启用并选择 & goto Settings
      ) else (
        echo [ERROR]:核心不存在!  & goto CheckServer
      )
    ) 
  )
 )
 ::echo [ERROR]:服务器核心不存在!
 ::echo 请检查拼写及确认脚本是否在服务器核心目录上(如果否, 请按Ctrl+C关闭脚本)
 ::goto setServer

:Check_RAM
 if /I %RAMmax% GEQ %RAMmin% echo 设置成功! & goto Settings
 echo [ERROR]:服务器内存最小值大于最大值 (min:%RAMmin% max:%RAMmax%)
 echo 请选择操作:
 echo   [1]重置值
 echo   [2]更改最大值
 echo   [3]更改最小值
 choice /C:123 /N
 if %errorlevel%==1 set RAMmax=4096 & set RAMmin=0 & goto Settings
 if %errorlevel%==2 goto setRAMmax
 if %errorlevel%==3 goto setRAMmin

::============================================================================================================================

:Start & :: 开服
 title 服务器运行中 [重启次数:%error%次] 请勿关闭窗口!!!
 echo =========================================
 echo               服务器正在开启
 echo           The server is starting!
 echo =========================================
 ".\java18\bin\java.exe" -jar -Dfile.encoding=GBK -Xms%RAMmin%M -Xmx%RAMmax%M %Server% nogui
 if %eula%==false goto First_Start
 set /a restart+=1
 set /a error+=1
 if %chk_mod%==5 goto restart_5
 if %chk_mod%==10 goto restart_10
 if %chk_mod%==infinity goto Start

:restart_5
 if %restart%==6 (goto Crash) 
 goto Start
:restart_10
 if %restart%==11 (goto Crash) 
 goto Start

:First_Start
 echo Minecraft EULA 协议未同意!
 echo 请同意协议, 协议文件在服务器根目录下的EULA.txt
 echo 同意协议方法: 打开eula.txt, 更改 eula=false 为 eula=true 并保存
 echo 同意协议后请按任意键继续...
 pause >nul
 if exist ".\EULA.TXT" set eula=true
 goto Start

:Crash & :: 崩溃
 set restart=0
 title 服务器已崩溃 :(
 echo =========================================
 echo             服务器已崩溃%error%次
 echo          服务器日志文件在.\logs\下
 echo        崩溃报告在.\crash-report\下
 echo        按C键关闭脚本, 按R键重启服务器
 echo           按B键重新选择开服模式
 echo             按P键重启整个脚本
 echo =========================================
 choice /C:CRBP /N
 set _erl=%errorlevel%
 if %_erl%==1 exit /b
 if %_erl%==2 goto Check
 if %_erl%==3 goto Choose
 if %_erl%==4 cls & goto Welcome

@rem 更新目标
@rem 1.给文本上色!
@rem 2.优化EULA协议
@rem  2.1.读取EULA内容
@rem  2.2.自动同意EULA
@rem 3.将参数保存至Config文件
::===========================================================================================================================
:: 调试
 @echo off
 chcp 936 & :: 设置代码页 GBK
 set RAMmax=4096
 set RAMmin=0
 set restart=0 & :: 设置重启变量
 set error=0 & :: 设置重启显示次数
 set "Java=.\Java18\bin\java.exe" & ::设置 Java 路径
 :: 必须修改
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
 echo 脚本版本: 1.3.6 snapshot GBK
 echo 此脚本为快照版, 有BUG请邮箱 xieyuen163@163.com
 echo --------------------------------------
 echo 更新日志:
 echo 1.修BUG
 echo --------------------------------------
 echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 goto CheckServer

:Settings & :: 设置界面
 echo 服务器当前设置:
 echo   核心:%Server% 
 echo   最大内存占用:%RAMmax%MB 
 echo   初始内存占用:%RAMmin%MB
 echo   Java路径:%Java%
 echo 请选择操作:
 echo   [1]开启服务器
 echo   [2]调整服务器核心
 echo   [3]调整最大内存占用
 echo   [4]调整初始内存占用
 echo   [5]禁用/解禁模组和插件
 echo   [6]更改Java路径
 echo   [0]退出脚本
 echo 输入选择的菜单项:
 choice /C:0123456 /N
 set erl=%errorlevel%
 if %erl%==1 (
    cls
    echo 真的要离开了吗?
    echo 给你个机会撤销你的选择
    echo [y]确定撤销
    echo [n]白白
    choice /N
    if %ERRORLEVEL%==1 (
        echo 耶( ?? ω ?? )y
        goto Welcome
    )
    if %errorlevel%==2 (
        echo 白白ヾ(?ω?`)o
        echo 你可以关闭这个窗口了
        echo 或者随便按些什么
        pause >nul
        exit /b
    )
 )
 if %erl%==2 goto Choose
 if %erl%==3 goto setServer
 if %erl%==4 goto setRAMmax
 if %erl%==5 goto setRAMmin
 if %erl%==6 goto Modify_MODs_PLGs
 if %erl%==7 goto Modify_Java
 if %ERRORLEVEL%==0 exit /b

:Modify_Java
 echo 请输入Java路径:
 set /p "Java="
 ::检查Java路径存在性
 if exist %Java% (
    echo 设置成功!
    pause
    cls
    goto Settings
 )
 if exist "%Java%\java.exe" (
    echo 你似乎是从资源管理器上复制的...?
    echo 别忘记了java.exe这东西
    echo 这次帮你补上哈~
    set "Java='%Java%\java.exe'"
    pause
    cls
    goto Settings
 )
 echo 大老粗!这没有java.exe嘛
 echo 已经切换为默认java.
 pause
 cls

:setRAMmin
 echo 请输入服务器初始内存占用(单位:MB,1GB=1024MB), 默认值:0
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
 set erl=%errorlevel%
:: 检测所选方式
 if %erl%==1 set chk_mod=5 & goto Start
 if %erl%==2 set chk_mod=10 & goto Start 
 if %erl%==3 set chk_mod=infinity & goto Confirm
 if %erl%==4 goto Settings

:Confirm & :: 确认选择[infinity]
 cls
 set %ERRORLEVEL%=0
 echo 你确定选择无限模式吗?
 echo 无限模式只能用 Ctrl+C 或 关闭窗口(不推荐) 来关闭服务器
 echo 输入Y确认, 输入N回到选择界面
 choice /C:YN /N
 set erl=%errorlevel%
 if %erl%==2 goto Choose
 if %erl%==1 goto Start

:Modify_MODs_PLGs
if %mod%==nul (
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
 set erl=%errorlevel%
 if %erl%==1 goto Modify_MODs
 if %erl%==2 goto Modify_PLUGINs
 if %erl%==3 goto Settings
 :Modify_MODs
  if not exist ".\mods" (
    echo [ERROR]:没有mods文件夹 
    echo 正在退回... 
    goto Settings 
  ) 
  cd ".\mods"
  dir
  goto un_ban
 :Modify_PLUGINs
  if not exist ".\plugins" ( 
    echo [ERROR]:没有plugins文件夹 
    echo 正在退回... 
    goto Settings 
  )
  cd ".\plugins"
  dir
 :un_ban
  echo 请输入模组/插件名称:
  echo 小提示:在命令行中选中文字再右键两次即可完成复制和粘贴
  echo 注意:不要复制后缀!
  set /p "%mods_plgs%="
  if not exist ".\%mods_plgs%" ( 
    if exist ".\%mods_plgs%.jar" ( 
      set mods_plgs=%mods_plgs%.jar 
    ) else ( 
      if exist ".\%mods_plgs%.ban" ( 
        ren ".\%mods_plgs%.ban" %mods_plgs% 
        echo 模组/插件 %mods_plgs% 已启用
        cd .. 
        goto Settings
      ) else ( 
        if exist ".\%mods_plgs%.disabled" (
            ren ".\%mods_plgs%.disabled" %mods_plgs%
            echo 模组/插件 %mods_plgs% 已启用
            cd ..
            goto Settings
        )
        echo [ERROR]:无法处理的错误[:(] 
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
  if %errorlevel%==1 ( 
    ren ".\%mods_plgs%" %mods_plgs%.ban 
    echo 模组/插件 %mods_plgs% 已禁用 
  )
  if %errorlevel%==2 ( 
    if exist ".\%mods_plgs%.ban" (
        ren ".\%mods_plgs%.ban" %mods_plgs% 
    )
    if exist ".\%mods_plgs%.disabled" (
        ren ".\%mods_plgs%.disabled" %mods_plgs% 
    )
    echo 模组/插件 %mods_plgs% 已启用 
  )
  cd ..
  goto Settings

::============================================================================================================================

:CheckServer & :: 检测核心
 echo 自动检测核心中......
 if exist ".\fabric-server-launch.jar" (
    set Check_Server=true
    set "Server=fabric-server-launch.jar"
    echo 检测到核心:fabric-server-launch.jar
    goto Settings
 )
 if exist ".\quilt-server-launch.jar" (
    set Check_Server=true
    set "Server=quilt-server-launch.jar" 
    echo 检测到核心:quilt-server-launch.jar 
    goto Settings
 )
 if exist ".\Server.jar" (
    set Check_Server=true
    set "Server=Server.jar" 
    set "mod=nul"
    echo 检测到核心:Server.jar 
    goto Settings
 )
 if exist ".\minecraft_server.jar" (
    set Check_Server=true
    set "Server=minecraft_server.jar"
    set "mod=nul" 
    echo 检测到核心:minecraft_server.jar 
    goto Settings
 )
 if exist ".\minecraft-server,jar" (
    set Check_Server=true
    set "Server=minecraft-server.jar"
    set "mod=nul"
    echo 检测到核心:minecraft-server.jar
    goto Settings
 )
 echo 未检测到服务器核心! & goto setServer

:setServer & :: 设置核心(如果未检测到)
 echo 请输入核心名称
 set /p "Server="
 if exist ".\%Server%" (
    echo 检测到核心:%Server% 
    goto Settings
 ) 
 if exist ".\%Server%.jar" (
   set Server=%Server%.jar 
   echo 检测到核心:%Server% 
   goto Settings
 )
 if exist ".\%Server%.ban" (
    ren ".\%Server%.ban" %Server% 
    echo 服务器核心 %Server% 已启用并选择 
    goto Settings
 )
 if exist ".\%Server%.disabled" (
    ren ".\%Server%.disabled" %Server% 
    echo 服务器核心 %Server% 已启用并选择 
    goto Settings
 )
 if exist ".\%Server%.jar.ban" (
    ren ".\%Server%.jar.ban" %Server%.jar 
    set Server=%Server%.jar 
    echo 服务器核心 %Server% 已启用并选择 
    goto Settings
 )
 if exist ".\%Server%.jar.disabled" (
    ren ".\%Server%.jar.disabled" %Server%.jar 
    set Server=%Server%.jar 
    echo 服务器核心 %Server% 已启用并选择 
    goto Settings
 )
 if %Check_Server%==true (
    echo [ERROR]核心%Server%不存在!
    echo 请选择操作:
    echo  [1]自动检测
    echo  [2]手动输入
    choice /C:12 /N
    if %ERRORLEVEL%==2 goto CheckServer
    if %ERRORLEVEL%==1 goto setServer
 )
 echo [ERROR]:核心%Server%不存在!
 if %CheckServer%==true ( goto CheckServer ) else ( set "Server=Start.jar" )
 ::if %Check_Server%==true (
 ::   echo 准备自动检测...
 ::   goto CheckServer
 ::) 
 set "Server=Start.jar"
 echo 已选择默认核心:Start.jar
 goto Settings
 

:Check_RAM
 if /I %RAMmax% GEQ %RAMmin% (
    echo 设置成功! 
    goto Settings
 )
 echo [ERROR]:服务器内存初始值大于最大值 ( max:%RAMmax% min:%RAMmin% )
 echo 请选择操作:
 echo   [1]重置值
 echo   [2]更改最大值
 echo   [3]更改初始值
 choice /C:123 /N
 if %errorlevel%==1 set RAMmax=4096 & set RAMmin=0 & goto Settings
 if %errorlevel%==2 goto setRAMmax
 if %errorlevel%==3 goto setRAMmin
 if %ERRORLEVEL%==0 goto Settings
::============================================================================================================================

:Start & :: 开服
 title 服务器运行中 [重启次数:%error%次] 请勿关闭窗口!!!
 echo =========================================
 echo               服务器正在开启
 echo           The server is starting!
 echo =========================================
 powershell /C %Java% -jar -Dfile.encoding=GBK -Xms%RAMmin%M -Xmx%RAMmax%M %Server% nogui
 if %eula%==false goto First_Start
 set /a restart+=1
 set /a error+=1
 if %chk_mod%==5 goto restart_5
 if %chk_mod%==10 goto restart_10
 if %chk_mod%==infinity goto Start

:restart_5
 if %restart%==6 ( goto Crash ) 
 goto Start
:restart_10
 if %restart%==11 ( goto Crash ) 
 goto Start

:First_Start & :: 必须修改
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
 echo =========================================
 echo 按C键关闭脚本
 echo 按R键重启服务器
 echo 按B键重新选择开服模式
 echo 按P键重启整个脚本
 choice /C:CRBP /N
 set erl=%errorlevel%
 if %erl%==4 cls & goto Welcome
 if %erl%==3 goto Choose
 if %erl%==2 goto Check
 if %erl%==1 exit /b

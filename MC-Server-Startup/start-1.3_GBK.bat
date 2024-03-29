:: 调试
 @echo off
 chcp 936 & :: 设置代码页 GBK
 set _restart=0 & :: 设置重启变量
 set _error=0 & ::设置重启显示次数
 cls

::============================================================================================================================

:Welcome & ::
 title Hello! %username%, 欢迎使用此脚本
 echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 echo 欢迎%username%使用此脚本!
 echo 脚本版本: 1.3snapshot GBK
 echo 此脚本为快照版, 有BUG请邮箱 xieyuen163@163.com
 echo 使用时注意: 请将服务器核心名称改为Start.jar
 echo --------------------------------------
 echo 更新日志:
 echo 1.添加服务器开服方式选择
 echo --------------------------------------
 echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++

::============================================================================================================================

:Choose & ::开服方式选择
 set %ERRORLEVEL%=0
 echo 请选择开服方式:
 echo   [1]自动重启5次
 echo   [2]自动重启10次
 echo   [I]无限自动重启
 echo   [0]取消
 echo 输入选择的菜单项:
 choice /C:12I0 /N
 set _erl=%errorlevel%
 goto Check

:Check & :: 检测所选方式
 if %_erl%==1 set _chk=5 & goto Start
 if %_erl%==2 set _chk=10 & goto Start 
 if %_erl%==3 set _chk=-1 & goto Confirm
 if %_erl%==4 exit /b

:Confirm & :: 确认选择[infinity]
 set %ERRORLEVEL%=0
 echo 你确定选择无限模式吗?
 echo 无限模式只能用 Ctrl+C 或 关闭窗口(不推荐)停止
 echo 输入Y确认, 输入N回到选择界面
 choice /C:YN /N
 set _erl=%errorlevel%
 if %_erl%==2 goto Choose
 if %_erl%==1 goto Start

::============================================================================================================================

:Start & :: 开服
 title 服务器运行中 [重启次数:%_restart%次]
 echo =========================================
 echo               服务器正在开启
 echo           The server is starting!
 echo =========================================
 java -jar -Dfile.encoding=GBK -Xms1G Start.jar nogui
 set /a _restart+=1
 set /a _error+=1
 if %_chk%==5 goto 5
 if %_chk%==10  goto 10
 if %_chk%==-1  goto Start

:5
 if %_restart%==6 (goto Crash) 
 goto Start
:10
 if %_restart%==11 (goto Crash) 
 goto Start

:Crash & :: 崩溃
 set _restart=0
 title 服务器已崩溃 :(
 echo =========================================
 echo             服务器已崩溃%_error%次
 echo          重新开启脚本以重启服务器
 echo          服务器日志文件在.\logs\下
 echo        崩溃报告在.\crash-report\下
 echo           按C键关闭脚本, 按R键重启
 echo           按B键重新选择开服模式
 echo =========================================
 choice /C:CRB /N
 set _erl=%errorlevel%
 if %_erl%==1 exit /b
 if %_erl%==2 goto Check
 if %_erl%==3 goto Choose

@echo off
title _______ Minecraft Server {服务器核心:_______}
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo 欢迎使用此脚本! 
echo 此脚本由xieyuen编写
echo 脚本版本: 1.0-infinity
echo 脚本使用压缩包里的Java文件夹[Minecraft1.12.2及以下请换为Java11及以下], 请将其放至服务器根目录
echo 脚本会在10,20,30,40,50,60,70,80,90,100次重启时暂停
echo 想要更新的脚本私信QQ: 2035381689
echo =========================================
echo             服务器内存占用: 4GB
echo       使用此脚本的服务器会无限自动重启
echo             按Enter键开启服务器
echo =========================================
echo 注: 此版本要关闭服务器只能关闭cmd窗口
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
pause
set n=0
title _______ Minecraft Server [重启次数:%n%次]
echo =========================================
echo               服务器正在开启
echo           The server is starting!
echo =========================================
".\Java18\bin\java.exe" -jar-Dfile.encoding=GBK -Xmx4G -Xms4G _______.jar nogui
set /a n+=1 
:restart
echo =========================================
echo               服务器正在重启
echo          The server is restarting!
echo =========================================
title _______ Minecraft Server [重启次数:%n%次]
".\Java18\bin\java.exe" -jar -Dfile.encoding=GBK -Xmx4G -Xms4G _______.jar nogui
set /a n+=1
if %n%==10 goto StopRestart
if %n%==20 goto StopRestart
if %n%==30 goto StopRestart
if %n%==40 goto StopRestart
if %n%==50 goto StopRestart
if %n%==60 goto StopRestart
if %n%==70 goto StopRestart
if %n%==80 goto StopRestart
if %n%==90 goto StopRestart
if %n%==100 goto StopRestart
goto restart
:StopRestart
title 服务器已崩溃 :(
echo =========================================
echo             服务器已崩溃%n%次
echo       错误报告请看.\logs\latest.log
echo            按Enter键重启服务器
echo =========================================
pause
goto restart
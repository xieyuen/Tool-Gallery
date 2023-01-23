@echo off
title Minecraft BungeeCord Server {服务器核心:BungeeCord}
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo 欢迎使用此脚本! 
echo 此脚本由xieyuen编写
echo 脚本版本: 1.0-bungeecord
echo 此版本为BungeeCord特制版
echo 脚本使用压缩包里的Java文件夹[Minecraft1.12.2及以下版本请换为Java8及以下], 请将其放至服务器根目录
echo 想要更新的脚本私信QQ: 2035381689
echo =========================================
echo            服务器内存占用: 512MB
echo             服务器会无限自动重启
echo             按Enter键开启服务器
echo =========================================
echo 注: 此版本要关闭服务器只能关闭cmd窗口
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
pause
set n=0
title Minecraft BungeeCord Server [重启次数:%n%次]
echo =========================================
echo               服务器正在开启
echo           The server is starting!
echo =========================================
".\Java18\bin\java.exe" -jar-Dfile.encoding=GBK -Xmx512M -Xms512M _______.jar nogui
set /a n+=1 
:restart
echo =========================================
echo               服务器正在重启
echo          The server is restarting!
echo =========================================
title Minecraft BungeeCord Server [重启次数:%n%次]
".\Java18\bin\java.exe" -jar -Dfile.encoding=GBK -Xmx512M -Xms4G _______.jar nogui
set /a n+=1
goto restart
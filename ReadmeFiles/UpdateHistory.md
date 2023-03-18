# 更新历史 Update History

| 脚本名称 | [**开服脚本**](#开服脚本) | [**MCDR Installer**](#mcdr-installer) |
| :-: | :-----------: | :----------: |
| 最新版本 | 1.3.7 | 1.1 |
| 快照版 | 2.0.0 | None |
| README🔗链接 | [README](/MCDR-Installer/README.md) | [README](/MC-Server-Startup/README.MD) |

## [开服脚本](/MC-Server-Startup/README.MD#更新日志)

>快速跳转链接:
>
>- ~~0.0~~
>- [1.0](#版本-10)
>    - [1.1](#版本-11)
>    - [1.2](#版本-12)
>    - ~~1.3~~
>        - [1.3.0](#版本-130)
>        - [~~1.3.1~~](#版本-131)
>        - [1.3.2](#版本-132)
>        - [1.3.3](#版本-133)
>        - [1.3.4](#版本-134)
>        - [1.3.5](#版本-135)
>        - [1.3.6](#版本-136)
>        - [1.3.7](#版本-137)
>- [~~2.0~~](/MC-Server-Startup/README.MD#版本-200)

>### 版本 [*1.3.7*](/MC-Server-Startup/Bat-Windows/start-1.3.7-snapshot%20GBK.bat)<br>
>```diff
>+ 1. 添加模组/插件内添加 mods/plugins 文件夹的功能
>2. 优化了手动选择核心出错的界面
>3. 优化了部分代码
>```

>### 版本 [*1.3.6*](/MC-Server-Startup/Bat-Windows/start-1.3.6-snapshot%20GBK.bat)<br>
>```diff
>+ 1. 添加 Settings 界面退出选项
>2. 优化 Java 路径选择
>```

>### 版本 [*1.3.5*](/MC-Server-Startup/Bat-Windows/start-1.3.5-snapshot%20GBK.bat)<br>
>```diff
>+ 1. 添加对 .disabled 禁用方式读取支持(但是脚本内禁用的方式还是 .ban )
>+ 2. 添加自定义 Java 路径支持
>3. 完善 vanilla 核心检测
>4. 对崩溃界面作了小调整
>- 5. 取消自动检测对 Forge 的支持(这个支持问题很大啊，暂时只能删了)
>```

>### 版本 [*1.3.4*](/MC-Server-Startup/Bat-Windows/start-1.3.4-snapshot%20GBK.bat)<br>
>```diff
>1. 修改 vanilla 核心检测
>+ 2. 功能“禁用/解禁模组和插件”增加 是否可加载模组判断
>3. 优化了部分代码
>```

>### 版本 [*1.3.3*](/MC-Server-Startup/Bat-Windows/start-1.3.3-snapshot%20GBK.bat)<br>
>```diff
>+添加功能: 禁用/解禁模组和插件
>```

>### 版本 [*1.3.2*](/MC-Server-Startup/Bat-Windows/start-1.3.2-snapshot%20GBK.bat)<br>
>**又是一个重大更新**
>```diff
>+ 1. 添加操作中心
>+ 2. 添加功能: 
>+        i. 更改内存初始占用大小
>+        ii. 更改内存最大占用大小
>+        iii. 自动检测服务器核心
>+        iv. 手动更改服务器核心
>+        v. [EULA未同意提示](<> "有待优化")
>```
>[查看支持自动检测的核心](</MC-Server-Startup/README.md#支持检测的核心> "Fabric, Quilt, Forge, Vanilla")

>### ~~版本 [*1.3.1*](/MC-Server-Startup/Bat-Windows/start-1.3.1-snapshot%20GBK.bat)~~
>~~尝试添加文字颜色失败~~

>### 版本 [*1.3.0*](/MC-Server-Startup/Bat-Windows/start-1.3_GBK.bat)<br>
>**重大更新!**
>1. **界面优化**
>    1. 添加脚本开服方式选择!
>    2. 自动重启次数用完后可选择:
>       - 重启服务器
>       - 重选模式
>       - 退出脚本
><br><br>
>
>##### ~~*但还要改核心名为 Start.jar*~~

>### 版本 [*1.2*](/MC-Server-Startup/Bat-Windows/start-1.2-snapshot%20GBK.bat)<br>
>1. 多了GB2312和UTF8编码
>2. [添加了亿点点东西](<> "但还是要自己填很多东西")

>### 版本 [1.1](/MC-Server-Startup/Bat-Windows/start-1.1-test.bat)<br>
>1. 改变编码为GB3212

>### 版本 [1.0](<#版本-200> "用更新的吧")<br>
>
>分出了好多个小版本<br>
>学会自动重启了(
>
>>#### 版本 [1.0-Bungeecord](/MC-Server-Startup/Bat-Windows/start-1.0-bungeecord.bat)<br>
>>>只支持无限重启，代码扔这了(

~~~ bat
@echo off
title Minecraft BungeeCord Server {服务器核心:BungeeCord}
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo 欢迎使用此脚本! 
echo 此脚本由xieyuen编写
echo 脚本版本: 1.0-bungeecord
echo 此版本为BungeeCord特制版
echo 脚本使用压缩包里的Java文件夹[Minecraft1.12.2及以下版本请换为Java8及以下], 请将其放至服务器根目录
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
~~~

>>#### 版本 [1.0-infinity](/MC-Server-Startup/Bat-Windows/start-1.0-infinity.bat)<br>
>>>只支持无限重启，代码扔这了(

~~~ bat
@echo off
title _______ Minecraft Server {服务器核心:_______}
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo 欢迎使用此脚本! 
echo 此脚本由xieyuen编写
echo 脚本版本: 1.0-infinity
echo 脚本使用压缩包里的Java文件夹[Minecraft1.12.2及以下请换为Java11及以下], 请将其放至服务器根目录
echo 脚本会在10,20,30,40,50,60,70,80,90,100次重启时暂停
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
~~~

[我都没脸放出来了（](/MC-Server-Startup/Bat-Windows/start-0.0.bat "java -jar ______.jar")
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

---

## [MCDR Installer](/MCDR-Installer/README.md)

>### 版本 [*1.0*](/MCDR-Installer/MCDRinstaller.bat)
>1. 完成内容
>    - `安装 MCDR`
>    - `更新 MCDR`
>    - `MCDR 开启脚本的导出`
>
>2. 完成部分对英语的支持

>### 版本 [*1.1*](/MCDR-Installer/MCDRinstaller-1.1.bat)
>- 添加源码启动修正
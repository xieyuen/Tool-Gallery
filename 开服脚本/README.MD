# 服务器开服脚本<br>
~~这东西是我随便编的(~~<br>
<br>

## 

## 使用前必看
- **脚本要求**
    - 操作系统: **Windows**
    - 版本: Minecraft **Java** Edition
    - ***1.2版本及以下* 需要自己填写部分信息**

---

- 有BUG来找我<br>
    - **Email**: <xieyuen163@163.com>

最新版本: [***1.3.7***](<start-1.3.7-snapshot%20GBK.bat> "其实有 2.0.0 (")

---

## 一些Q&A:

Q: 为什么下载到的脚本名字版本和界面显示版本对不上?<br>

A: emm...我忘改了つ﹏⊂<br>更新内容以[README.MD](<README.MD> "就是这篇")为准，脚本版本以[名字](<> "除非你改名了")为准

---

## 更新日志
### 已有版本:
- 0.0
- 1.0
    - 1.1
    - 1.2
    - 1.3
        - 1.3.0
        - 1.3.1
        - 1.3.2
        - 1.3.3
        - 1.3.4
        - 1.3.5
        - 1.3.6
        - 1.3.7

---

>### ~~更新预告 !~~
>#### ~~版本 [*2.0.0*](<> "你想看?想得美")~~<br>
>1. ~~尝试将参数保存至Config文件内并读取~~
>2. ~~添加自动检测对Forge等核心的支持~~
>3. ~~代码大改写!~~
>4. ~~添加操作中心"清屏"选项~~

---

>### 版本 [*1.3.7*](start-1.3.7-snapshot%20GBK.bat)<br>
>1. 添加模组/插件内添加mods/plugins文件夹的功能
>2. 优化了手动选择核心出错的界面
>3. 优化了部分代码

---

>### 版本 [*1.3.6*](start-1.3.6-snapshot%20GBK.bat)<br>
>1. 添加Settings界面退出选项
>2. 优化Java路径选择

---

>### 版本 [*1.3.5*](start-1.3.5-snapshot%20GBK.bat)<br>
>1. [添加对.disabled禁用方式读取支持](<> "但是脚本内禁用的方式还是.ban")
>2. 添加自定义Java路径支持
>3. 完善vanilla核心检测
>4. 对崩溃界面作了小调整
>5. 取消自动检测对Forge的支持

---

>### 版本 [*1.3.4*](start-1.3.4-snapshot%20GBK.bat)<br>
>1. 修改vanilla核心检测
>2. 功能“禁用/解禁模组和插件”<br>增加 是否可加载模组判断
>3. 优化了部分代码

---

>### 版本 [*1.3.3*](start-1.3.3-snapshot%20GBK.bat)<br>
>- 添加功能:
>      - 禁用/解禁模组和插件

---

>### 版本 [*1.3.2*](start-1.3.2-snapshot%20GBK.bat)<br>
>**又是一个重大更新**
>1. 添加操作中心
>2. 添加功能: 
>       1. 更改内存初始占用大小
>       2. 更改内存最大占用大小
>       3. 自动检测服务器核心<br> [查看支持自动检测的核心](<README.MD> "Fabric, Quilt, Forge, Vanilla")
>       4. 手动更改服务器核心
>       5. EULA未同意提示【有待优化】

---

>### 版本 [*1.3.1*](start-1.3.1-snapshot%20GBK.bat)<br>
>~~尝试添加文字颜色失败~~

---

>### 版本 [*1.3.0*](start-1.3_GBK.bat)<br>
>**重大更新!**
>1. **界面优化**
>    1. 添加脚本开服方式选择!
>    2. 自动重启次数用完后可选择:
>       - 重启服务器
>       - 重选模式
>       - 退出脚本<br><br>
>
>~~*但还要改核心名为Start.jar*~~

---

>### 版本 [*1.2*](start-1.2-snapshot%20GBK.bat)<br>
>1. 多了GB2312和UTF8编码
>2. [添加了亿点点东西](<> "但还是要自己填很多东西")

---

>### 版本 [1.1](start-1.1-test.bat)<br>
>1. 改变编码为GB3212

---

>### 版本 [1.0]()<br>
>
>分出了好多个小版本<br>
>学会自动重启了(
>
>>#### 版本 [1.0-Bungeecord](start-1.0-bungeecord.bat)<br>
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

>>#### 版本 [1.0-infinity](start-1.0-infinity.bat)<br>
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

>### 版本 [0.0](<> "就一行代码而已，还不如用更新的")<br>
>>仅仅只有一行代码:<br>

`java -jar ____.jar`

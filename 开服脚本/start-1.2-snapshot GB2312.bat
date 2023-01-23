@rem 前言
 @rem 此脚本可更改的内容会有"______"标记(6个_)
 @rem 请使用GB2312编码编辑脚本[推荐使用专业编辑器编辑,比如VSCode, Notepad++等]
 @rem Please edit the script using GB2312 encoding
 @rem 以下为脚本内容

@echo off
 @rem 设置代码页 GB2312
  chcp 936
 cls

:Welcome
 @rem 设置标题
  title ______
 @rem 输出
  echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  echo 欢迎%username%使用此脚本!
  echo 脚本版本: 1.2snapshot GB2312
  echo 此脚本为快照版, 有BUG请邮箱 xieyuen163@163.com
  echo ---------------------------
  echo 更新计划:
  echo    解决问题:
  echo    【严重】后台打中文出现乱码
  echo ---------------------------
  echo           按任意键开启服务器
  echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pause

@rem 预处理
:pretreatment
 @rem 多核心更换
  @rem 如果服务器有多个核心, 且用不同的API, 用下面的命令解禁/禁用模组
   @rem 禁用 ren .\mods\______.jar ______.jar.ban
   @rem 解禁 ren .\mods\______.jar.ban ______.jar
  @rem 调整核心则用
   @rem 禁用 ren .\______.jar ______.jar.ban
   @rem 解禁 ren .\______.jar.ban ______.jar
 @rem 将命令打在本行注释下面

@rem 开服命令设置
:Start 
 @rem 设置变量n=0
 set n=0
 @rem 设置标题
  title ______ [重启次数:%n%次]
 echo =========================================
 echo               服务器正在开启
 echo           The server is starting!
 echo =========================================
 @rem 开服[GB2312编码]
 @rem "______.jar"填服务器核心名, "-Xmx______"内存占用最大值, "-Xms______"内存占用最小值, 单位M或G(1024M=1G)
  ".\Java18\bin\java.exe" -jar -Dfile.encoding=GB2312 -Xmx______ -Xms______ ______.jar nogui
 set /a n+=1
 @rem 在n=______[重启n-1次]时转到崩溃输出
  if %n%==______ goto Crash
  goto Start

@rem 崩溃输出
:Crash
 title 服务器已崩溃 :(
 echo =========================================
 echo             服务器已崩溃%n%次
 echo          重新开启脚本以重启服务器
 echo            日志文件在.\logs\下
 echo        崩溃报告在.\crash-report\下
 echo              按任意键关闭脚本
 echo =========================================
 pause
 exit

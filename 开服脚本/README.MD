# 服务器开服脚本

~~这东西是我随便编的(~~

## 使用前必看

- **脚本要求**
    - 操作系统: [**Windows**](<https://baike.baidu.com/item/Microsoft%20Windows/3304184#:~:text=Microsoft%20Windows%E6%98%AF%E7%BE%8E%E5%9B%BD%E5%BE%AE%E8%BD%AF%E5%85%AC%E5%8F%B8%E4%BB%A5%E5%9B%BE%E5%BD%A2%E7%94%A8%E6%88%B7%E7%95%8C%E9%9D%A2%E4%B8%BA%E5%9F%BA%E7%A1%80%E7%A0%94%E5%8F%91%E7%9A%84%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%EF%BC%8C%E4%B8%BB%E8%A6%81%E8%BF%90%E7%94%A8%E4%BA%8E%E8%AE%A1%E7%AE%97%E6%9C%BA%E3%80%81%E6%99%BA%E8%83%BD%E6%89%8B%E6%9C%BA%E7%AD%89%E8%AE%BE%E5%A4%87%E3%80%82%20%E5%85%B1%E6%9C%89%E6%99%AE%E9%80%9A%E7%89%88%E6%9C%AC%E3%80%81%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%89%88%E6%9C%AC%EF%BC%88Windows,Server%EF%BC%89%E3%80%81%E6%89%8B%E6%9C%BA%E7%89%88%E6%9C%AC%EF%BC%88Windows%20Phone%E7%AD%89%EF%BC%89%E3%80%81%E5%B5%8C%E5%85%A5%E5%BC%8F%E7%89%88%E6%9C%AC%EF%BC%88Windows%20CE%E7%AD%89%EF%BC%89%E7%AD%89%E5%AD%90%E7%B3%BB%E5%88%97%EF%BC%8C%E6%98%AF%E5%85%A8%E7%90%83%E5%BA%94%E7%94%A8%E6%9C%80%E5%B9%BF%E6%B3%9B%E7%9A%84%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F%E4%B9%8B%E4%B8%80%E3%80%82> "有可能在Windows 3.0都能用（")
    - 版本: Minecraft **Java** Edition
    - ~~***1.2版本及以下* 需要自己打开脚本编辑部分信息**~~

- 脚本只有GBK编码，其他请自行转码（

- 有BUG来找我
    - **Email**: ***<xieyuen163@163.com>***
    - **KOOK**: *xieyuen#9591*

最新版本: [***1.3.7***](#版本-137 "其实有 2.0.0 (")

---

## 默认配置文件

配置文件仅在 **2.0.0 版本及以上** 才可被脚本加载，旧版本**无法加载或保存配置**.

更改配置文件只能改 **“=”** 后面的，Java路径不需要双引号，直接复制到 [**=**](<> "中间的等于号") 及 [**"**](<> "后面的双引号") 之间即可.

配置文件名为 `config.bat`

>**请使用 [*GBK*](<https://zhidao.baidu.com/question/1180967443112212019.html> "在 Windows 简体中文版本中，记事本显示的 ANSI 编码即为 GBK 编码，但请尽量使用专业的文本编辑器，避免使用 Windows 自带的记事本，比如使用 VSCode.") 编码编辑配置文件！**<br>
>**请使用 *GBK* 编码编辑配置文件！**<br>
>**请使用 *GBK* 编码编辑配置文件！**

~~~bat
@rem 这是开服脚本的配置文件
@rem 每次保存都会覆盖掉你多余的字符 
@rem 不要乱改哦（特别是 “ = ” 前面的） 
@rem 要改也只能改每行 “=” 后面的 
@rem 下面就是配置内容啦

@rem 服务器核心名
set _Server=Start.jar

@rem 最大内存占用，单位 MB
set _RAMmax=4096

@rem 最小内存占用，单位 MB
set _RAMmin=0

@rem Java路径
set "_Java=.\Java18\bin\java.exe"

@rem EULA是否同意
@rem 同意 true
@rem 不同意 false
set "_eula=false"
~~~

---

## 一些Q&A

Q: 为什么下载到的脚本名字版本和界面显示版本对不上?<br>

A: emm...我忘改了つ﹏⊂<br>更新内容以[README.MD](</开服脚本/README.MD> "就是这篇")为准，脚本版本以[名字](<#已有版本> "除非你改名了")为准

---

## 支持检测的核心
目前可自动检测的核心有:
- [Fabric](<https://www.mcmod.cn/class/1411.html>)
- [Quilt](<https://www.mcmod.cn/class/3901.html>)
- [Bungeecord](<https://www.spigotmc.org/wiki/bungeecord/>)
- [Vanilla](<https://www.minecraft.net/zh-hans/download/server>)

---

[返回目录](../README.md)

---

## 更新日志

### 已有版本

- ~~0.0~~
- [1.0](/README/UpdateHistory.md#版本-10)
    - [1.1](/README/UpdateHistory.md#版本-11)
    - [1.2](/README/UpdateHistory.md#版本-12)
    - ~~1.3~~
        - [1.3.0](/README/UpdateHistory.md#版本-130)
        - [~~1.3.1~~](/README/UpdateHistory.md#版本-131)
        - [1.3.2](/README/UpdateHistory.md#版本-132)
        - [1.3.3](/README/UpdateHistory.md#版本-133)
        - [1.3.4](/README/UpdateHistory.md#版本-134)
        - [1.3.5](/README/UpdateHistory.md#版本-135)
        - [1.3.6](/README/UpdateHistory.md#版本-136)
        - [1.3.7](/README/UpdateHistory.md#版本-137)
- [~~2.0~~](#版本-200)

---

>### ~~更新预告 !~~
>#### ~~版本 [*2.0.0*](/%E5%BC%80%E6%9C%8D%E8%84%9A%E6%9C%AC/Bat-Windows/start-2.0.0-snapshot%20GBK.bat)~~
>1. ~~添加自动检测对Forge等核心的支持~~
>2. ~~代码大改写!~~
>3. ~~添加操作中心"清屏"选项~~
>4. ~~添加[配置文件相关内容](<#更新预告> "就不告诉你")~~

>### 版本 [*1.3.7*](/%E5%BC%80%E6%9C%8D%E8%84%9A%E6%9C%AC/Bat-Windows/start-1.3.7-snapshot%20GBK.bat)<br>
>1. 添加模组/插件内添加mods/plugins文件夹的功能
>2. 优化了手动选择核心出错的界面
>3. 优化了部分代码

>### 版本 [*1.3.6*](/%E5%BC%80%E6%9C%8D%E8%84%9A%E6%9C%AC/Bat-Windows/start-1.3.6-snapshot%20GBK.bat)<br>
>1. 添加Settings界面退出选项
>2. 优化Java路径选择

更多更新信息请在 [这里](/README/UpdateHistory.md#开服脚本 "Update History") 查看

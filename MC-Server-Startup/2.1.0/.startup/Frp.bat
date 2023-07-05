:: 调试
@echo off

:: 脚本编辑注意事项:
:: 行尾注释要在最后加 '&' 才能作为注释
:: 就像下面的，记得要空格

set _version=2.1.0 & :: 版本号

:: 这是 Frp 的开启脚本
:: 这将会对接至 main.bat

:Frp_Action_Center

   cls
   echo  Frp当前设置:
   echo     frp路径:%_Frpc%
   echo     frp设置路径:%_Frpc_Config%
   echo. 
   echo  请选择操作:
   echo     [1]开启frp
   echo     [2]导出frp启动脚本
   echo     [0]返回主操作中心

   choice /C:012 /N
   set _erl=%ERRORLEVEL%
   if %_erl%==1 call 2.1.0-main.bat
   if %_erl%==2 goto :Start_Frp
   if %_erl%==3 goto :Save_Frp

:Start_Frp

:Save_Frp

@echo off
cd /d %~dp0
set JAVA_HOME=C:\Program Files\Java\jdk-23
call "%~dp0mvnw.cmd" test

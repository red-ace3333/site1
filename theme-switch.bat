@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Hugo主题快速切换脚本 (Windows版本)
:: 用于在reimu和hugo-theme-stack主题之间切换

echo === Hugo主题切换工具 ===
echo.

:: 主题目录设置
set "THEME_DIR=%~dp0themes"
set "REIMU_ARCHIVE=%THEME_DIR%\reimu.archive"
set "STACK_ARCHIVE=%THEME_DIR%\hugo-theme-stack.archive"
set "REIMU=%THEME_DIR%\reimu"
set "STACK=%THEME_DIR%\hugo-theme-stack"
set "CONFIG_FILE=%~dp0hugo.yaml"
set "CONFIG_REIMU=%~dp0hugo-reimu.yaml"
set "CONFIG_STACK=%~dp0hugo-stack.yaml"

:: 当前主题检测
for /f "tokens=2" %%i in ('findstr "theme:" "%CONFIG_FILE%"') do set "CURRENT_THEME=%%i"

if not defined CURRENT_THEME (
    echo 错误：无法从配置文件获取当前主题！
    exit /b 1
)

echo 当前主题: %CURRENT_THEME%
echo.

:: 显示帮助信息
if "%~1"=="help" (
    echo 使用方法：%~nx0 [选项]
    echo.
    echo 选项：
    echo   stack    切换到 hugo-theme-stack 主题
    echo   reimu    切换到 reimu 主题
    echo   status   显示当前主题状态
    echo   help     显示帮助信息
    echo.
    echo 示例：
    echo   %~nx0 stack    ^| 切换到 hugo-theme-stack 主题
    echo   %~nx0 reimu    ^| 切换到 reimu 主题
    exit /b 0
)

:: 显示状态信息
if "%~1"=="status" (
    echo === 主题状态信息 ===
    echo 当前主题: %CURRENT_THEME%
    echo.
    echo 主题目录状态:
    
    if exist "%REIMU" (
        echo   reimu: 已激活
    ) else if exist "%REIMU_ARCHIVE" (
        echo   reimu: 已归档
    ) else (
        echo   reimu: 不存在
    )
    
    if exist "%STACK" (
        echo   hugo-theme-stack: 已激活
    ) else if exist "%STACK_ARCHIVE" (
        echo   hugo-theme-stack: 已归档
    ) else (
        echo   hugo-theme-stack: 不存在
    )
    echo.
    exit /b 0
)

:: 切换到hugo-theme-stack主题
if "%~1"=="stack" (
    echo 正在切换到 hugo-theme-stack 主题...
    echo.
    
    :: 检查hugo-theme-stack是否被归档
    if exist "%STACK_ARCHIVE" (
        echo   - 恢复hugo-theme-stack主题目录...
        rename "%STACK_ARCHIVE" "hugo-theme-stack"
    )
    
    :: 检查reimu是否需要归档
    if exist "%REIMU" (
        echo   - 归档reimu主题目录...
        rename "%REIMU" "reimu.archive"
    )
    
    :: 更新配置文件
    echo   - 更新配置文件...
    copy "%CONFIG_STACK%" "%CONFIG_FILE%" /y
    
    :: 清理构建缓存
    echo   - 清理构建缓存...
    if exist "%~dp0public" rmdir /s /q "%~dp0public"
    
    echo.
    echo ✅ 切换完成！
    echo 使用 hugo server -D 查看效果
    exit /b 0
)

:: 切换到reimu主题
if "%~1"=="reimu" (
    echo 正在切换到 reimu 主题...
    echo.
    
    :: 检查reimu是否被归档
    if exist "%REIMU_ARCHIVE" (
        echo   - 恢复reimu主题目录...
        rename "%REIMU_ARCHIVE" "reimu"
    )
    
    :: 检查hugo-theme-stack是否需要归档
    if exist "%STACK" (
        echo   - 归档hugo-theme-stack主题目录...
        rename "%STACK" "hugo-theme-stack.archive"
    )
    
    :: 更新配置文件
    echo   - 更新配置文件...
    copy "%CONFIG_REIMU%" "%CONFIG_FILE%" /y
    
    :: 清理构建缓存
    echo   - 清理构建缓存...
    if exist "%~dp0public" rmdir /s /q "%~dp0public"
    
    echo.
    echo ✅ 切换完成！
    echo 使用 hugo server -D 查看效果
    exit /b 0
)

:: 默认行为：如果当前是reimu主题，则切换到stack主题，否则切换到reimu主题
if "%CURRENT_THEME%"=="reimu" (
    call :switch_to_stack
) else (
    call :switch_to_reimu
)

exit /b 0

:: 函数定义
:switch_to_stack
    echo 正在切换到 hugo-theme-stack 主题...
    echo.
    
    if exist "%STACK_ARCHIVE" (
        echo   - 恢复hugo-theme-stack主题目录...
        rename "%STACK_ARCHIVE" "hugo-theme-stack"
    )
    
    if exist "%REIMU" (
        echo   - 归档reimu主题目录...
        rename "%REIMU" "reimu.archive"
    )
    
    echo   - 更新配置文件...
    powershell -Command "(Get-Content '%CONFIG_FILE%') -replace 'theme: reimu', 'theme: hugo-theme-stack' | Set-Content '%CONFIG_FILE%'"
    
    echo   - 清理构建缓存...
    if exist "%~dp0public" rmdir /s /q "%~dp0public"
    
    echo.
    echo ✅ 切换完成！
    echo 使用 hugo server -D 查看效果
    exit /b 0

:switch_to_reimu
    echo 正在切换到 reimu 主题...
    echo.
    
    if exist "%REIMU_ARCHIVE" (
        echo   - 恢复reimu主题目录...
        rename "%REIMU_ARCHIVE" "reimu"
    )
    
    if exist "%STACK" (
        echo   - 归档hugo-theme-stack主题目录...
        rename "%STACK" "hugo-theme-stack.archive"
    )
    
    echo   - 更新配置文件...
    copy "%CONFIG_REIMU%" "%CONFIG_FILE%" /y
    
    echo   - 清理构建缓存...
    if exist "%~dp0public" rmdir /s /q "%~dp0public"
    
    echo.
    echo ✅ 切换完成！
    echo 使用 hugo server -D 查看效果
    exit /b 0

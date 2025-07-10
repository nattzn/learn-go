@echo off

REM Go環境変数を設定
set GOOS=js
set GOARCH=wasm

REM 出力ディレクトリを設定
set OUT_DIR=..\docs\sum

REM 出力ディレクトリが存在しない場合は作成
if not exist "%OUT_DIR%" (
    mkdir "%OUT_DIR%"
)

REM wasmファイルをビルド
go build -o "%OUT_DIR%\main.wasm" sum.go
if errorlevel 1 (
    echo "Failed: WASM build"
    exit /b 1
)

copy index.html "%OUT_DIR%\" >nul
if errorlevel 1 (
    echo "Failed: Copying index.html"
    exit /b 1
)

REM GOROOTを取得
for /f "delims=" %%i in ('go env GOROOT') do set GOROOT=%%i

REM wasm_exec.jsをコピー
copy "%GOROOT%\lib\wasm\wasm_exec.js" "%OUT_DIR%\" >nul
if errorlevel 1 (
    echo "Failed: Copying wasm_exec.js"
    exit /b 1
)

echo "Succeeded: Build"

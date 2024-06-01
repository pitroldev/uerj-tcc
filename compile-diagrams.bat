@echo off

:: check if @mermaid-js/mermaid-cli is installed
where mmdc >nul 2>&1
if %errorlevel% neq 0 (
    echo mmdc could not be found
    echo Please install @mermaid-js/mermaid-cli using npm
    echo npm install -g @mermaid-js/mermaid-cli
    exit /b
)

:: check if diagrams folder exists
if not exist diagrams (
    echo diagrams folder not found
    exit /b
)

:: compile all diagrams
for %%f in (diagrams\*.mmd) do (
    set "filename=%%~nf"
    mmdc -i "%%f" -o "diagrams\%%~nf.png" -b transparent -s 2
)

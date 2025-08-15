# Python AI 開發環境啟動器 (Python AI Development Session Starter)

這是一個批次腳本 (`.bat`)，用於快速初始化和啟動一個專為 Python AI 開發設計的專案環境。它會自動處理虛擬環境的建立、必要套件的安裝、專案資料夾結構的生成，以及啟動 AI 助理 (Gemini 或 Claude) 的開發會話。

## 主要功能

- **互動式專案設定**：首次執行時，腳本會引導您設定專案名稱和主程式檔案。
- **自動化環境管理**：
    - 自動偵測並建立 Python 虛擬環境 (`venv`)。
    - 安裝/更新核心開發工具，如 `pip` 和 `ruff` (程式碼檢查工具)。
- **應用程式打包支援**：如果您計畫將專案打包成 `.exe` 執行檔，腳本會自動安裝 `FreeSimpleGUI` 和 `PyInstaller`。
- **專案結構生成**：
    - 為應用程式專案建立標準的資料夾結構 (`src`, `assets`, `config`, `data`)。
    - 自動生成 `build.bat` 腳本，用於一鍵打包您的應用程式。
    - 產生 `GEMINI.md` 和 `CLAUDE.md`，用於記錄專案資訊。
- **AI 助理整合**：您可以選擇啟動 Gemini 或 Claude 作為您的 AI 開發夥伴。
- **快速啟動模式**：對於已設定好的專案，腳本提供快速啟動模式，直接進入 AI 開發會話。

## 如何使用

### 首次建立新專案

1.  將 `Start-DevSession.bat` 檔案放到您想建立新專案的空資料夾中。
2.  直接執行 `Start-DevSession.bat`。
3.  **回答設定問題**：
    - **Project name**: 輸入您的專案名稱 (預設為當前資料夾名稱)。
    - **Main script file**: 輸入您的主程式檔案名稱 (預設為 `main.py`)。
    - **Will this project be packaged as .exe? (y/n)**: 如果您想將專案打包成執行檔，請輸入 `y`。
    - **Is this a GUI app? (y/n)**: (僅在上一題回答 `y` 時出現) 如果您的應用程式是圖形化介面 (GUI) 程式，請輸入 `y`。
4.  **選擇 AI 助理**：
    - 輸入 `1` 選擇 Gemini (預設)。
    - 輸入 `2` 選擇 Claude。
5.  腳本將會自動完成所有設定，並在一個新的命令提示字元視窗中啟動您選擇的 AI 助理開發會話。

### 針對已存在的專案

如果您的專案資料夾中已經存在 `venv` 虛擬環境，腳本會自動進入 **快速啟動模式**：

1.  執行 `Start-DevSession.bat`。
2.  直接選擇您想使用的 AI 助理。
3.  腳本會立即在新的視窗中啟動 AI 開發會話。

## 生成的專案結構 (應用程式專案)

當您選擇將專案打包成 `.exe` 時，腳本會為您建立以下結構：

```
/your-project-name
|
|-- src/              # 您的 Python 原始碼存放處
|   |-- main.py       # 您的主程式檔案
|
|-- assets/           # 靜態資源 (圖片、聲音檔等)
|-- config/           # 設定檔 (例如 .ini, .json)
|-- data/             # 資料檔案 (例如 .csv, .db)
|
|-- venv/             # Python 虛擬環境 (自動生成)
|-- build.bat         # 一鍵打包腳本 (自動生成)
|-- GEMINI.md         # AI 助理的專案說明檔
|-- CLAUDE.md         # AI 助理的專案說明檔
|-- Start-DevSession.bat
```

## `build.bat` 的使用

如果您建立了應用程式專案，可以直接執行 `build.bat` 來打包您的程式。

-   腳本會自動啟用虛擬環境，並使用 `PyInstaller` 將 `src` 資料夾中的主程式打包成單一的 `.exe` 檔案。
-   打包完成後，執行檔會出現在 `dist` 資料夾中。
-   `assets`, `config`, `data` 等資料夾也會被自動複製到 `dist` 目錄下，確保您的執行檔能順利存取這些資源。


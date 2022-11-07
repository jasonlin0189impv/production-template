# Development Guide

## 安裝開發環境

```sh
# 1. clone your fork and cd into the repo directory
git clone [production-template url]
cd production-template

# 2. 建立開發的 virtualenv
# or you can choose conda to create env
virtualenv -p `which python3.8` venv
source venv/bin/activate

# 3. 安裝 src dependencies
make install

# 4. 安裝 tests dependencies
make install-dev

```

## Code Style & Linting

- [flake8](https://github.com/PyCQA/flake8): 風格檢查
- [Black code style](https://black.readthedocs.io/en/stable/the_black_code_style.html): 風格檢查 & 自動格式化
- [mypy](https://github.com/python/mypy): Type 靜態檢查 
- [isort](https://pycqa.github.io/isort/): 自動格式化 import 順序

### 開發期間請善用 `make format`、`make lint` 檢查程式碼
> 若 IDE 有相關設定可以省略此步驟
- 執行 formatter 功能 (isort、black):
```sh
make format
```

- 執行 Lint 功能 (mypy、flake8、isort、black):
```sh
make lint
```

## Pre-commit Hooks

於 git commit/push 時會自動執行的指令，若因為這些自動執行的指令而更動到程式碼，**必須要再次進行 `git add & git commit & git push` 的操作**

**Python File 相關的 Hooks**
> 將於 git push 時自動執行
- [Code Style & Linting](#Code%20Style%20&%20Linting) 的 `make format` 與 `make lint` 指令

**Jupyter Notebook 相關的 Hooks**
> 將於 git commit 時自動執行
- [nbstripout](https://github.com/kynan/nbstripout): 自動清理 Jupyter Notebook 的 Output 
- [nbqa](https://github.com/nbQA-dev/nbQA): 自動格式化 Jupyter Notebook 的程式碼(black, isort)

### 手動安裝
> 若已執行過 [安裝開發環境](#安裝開發環境) 可省略此安裝步驟

Setup [`pre-commit`](https://pre-commit.com/) to automatically lint and format the codebase on commit:
1. Ensure that you have Python (3.8) with `pip`, installed.
2. Install `pre-commit` with `pip` &amp; install pre-push hooks
```sh
pip install pre-commit
pre-commit install --hook-type pre-push
```
3. On push, the pre-commit hook will run. This runs `make format` and `make lint`.

### 手動對所有檔案執行現有的 Hooks
pre-commit 每次都只會針對要 commit 的檔案做檢查
所以建議第一次加入 pre-commit 時，可以先檢查所有的檔案

```sh
pre-commit run --all-files
```

### nbstripout - 保留特定 cell/notebook 的 Output
>[nbstripout 官方說明](https://github.com/kynan/nbstripout#keeping-some-output)

預設將會把 Jupyter Notebook 的 output 刪除，若想要保留特定的 cell (cell Metadata) 或 notebook (Notebook Metadata) 要在 metadata 加上 `"keep_output": true, "init_cell": true,`

**Notebook Metadata Example**

Jupyter 編輯方式： [Edit] -> [Edit Notebook Metadata] 

```json
{
    ...
    "keep_output": true, 
    "init_cell": true
    ...
    ...
}
```


## 單元測試
- [pytest](https://docs.pytest.org/en/6.2.x/): 測試框架
- [mock](https://docs.python.org/3/library/unittest.mock.html): 建立 mock, stub 物件
- [monkeypatch](https://docs.pytest.org/en/6.2.x/monkeypatch.html): 使用 patch 相關操作
- [Lab 單元測試開發原則](https://docs.google.com/document/d/1H8RW--xX-yCKvAc8fK58TLMy5HuNGBs5sqNttDQKDNk/edit#heading=h.p1ufptqs4qnb)

### 開發期間請善用 `make test` 進行單元測試

```sh
make test
```

### 如果想執行特定模組測試, 可以執行以下指令
```sh
pytest tests/path_of_test_folder/test_file::test_function
pytest tests/path_of_test_folder/test_file::TestClass::test_function
```


## VS Code 設定檔

**settings.json**

```
{
    "editor.formatOnSave": true,
    "python.linting.enabled": true,
    "python.linting.flake8Enabled": true,
    "python.linting.flake8Args": [
        "--max-line-length=120",
        "--ignore=E203,E266,W503"
    ],
    "python.linting.mypyEnabled": true,
    "python.linting.mypyArgs": [
        "--ignore-missing-imports",
        "--disallow-untyped-defs",
        "--no-implicit-optional",
        "--check-untyped-defs",
        "--warn-return-any",
        "--exclude tests",
    ],
    "python.formatting.provider": "black",
    "python.formatting.blackArgs": [
        "-l 120"
    ],
    //isort 
    "[python]": {
        "editor.codeActionsOnSave": {
            "source.organizeImports": true
        }
    },
    "[html]": {
        "editor.formatOnSave": false
    },
    "python.testing.pytestArgs": [
        "tests"
    ],
    "python.testing.unittestEnabled": false,
    "python.testing.pytestEnabled": true,
}
```


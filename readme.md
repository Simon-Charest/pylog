# Python Microsoft Log Analyzer

## Setup
```powershell
cd C:\source
git clone https://github.com/Simon-Charest/pylog.git
cd C:\source\pylog
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```

## Run
```powershell
python . -h
python . -r data/*.csv
```

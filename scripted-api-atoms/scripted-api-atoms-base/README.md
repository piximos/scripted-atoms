# Scripted API Atoms Base

Scripted API Atoms Base is the base image for all Scripted API Atoms. It is a simple Python3 runtime with FastAPI and
Uvicorn dependencies pre-installed, along with a couple of other dependencies.

## How to use

In order to create your own Scripted API Atom, add your scripts under the `/scripted-atom` directory with your main app
file under `/scripted-atom/app.py`.

### Example `app.py`

The following example simply returns the json `{"res": "pong"}` for API requests under `/ping` :

```python
from fastapi import FastAPI

atom = FastAPI()


@atom.get("/ping")
def read_root():
    return {"res": "pong"}
```
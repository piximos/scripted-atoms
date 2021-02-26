# Scripted Task Atoms Base

Scripted Task Atoms Base is the base image for all Scripted Task Atoms. It is a simple Python3 runtime with couple
dependencies pre-installed.

## How to use

In order to create your own Scripted Task Atom, add your scripts under the `/scripted-atom` directory with your main app
file under `/scripted-atom/runner.py` that has the following structure :

```python
class Runner:
    def run(self):
        # Your own app logic.....
        pass
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `ST_IS_SLEEPER_SCRIPT`
    * _Required_ : **True**
    * _Type_ : **Boolean**
    * _Default_ : `false`
    * _Description_ : Whether the script executes a single time and exits or executes the script on intervals.
* `ST_SLEEP_DURATION`
    * _Required_ : **False**
    * _Type_ : **Integer**
    * _Description_ : The sleep duration between executions if `ST_IS_SLEEPER_SCRIPT` is set to `true`

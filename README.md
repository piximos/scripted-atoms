# Scripted Atoms

This project intends on creating a set of simple, ready-to-use, cloud-native functions (or as we call them, Scripted
Atoms) ready for use inside your micro-service infrastructure or CI/CD pipelines.

## Why the name "Scripted Atoms"?

The name comes from the fact that the role served by these images is _atomic_ in nature and is too "minute" as to be
considered a micro-service.

## What are Scripted Atoms?

As stated above, scripted atoms serve a particular and singular purpose. They are divided into separate categories :

* __*SAA*__ : Scripted API Atoms
* __*SSA*__ : Scripted Simple Atoms
* __*STA*__ : Scripted Task Atoms

### Scripted API Atoms

Scripted API Atoms are APIs that upon call can serve a number of functions. Such as :

* Generate random numbers;
* Generate reset codes, store them inside a redis database and recover them later on;
* Generate QR codes and store them inside an S3 bucket;
* Generate QR codes and store them directly on the FS;
* ...

### Scripted Task Atoms

Scripted Task Atoms are Simple scripts that execute to serve a particular purpose such as :

* Uptime tracker that *pings* a particular application, if it does not receive a valid response, sends a Slack
  notification alerting of downtime of a particular app.
* Syncs a folder/file to an S3 bucket at given intervals.
* ...
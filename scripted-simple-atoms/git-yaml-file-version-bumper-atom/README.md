# Scripted Simple Atoms : Git YAML File Version Bumper

This image bumps the version value inside a YAML file inside your repo then commits and pushes the updates.

## Image pull

```bash
  docker pull scriptedatom/ssa-git-yaml-file-version-bumper
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `VERSION_FILE`
    * Description : The YAML file that contains the version definition.
    * Required : `true`
* `VERSION_PATH`
    * Description : The version variable path inside the YAML file.
    * Required : `true`
* `REPO_URI`
    * Description : The repo URI.
    * Required : `true`
* `REPO_SCHEMA`
    * Description : The repo URL schema.
    * Required : `true`
    * Acceptable Values : `http` | `https`
* `REPO_BRANCH`
    * Description : The repo branch to do the bump operation inside.
    * Required : `false`
    * Default : `master`
* `REPO_USER`
    * Description : The repo robot user.
    * Required : `true`
* `REPO_TOKEN`
    * Description : The robot user token.
    * Required : `true`
* `VERSION_BUMP_MESSAGE_PREFIX`
    * Description : Message to start the version commit message with.
    * Required : `true`
* `ATOM_ROBOT_USERNAME`
    * Description : The robot username inside git configurations.
    * Required : `true`
* `ATOM_ROBOT_EMAIL`
    * Description : The robot email inside git configurations.
    * Required : `true`
* `VERSION_DELIMITER`
    * Description : Version delimiter between minor and major versions.
    * Required : `true`
    * Acceptable Values : `-` | `_` | `.`
* `BUMP_TYPE`
    * Description : Whether to bump the minor or the major versions.
    * Required : `true`
    * Acceptable Values : `minor` | `major`
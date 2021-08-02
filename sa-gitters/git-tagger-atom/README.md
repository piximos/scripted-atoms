# Scripted Simple Atoms : Git Tagger

This image bumps the tag of your git repository.

## Image pull

```bash
  docker pull scriptedatom/git-tagger
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `REPO_URI`
    * Description : The repo URI.
    * Required : `true`
* `REPO_SCHEMA`
    * Description : The repo URL schema.
    * Required : `true`
    * Acceptable Values : `http` | `https`
* `REPO_USER`
    * Description : The repo robot user.
    * Required : `true`
* `REPO_TOKEN`
    * Description : The robot user token.
    * Required : `true`
* `TAG_BUMP_MESSAGE_PREFIX`
    * Description : Message to start the tag commit message with.
    * Required : `true`
* `ATOM_ROBOT_USERNAME`
    * Description : The robot username inside git configurations.
    * Required : `true`
* `ATOM_ROBOT_EMAIL`
    * Description : The robot email inside git configurations.
    * Required : `true`
* `TAG_DELIMITER`
    * Description : Tag delimiter between minor and major versions.
    * Required : `true`
    * Acceptable Values : `-` | `_` | `.`
* `BUMP_TYPE`
    * Description : Whether to bump the minor or the major versions.
    * Required : `true`
    * Acceptable Values : `minor` | `major`
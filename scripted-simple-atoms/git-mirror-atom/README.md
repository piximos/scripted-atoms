# Scripted Simple Atoms : Git Mirror

This image mirrors a repository to another remote location.

## Image pull

```bash
  docker pull scriptedatom/ssa-git-mirror-atom
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `ORIGIN_REPO_URI`
    * Description : The origin repo URI.
    * Required : `true`
* `ORIGIN_REPO_SCHEMA`
    * Description : The origin repo URL schema.
    * Required : `true`
    * Acceptable Values : `http` | `https`
* `ORIGIN_REPO_USER`
    * Description : The origin repo robot user.
    * Required : `true`
* `ORIGIN_REPO_TOKEN`
    * Description : The origin robot user token.
    * Required : `true`
* `REMOTE_REPO_URI`
    * Description : The remote repo URI.
    * Required : `true`
* `REMOTE_REPO_SCHEMA`
    * Description : The remote repo URL schema.
    * Required : `true`
    * Acceptable Values : `http` | `https`
* `REMOTE_REPO_USER`
    * Description : The remote repo robot user.
    * Required : `true`
* `REMOTE_REPO_TOKEN`
    * Description : The remote robot user token.
    * Required : `true`
* `ATOM_ROBOT_USERNAME`
    * Description : The robot username inside git configurations.
    * Required : `true`
* `ATOM_ROBOT_EMAIL`
    * Description : The robot email inside git configurations.
    * Required : `true`

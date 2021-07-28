# Scripted Simple Atoms : Harbor Image Cleaner

This image launches inside your pipeline to delete obsolete images from your Harbor registry.

## Image pull

```bash
  docker pull scriptedatom/ssa-harbor-image-cleaner:latest
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `SA_HARBOR_URI`
    * Description : The URL for your harbor.
    * Required : `true`
* `SA_HARBOR_SCHEMA`
    * Description : The schema of the Harbor URL.
    * Required : `true`
* `SA_HARBOR_USER`
    * Description : The Harbor user.
    * Required : `true`
* `SA_HARBOR_PASSWORD`
    * Description : The Harbor password.
    * Required : `true`
* `SA_HARBOR_PROJECT`
    * Description : The Harbor project.
    * Required : `true`
* `SA_HARBOR_REPOSITORY`
    * Description : The Harbor repository.
    * Required : `true`
* `SA_TAG_TO_DELETE`
    * Description : The Docker image tag to delete.
    * Required : `true`
* `SA_DELETE_UNTAGGED_ARTIFACTS`
    * Description : Whether or not to delete untagged images.
    * Required : `false`
    * Acceptable Values : `true` | `false`
    * Default : `true`
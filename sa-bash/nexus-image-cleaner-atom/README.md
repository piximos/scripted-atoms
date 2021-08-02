# Scripted Simple Atoms : Nexus Image Cleaner

This image launches inside your pipeline to delete obsolete images from your Nexus registry.

## Image pull

```bash
  docker pull scriptedatom/nexus-image-cleaner:latest
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `SA_NEXUS_URI`
    * Description : The domain name under which your Nexus registry is hosted.
    * Required : `true`
* `SA_NEXUS_SCHEMA`
    * Description : The schema of the nexus URL.
    * Required : `true`
* `SA_NEXUS_USER`
    * Description : The Nexus user.
    * Required : `true`
* `SA_NEXUS_PASSWORD`
    * Description : The nexus password.
    * Required : `true`
* `SA_NEXUS_REPOSITORY`
    * Description : The nexus repository.
    * Required : `true`
* `SA_DOCKER_IMAGE_NAME`
    * Description : The name of the docker image. You can add '*' at the end to indicate that you are looking to delete images by their prefix.
    * Required : `true`
* `SA_DOCKER_IMAGE_TAG`
    * Description : The name of the docker tag image. You can add '*' at the end to indicate that you are looking to delete tags by their prefix.
    * Required : `true`

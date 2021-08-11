# Scripted Simple Atoms : Docker Hub Image Cleaner

This image launches inside your pipeline to delete obsolete images from your Nexus registry.

## Image pull

```bash
  docker pull scriptedatom/docker-hub-image-cleaner:latest
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `DOCKER_USERNAME`
    * Description : Your Docker Hub username.
    * Required : `true`
* `DOCKER_PASSWORD`
    * Description : Your Docker Hub password (not a personal access token!)
    * Required : `true`
* `DOCKER_IMAGE_TAG`
    * Description : The tag to delete (or a prefix of a tag followed by '*')
    * Required : `true`
* `DOCKER_NAMESPACE`
    * Description : The Docker Hub Namespace to delete the image from (defaults to your username)
    * Required : `false`
* `DELETE_ACROSS_ALL_NAMESPACES`
    * Description : Whether to delete the tag from all the namespaces (if DOCKER_NAMESPACE is not specified)
    * Required : `false`
* `DOCKER_IMAGE_NAME`
    * Description : The Docker Image Name.
    * Required : `false`

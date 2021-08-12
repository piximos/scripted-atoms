# Scripted Simple Atoms : Docker Hub Image Describer

This image launches inside your pipeline to update the description of your images inside the Docker Hub registry.

## Image pull

```bash
  docker pull scriptedatom/docker-hub-image-describer:latest
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `DOCKER_USERNAME`
    * Description : Your Docker Hub username.
    * Required : `true`
* `DOCKER_PASSWORD`
    * Description : Your Docker Hub password (not a personal access token!)
    * Required : `true`
* `DOCKER_IMAGE_NAME`
  * Description : The Docker Image Name.
  * Required : `true`
* `README_FILE_PATH`
    * Description : The path for the README file.
    * Required : `true`
* `EXIT_GRACEFULLY`
    * Description : Whether to exit gracefully (exit code 0) if the the README file is not found or to exit with code 1.
    * Required : `false`

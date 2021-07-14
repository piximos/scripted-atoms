# Scripted Simple Atoms Base

This is the base image for ass subsequent Scripted Simple Atoms. It is not meant to be executed, but rather, to be
inherited from by other images. This image is based on an Alpine distro. As extra dependencies, it has `bash` and `jq`
installed.

## Image pull

```bash
  docker pull scriptedatom/ssa-base
```

## Image configurations

Inside the `Dockerfile` of your image, you need to copy two files as follows :

```dockerfile
# Install dependencies
RUN apk update \
 && apk upgrade \
 && apk add <your dependencies here> \
 && rm -rf /var/cache/apk/* # Delete cache to lighten the size of the image

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH
```

* `runner.sh`: The file that contains your main script.
* `env-variables-template.json`: Contains the definition of all your environment variables. The content of this JSON
  file should follow the following structure :
```json5
{
  "variables": [
    {
      "name": "VARIABLE_A", // Specifies the name of the variables.
      "desc": "The description of the variable.", // Specifies the description of the variable.
      "required": true // Specifies if the variable is required or not.
    },
    {
      "name": "VARIABLE_B", // Specifies the name of the variables.
      "desc": "The description of the variable.", // Specifies the description of the variable.
      "required": false // Specifies if the variable is required or not.
    },
    {
      "name": "VARIABLE_C", // Specifies the name of the variables
      "desc": "The description of the variable.", // Specifies the description of the variable
      "required_if": "VARIABLE_B" // Specifies that the variable is only required if another one has been set.
    },
    {
      "name": "VARIABLE_D", // Specifies the name of the variables
      "desc": "The description of the variable.", // Specifies the description of the variable
      "values": [ // Specifies the permitted values of the variable.
        "x",
        "y",
        "z"
      ]
    }
  ]
}
```

### Available environment variables

By default, the following environment variables are available for you inside the image :
* `ENV_TEMPLATE_PATH` :
  - _Description_ : Path for the environment variables JSON template.
  - _Value_ : `/env-variables-template.json`
* `WORKING_DIRECTORY` :
  - _Description_ : The workdir of the image.
  - _Value_ : `/scripted-atom`
* `RUNNER_FILE_PATH` :
  - _Description_ : The path of the main script.
  - _Value_ : `$WORKING_DIRECTORY/runner.sh`
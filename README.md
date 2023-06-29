# SFDC-Production

### Table of Contents <!-- omit in toc -->

- [Validate](#validate)
- [Deploy](#deploy)
- [Quick Deploy](#quick-deploy)
- [Scripts](#scripts)

## Validate

To run validation, update the attribute `deploy_env` in `build/build.properties` file with the desired environment names
Currently, support validating to these envs: dev, qa, staging, prod

For example, if you want to validate to both dev and qa envs, update like this (make sure you add a space):

**In order to run validate to pdx env -  use pdxuata**

```java
validate_envs = dev,qa
```

## Deploy

To run deployment, update the attribute `deploy_env` in `build/build.properties` file with the environment name

## Quick Deploy

To run quick deploy using a build id:
* Update the attribute `deploy_env` in `build/build.properties` file with the environment name
* Update the attribute `build_id` in `build/build.properties` file with the build id

## Scripts

In some cases, if you need to add a script to run before / after your deployment
To do that, put your script in the relevant `beforeBuildScript` or `afterBuildScript` under `scripts/` folder

If you want to change the path to your script file and for example, call an apex class that is about to be deployed
* Update the attribute `scripts_folder` in `build/build.properties` file with the relevant folder (for exmaple `src/classes/`)
* Update the relevant attribute `before_deploy_script_name` or `afterBuildScript` in `build/build.properties` file with the class name
#!/bin/bash

export sf_password=$SF_DEPLOYMENT_PASSWORD
export SF_ENVS="$(grep 'validate_envs = ' build/build.properties | awk '{print $3}')"

if [ -z $SF_ENVS ] ; then
    echo "No validate_envs for commit message: ${SF_ENVS}"
    exit 0
fi

if [[ "$SF_ENVS" != *"$SF_ENV"* ]] ; then
    echo "Environment ${SF_ENV} not specified for validation in ${SF_ENVS}"
    exit 0
fi

if [[ $DRONE_COMMIT_MESSAGE = *"validate "* ]] || [[ $DRONE_COMMIT_MESSAGE = *" validate "* ]]; then #Run on Push with comment triggering the build
    export sf_token=$SF_DEPLOYMENT_TOKEN_PROD
    export sf_username="deployment@twistbioscience.com"

    if [ $SF_ENV != prod ] ; then
        export sf_username="deployment@twistbioscience.com".$SF_ENV

        ##Currntly there are 2 pdx environment starts with the same name.
        # To prevent running validate for both of them once only the pdxuatb was marked to validate
        if [ $SF_ENV == pdxuata ] ; then
          export sf_username="deployment@twistbioscience.com.pdxqa"
        fi

        ##Currntly there are 2 pdx environment starts with the same name.
        # To prevent running validate for both of them once only the pdxuatb was marked to validate
        if [ $SF_ENV == pdxuatb ] ; then
          export sf_username="deployment@twistbioscience.com.pdx"
        fi

        if [ $SF_ENV == qa ] ; then
          export sf_token=$SF_DEPLOYMENT_TOKEN_QA
        else
          if [ $SF_ENV == staging ] ; then
            export sf_token=$SF_DEPLOYMENT_TOKEN_STAGING
          fi
        fi
    fi

    if [ $SF_ENV == prod ] ; then
        ant -buildfile build/build.xml validate-prod
        # add git tag with deploy or validate and the name of env
    else
        ant -buildfile build/build.xml validate-sandbox
    fi
else
    echo "No event caught for commit message: ${DRONE_COMMIT_MESSAGE}"
    exit 0
fi
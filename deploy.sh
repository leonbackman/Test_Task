#!/bin/bash

export sf_password=$SF_DEPLOYMENT_PASSWORD
export SF_ENV="$(grep 'deploy_env = ' build/build.properties | awk '{print $3}')"
export RUN_TESTS="$(grep 'run_tests = ' build/build.properties | awk '{print $3}')"
export RUN_TESTS=${RUN_TESTS:-'true'}
export TASK_ID="$(grep 'build_id = ' build/build.properties | awk '{print $3}')"

if [ -z $SF_ENV ] ; then
    echo "No sf_env for commit message:"
    echo $SF_ENV
    exit 0
fi

if [[ $DRONE_COMMIT_MESSAGE = *"deploy "* ]] || [[ $DRONE_COMMIT_MESSAGE = *" deploy "* ]]; then #Run on Push with comment triggering the build
    export sf_token=$SF_DEPLOYMENT_TOKEN_PROD
    export sf_username="deployment@twistbioscience.com"

    if [ $SF_ENV ] && [ $SF_ENV != prod ] ; then
        export sf_username="deployment@twistbioscience.com".$SF_ENV

        if [ $SF_ENV == qa ] ; then
          export sf_token=$SF_DEPLOYMENT_TOKEN_QA
        else
          if [ $SF_ENV == staging ] ; then
            export sf_token=$SF_DEPLOYMENT_TOKEN_STAGING
          fi
        fi
    fi

    if [ $TASK_ID ] && ([[ $DRONE_COMMIT_MESSAGE = *"quick "* ]] || [[ $DRONE_COMMIT_MESSAGE = *" quick "* ]]) ; then
        if [ $SF_ENV == prod ] ; then
            ant -buildfile build/build.xml quick-deploy-prod
            # add git tag with deploy or validate and the name of env
        else
            ant -buildfile build/build.xml quick-deploy-sandbox
        fi
    else
        if [ $SF_ENV == prod ] ; then
            ant -buildfile build/build.xml deploy-prod
        else
            if [ $RUN_TESTS ] ; then
                ant -buildfile build/build.xml deploy-sandbox-no-tests
            else
                ant -buildfile build/build.xml deploy-sandbox
            fi
        fi
    fi
else
    echo "No event caught for commit message:"
    echo $DRONE_COMMIT_MESSAGE
    exit 0
fi
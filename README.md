# Yarn on Beanstalk

in the year 2022

## Purpose

This is an attempt to make a minimal set of changes to deploy a NextJS application using yarn on AWS's Elastic Beanstalk.

## Changes

1. Use a `Procfile` to define [how the server starts](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-configuration-procfile.html).
2. Specify the Node version in the `package.json` with an `engines` entry.
3. Set the port to 8080 in the `start` script in the `package.json` and run `yarn build` beforehand.
4. Add an `.ebignore` file so that `node_modules` is uploaded and `npm install` is skipped.

## Deploy Steps

### One-Time Setup

Install the AWS EB CLI.

### Each Deploy

Include the `node_modules` in the deployed package in order to [skip the npm install](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-platform-dependencies.html#nodejs-platform-nodemodules).

1. Run `yarn` prior to uploading source so that dependencies are included.

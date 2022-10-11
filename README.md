# Yarn on Beanstalk

in the year 2022

## Purpose

This is an attempt to make a minimal set of changes to deploy a NextJS application using yarn on AWS's Elastic Beanstalk.

## Changes

1. Use a `Procfile` to define [how the server starts](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-configuration-procfile.html).
2. Ensure that `corepack` is enabled and that `yarn` has what it needs inside the container via an EB extension config file. (Maybe unnecessary?)
3. Specify the Node version in the `package.json` with an `engines` entry.
4. Set the port to 5000 in the `start` script in the `package.json`.
5. Create a `/healthcheck` endpoint.

## Deploy Steps

Include the `node_modules` in the deployed package in order to [skip the npm install](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-platform-dependencies.html#nodejs-platform-nodemodules).

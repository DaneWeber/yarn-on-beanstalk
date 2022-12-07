# Yarn on Beanstalk

in the year 2022

## Purpose

This is an attempt to make a minimal set of changes to deploy a NextJS application using yarn on AWS's Elastic Beanstalk.

See the [associated blog post](https://daneweber.wordpress.com/2022/10/15/yarn-app-on-elastic-beanstalk-in-2022/) for further details.

## Changes

1. Create an file in `.ebextensions` that runs `corepack enable` so that `yarn` is available.
2. Use a `Procfile` to define [how the server starts](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-configuration-procfile.html).
3. Set the port to 8080 in the `start` script in the `package.json` and run `yarn build` beforehand.
4. Add an `.ebignore` file so that `node_modules` is uploaded and `npm install` is skipped.

## Deploy Steps

### One-Time Setup

Install the AWS EB CLI.

Initialize and deploy the code.

```
eb init
```

If you get weird errors about lacking permission, consider whether your AWS account requires two-factor authentication, in which case you'll have to deal with `aws sts get-session-token` and setting the session information temporarily.

### Each Deploy

Include the `node_modules` in the deployed package in order to [skip the npm install](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-platform-dependencies.html#nodejs-platform-nodemodules).

1. Run `yarn` prior to uploading source so that dependencies are included.
2. Commit any changes. Note that even with the `.ebignore` file, you need to commit your changes to git before they'll be accepted for the source bundle.
3. `eb deploy`

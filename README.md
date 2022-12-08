# Yarn on Beanstalk

in the year 2022

## Purpose

This is an attempt to make a minimal set of changes to deploy a NextJS application using yarn on AWS's Elastic Beanstalk.

See the [associated blog post](https://daneweber.wordpress.com/2022/10/15/yarn-app-on-elastic-beanstalk-in-2022/) for further details.

Note that `node_modules/.gitignore` is a cleaner way to accomplish what `.ebignore` was doing in the blog post.

## Key Insights

See commit [e097615](https://github.com/DaneWeber/yarn-on-beanstalk/commit/e097615f6e01919f779e034f2b4e6ed1246a1123) for the following set of changes.

### Prevent `npm install` from running

Do this by deploying _a_ `node_modules` directory. Empty is great. The provided `node_modules/.gitignore` will do the trick. [AWS docs ref](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-platform-dependencies.html#nodejs-platform-nodemodules)

### Prevent `npm start` from running

Do this with a `Procfile` that defines how the server starts. [AWS docs ref](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-configuration-procfile.html)

### Enable `yarn` and use it

A `.platform/hooks/predeploy/` script that runs `corepack enable` will ensure that `yarn` is available. This is also a great place to run `yarn install` and `yarn build`.

### Serve on port `8080`

Make sure the way your `Procfile` starts your server specifies port `8080`, usually in the `package.json`.

## Deploy Steps

### One-Time Setup

[Install the AWS EB CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html).

Initialize and deploy the code.

```
eb init
```

If you get weird errors about lacking permission, consider whether your AWS account requires two-factor authentication, in which case you'll have to deal with `aws sts get-session-token` and setting the session information temporarily.

### Each Deploy

Include the `node_modules` folder in the deployed package in order to [skip the npm install](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/nodejs-platform-dependencies.html#nodejs-platform-nodemodules).

1. Commit any changes. Note that you need to commit your changes to git before they'll be accepted for the source bundle.
2. `eb deploy`

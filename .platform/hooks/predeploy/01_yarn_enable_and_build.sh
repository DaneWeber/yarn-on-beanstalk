#!/bin/bash
corepack enable
yarn install --non-interactive --production --frozen-lockfile
yarn build

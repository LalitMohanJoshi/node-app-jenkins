# Jenkins Demo - [ Deployment of Node App]

This repository contain node application deployed through Jenkins in vm instance.
This application is built on typescript , which later converted to node application.

we can attahce Jenkins Config (https://raw.githubusercontent.com/LalitMohanJoshi/node-app-jenkins/master/Jenkinsfile) in pipeline , then it will work.

## Installation

Use the package manager [NPM](https://www.npmjs.com/) to install the Application.

```bash
# typescript command

tsc

# install basic dependencies

npm i --save

# run application through pm2

pm2 start pm2-apps.json

pm2 save

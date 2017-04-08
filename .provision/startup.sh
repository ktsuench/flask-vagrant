#!/usr/bin/env bash

## --- Start MongoDB Community Edition --- ##
sudo service mongod start

## --- Start Flask Application --- ##
sudo supervisorctl start flask_project

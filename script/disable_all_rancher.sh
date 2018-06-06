#!/bin/bash
# disable all rancher container
docker ps | grep rancher | awk '{print $1}' | xargs docker stop

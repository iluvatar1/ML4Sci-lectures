#!/bin/bash

RELEASE_DIR=../release

for myname in .devcontainer .github .gitignore _static Dockerfile README.md requirements.txt _config.yml _toc.yml; do
    rsync -arv $myname $RELEASE_DIR/
done

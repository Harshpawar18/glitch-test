#!/bin/bash

# Exit early on errors
set -eu

# Python buffers stdout. Without this, you won't see what you "print" in the Activity Logs
export PYTHONUNBUFFERED=true

# Ensure the correct Python version is used
PYTHON_VERSION=python3

# Install Python 3 virtual env
VIRTUALENV=.data/venv

if [ ! -d $VIRTUALENV ]; then
  $PYTHON_VERSION -m venv $VIRTUALENV
fi

# Install required packages
$VIRTUALENV/bin/pip install --upgrade pip
$VIRTUALENV/bin/pip install -r requirements.txt

# Run the Flask app with Gunicorn
$VIRTUALENV/bin/gunicorn -b 0.0.0.0:3000 app:app

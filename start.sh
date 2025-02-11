#!/bin/bash

# Exit early on errors
set -eu

# Ensure Python 3 is used
export PYTHONUNBUFFERED=true
PYTHON_VERSION=python3

# Set up virtual environment
VIRTUALENV=.data/venv

if [ ! -d $VIRTUALENV ]; then
  $PYTHON_VERSION -m venv $VIRTUALENV
fi

# Ensure pip is installed
$VIRTUALENV/bin/python -m ensurepip --upgrade

# Upgrade pip
$VIRTUALENV/bin/pip install --upgrade pip

# Install dependencies
$VIRTUALENV/bin/pip install -r requirements.txt

# Start the Flask app with Gunicorn on port 3000
$VIRTUALENV/bin/gunicorn -b 0.0.0.0:3000 app:app

#!/usr/bin/env bash

FILENAME=brewquirements.txt

brew list | tr -s '\t' > $FILENAME

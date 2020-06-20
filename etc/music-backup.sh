#!/bin/bash

#copy all files in Music library to cloud(if it's on the same day it will merge)
ditto ~/Music ~/Library/Mobile\ Documents/com~apple~CloudDocs/Music/$(date +%Y%m%d)/
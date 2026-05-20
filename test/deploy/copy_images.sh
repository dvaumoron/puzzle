#!/usr/bin/env bash

kind load docker-image puzzletest -n puzzlecluster
kind load docker-image puzzlesessionserver -n puzzlecluster
kind load docker-image puzzlerightserver -n puzzlecluster
kind load docker-image puzzlecachedrightserver -n puzzlecluster
kind load docker-image puzzlesettingsserver -n puzzlecluster
kind load docker-image puzzleloginserver -n puzzlecluster
kind load docker-image puzzlesaltserver -n puzzlecluster
kind load docker-image puzzlemarkdownserver -n puzzlecluster
kind load docker-image puzzleprofileserver -n puzzlecluster
kind load docker-image puzzleblogserver -n puzzlecluster
kind load docker-image puzzlewikiserver -n puzzlecluster
kind load docker-image puzzleforumserver -n puzzlecluster
kind load docker-image puzzlepassstrengthserver -n puzzlecluster

#!/bin/bash

file="@$1"
notes="'$2'"

eval "curl http://testflightapp.com/api/builds.json -F file=$file -F api_token='$TESTFLIGHTAPITOKEN' -F team_token='$TESTFLIGHTTEAMTOKEN' -F notes=$notes -F notify=True -F distribution_lists='$TESTFLIGHTDISTRIBUTIONLIST'"
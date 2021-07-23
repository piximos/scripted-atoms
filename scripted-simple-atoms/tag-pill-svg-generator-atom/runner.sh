#!/bin/bash

PILL_TEMPLATE="/home/piximos/piximos/osc/scripted-atoms/version-template.svg"
PILL_OUTPUT="/home/piximos/piximos/osc/scripted-atoms/PILL_OUTPUT.svg"
TAG_PREFIX="sa"
TAG_VALUE="11.3.568"

cat "$PILL_TEMPLATE" |
    sed "s/{{version_prefix}}/${TAG_PREFIX}/g" |
    sed "s/{{version_tag}}/${TAG_VALUE}/g">"${PILL_OUTPUT}"
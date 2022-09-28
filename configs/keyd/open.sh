#!/bin/bash

OPEN=$(kdotool search $1 | head -n 1)
if [[ $OPEN ]]; then
  kdotool windowactivate $OPEN
else
  $1
fi

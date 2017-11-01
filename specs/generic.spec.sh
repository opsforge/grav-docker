#!/bin/bash

echo ""

echo "Running Dockerfile lints..."
echo ""

find -name "Dockerfile" > out.tmp

failed="false"

while read lints; do
  echo ""
  echo ">>> Testing Dockerfile in $lints."

  dockerfile_lint -f $lints #-r ./specs/extended_env.yaml

  if [[ $? -eq 0 ]] ; then
    echo ""
    echo ">>> Test passed for $lints."
  else
    echo ""
    echo ">>> Test FAILED for $lints."
    failed="true"
  fi

done <$(pwd)/out.tmp

if echo "$failed" | grep true &>/dev/null; then
  echo ">>> Some Dockerfile lints failed - address issues in tests."
  exit 1
else
  echo ">>> Dockerfile lints passed - releasing for build."
fi

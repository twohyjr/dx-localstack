#! /bin/bash

zip -r -q ./index.zip index.js

aws \
    --endpoint-url=http://localhost:4566 \
    lambda update-function-code \
    --function-name  helloworld \
    --zip-file fileb://index.zip

rm index.zip
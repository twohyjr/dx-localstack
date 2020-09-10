#! /bin/bash

zip -r -q ./lamda_function.zip index.js

aws \
    --endpoint-url=http://localhost:4566 \
    lambda update-function-code \
    --function-name  test_lambda \
    --zip-file fileb://lamda_function.zip

rm lamda_function.zip
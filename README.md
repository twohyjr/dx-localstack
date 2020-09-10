# Requirements
    `Docker`
    `Terraform v0.12.29`  - I couldn't get v13 to work but if you do, please tell me how.
    `aws-cli`

# The process to get this stuff up and running
1) Get AWS running locally in a docker container on localhost:4566
    - run `docker-compose up`

2) Open new terminal and create the generic dummy lambda called 'helloworld' inside of the aws localstack container.  We deploy a dummy lambda so we can upload our code elsewhere.
    - run `cd terraform`
    - run `terraform init` (I used Terraform v0.12.29)
    - run `terraform apply`
        - enter `yes` to dialog "Do you want to perform these actions?".
    - dummy lambda is created.  

3) Query your local aws for the lambdas.  You should see your new lambda function. 
    - run `aws --endpoint-url=http://localhost:4566 lambda list-functions`
    - You should see a function named "helloworld"

3) Edit the index.js code to be whatever you would like it to be.

4) Send up the new lambda code to the AWS environment
    - run `./deploy_lambda.sh`

5) You can now invoke your new lambda.  This will put the output of the lambda inside of the new output.txt file.
    - run `aws --endpoint-url=http://localhost:4566 lambda invoke --function-name helloworld --log-type Tail ./output.txt`
    - open output.txt and see the output.
    - also the command line that you are running the docker container on should show output from that invocation.
        - Note: line 2 and 4 below.
    ``` 
    1) localstack_main | 2020-09-10T19:15:31:DEBUG:localstack.services.awslambda.lambda_executors: Lambda arn:aws:lambda:us-east-1:000000000000:function:helloworld result / log output:
    2) localstack_main | "This is the output to the file text!"
    3) localstack_main | > START RequestId: 15a0b0de-6e44-10b9-d4c7-9a1627cdaa4c Version: $LATEST
    4) localstack_main | > 2020-09-10T19:15:31.218Z	15a0b0de-6e44-10b9-d4c7-9a1627cdaa4c	Hello, I am logging stuff to cloudwatch!
    5) localstack_main | > END RequestId: 15a0b0de-6e44-10b9-d4c7-9a1627cdaa4c
    6) localstack_main | > REPORT RequestId: 15a0b0de-6e44-10b9-d4c7-9a1627cdaa4c	Init Duration: 1545.49 ms	Duration: 8.37 ms	Billed Duration: 100 ms	Memory Size: 1536 MB	Max Memory Used: 37 MB
    7) localstack_main | 2020-09-10T19:15:31:INFO:botocore.credentials: Found credentials in environment variables.
    ```

# Deploy a Python App with AWS Lambda Layers and S3

This guide explains how to:
- Build and package multiple Lambda layers (e.g., `pymysql`)
- Upload code to AWS S3
- Use AWS CLI commands to manage the Lambda function, including uploading and updating code

### Prerequisites
- AWS CLI installed and configured
- Python 3.10 or later installed
- Access to an AWS S3 bucket for storing Lambda code packages

---

## Step 1: Setting Up Lambda Layers

Lambda layers allow you to package dependencies separately from your main Lambda function code. This helps reduce deployment package size and improve code management.

### 1.1 Create the Base Directory

```bash
mkdir lambda_layers
cd lambda_layers
```

### 1.2 Create and Package `pymysql` Layer

```bash
# Step 1: Set up a directory for pymysql layer
mkdir pymysql_layer
cd pymysql_layer

# Step 2: Set up a virtual environment
python3 -m venv venv
source venv/bin/activate

# Step 3: Install pymysql library
pip install pymysql

# Step 4: Deactivate the virtual environment
deactivate

# Step 5: Prepare the directory structure for Lambda layer packaging
mkdir -p python/lib/python3.10/site-packages
cp -r venv/lib/python3.10/site-packages/* python/lib/python3.10/site-packages/

# Step 6: Clean up virtual environment files and zip the package
rm -rf venv
zip -r pymysql_layer.zip python
mv pymysql_layer.zip ../
cd ..
```

Repeat this process for other dependencies if needed, creating separate folders and packages for each layer.

---

## Step 2: Upload Lambda Layers and Code to S3

### 2.1 Create an S3 Bucket for Lambda Code (Skip if Bucket Exists)

```bash
aws s3 mb s3://your-lambda-bucket-name
```

### 2.2 Upload the `pymysql` Layer to S3

```bash
aws s3 cp pymysql_layer.zip s3://your-lambda-bucket-name/layers/pymysql_layer.zip
```

### 2.3 Package and Upload Your Lambda Function Code

Zip your function code and upload it to S3:

```bash
zip -r lambda_function.zip lambda_function.py
aws s3 cp lambda_function.zip s3://your-lambda-bucket-name/functions/lambda_function.zip
```

---

## Step 3: Create and Configure Lambda Function with Layers

### 3.1 Create the Lambda Layers from S3 Files

```bash
# Create the pymysql layer
aws lambda publish-layer-version \
    --layer-name pymysql-layer \
    --content S3Bucket=your-lambda-bucket-name,S3Key=layers/pymysql_layer.zip \
    --compatible-runtimes python3.10
```

Repeat for other layers as needed, changing the `--layer-name` and S3 `S3Key` values.

### 3.2 Create Lambda Function with the Uploaded Code and Attach Layers

Get the `LayerVersionArn` for each layer created in step 3.1 and add them to the function creation command.

```bash
aws lambda create-function \
    --function-name my-python-function \
    --runtime python3.10 \
    --role arn:aws:iam::your-account-id:role/lambda-execution-role \
    --handler lambda_function.lambda_handler \
    --code S3Bucket=your-lambda-bucket-name,S3Key=functions/lambda_function.zip \
    --layers arn:aws:lambda:region:account-id:layer:pymysql-layer:version
```

---

## Step 4: Update and Manage the Lambda Function with AWS CLI

### 4.1 Update Lambda Code

If you make changes to your Lambda function code, re-upload to S3 and then update the Lambda function:

```bash
# Update code in S3
aws s3 cp lambda_function.zip s3://your-lambda-bucket-name/functions/lambda_function.zip

# Update the Lambda function
aws lambda update-function-code \
    --function-name my-python-function \
    --s3-bucket your-lambda-bucket-name \
    --s3-key functions/lambda_function.zip
```

### 4.2 Invoke the Lambda Function

Test the function by invoking it with a sample payload:

```bash
aws lambda invoke \
    --function-name my-python-function \
    --payload '{"key": "value"}' \
    response.json

cat response.json
```

### 4.3 Update Lambda Configuration (e.g., Memory Size, Timeout)

```bash
aws lambda update-function-configuration \
    --function-name my-python-function \
    --memory-size 256 \
    --timeout 30
```

---

## Step 5: Cleaning Up Resources

To delete the Lambda function and associated layers:

```bash
# Delete Lambda function
aws lambda delete-function --function-name my-python-function

# Delete Lambda layers
aws lambda delete-layer-version --layer-name pymysql-layer --version-number version
```

---

> This completes the setup for deploying a Python app using Lambda layers and S3 for code management. You can use this guide to streamline deployments and manage AWS Lambda functions more effectively.
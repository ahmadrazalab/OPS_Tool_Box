# Connect AWS Lambda to RDS MySQL within a VPC

This guide explains how to set up an AWS Lambda function to connect to a MySQL RDS instance within a Virtual Private Cloud (VPC).

### Prerequisites
- AWS Lambda function with VPC access permissions
- RDS MySQL instance within the same VPC as the Lambda function
- Lambda layer with `pymysql` dependency (refer to the previous guide if needed)
- IAM role for Lambda with required permissions to access RDS

---

## Step 1: Set Up the RDS MySQL Instance

1. **Create a MySQL RDS instance** if not already done.
2. **Configure Security Group**: Attach a security group to your RDS instance that:
   - Allows inbound traffic on the MySQL port (default is 3306) from the Lambda security group.
   - If you’re creating a new security group for RDS, specify inbound rules allowing the Lambda security group.

---

## Step 2: Set Up the Lambda Environment

### 2.1 Configure the Lambda Function’s VPC Settings

1. **Go to the Lambda Console** and open your Lambda function.
2. **Set VPC Settings**:
   - Select the **same VPC** as your RDS instance.
   - Choose **subnets** with network access to the RDS instance (typically private subnets).
   - Choose the **security group** that has outbound access to the RDS instance’s security group.

### 2.2 Configure Lambda Environment Variables

Add the following environment variables to your Lambda function:
- `RDS_HOST`: Endpoint of the RDS instance (e.g., `your-db-instance.xxxxxxxx.region.rds.amazonaws.com`)
- `RDS_PORT`: Port number of the RDS instance (typically `3306`)
- `RDS_USER`: Database username
- `RDS_PASSWORD`: Database password

---

## Step 3: Code to Connect to RDS MySQL from Lambda

Use the following Python code to test the connection and create a new database in RDS. This code should be deployed in your Lambda function.

```python
import pymysql
import os
import datetime

def lambda_handler(event, context):
    # RDS connection parameters
    rds_host = os.environ['RDS_HOST']
    rds_port = int(os.environ['RDS_PORT'])
    rds_user = os.environ['RDS_USER']
    rds_password = os.environ['RDS_PASSWORD']

    # Generate database name
    current_time = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    db_name = f"sample_{current_time}"

    try:
        # Connect to RDS MySQL instance
        db_connection = pymysql.connect(
            host=rds_host,
            user=rds_user,
            password=rds_password,
            port=rds_port
        )

        # Create a cursor
        with db_connection.cursor() as cursor:
            # Create the new database
            cursor.execute(f"CREATE DATABASE {db_name}")
            print(f"Database '{db_name}' created successfully")

        # Commit the transaction
        db_connection.commit()

    except pymysql.MySQLError as e:
        print(f"Error connecting to MySQL Database: {e}")
        return {
            'statusCode': 500,
            'body': f"Database creation failed: {str(e)}"
        }
    
    finally:
        # Ensure the connection is closed
        if 'db_connection' in locals() and db_connection.open:
            db_connection.close()

    return {
        'statusCode': 200,
        'body': f"Database '{db_name}' created successfully"
    }
```

---

## Step 4: Deploy the Lambda Function

### 4.1 Package and Deploy Code

1. Zip the Lambda function code if you are uploading it directly or store it in an S3 bucket.
2. Use AWS CLI or the Lambda console to upload and deploy the code.

### 4.2 Attach the Lambda Layer

Ensure that the Lambda function has access to the `pymysql` library through the layer created in the previous guide.

### 4.3 Test the Lambda Function

Invoke the Lambda function and check the logs to confirm the connection to the RDS instance and successful database creation.

---

## Step 5: Basic AWS CLI Commands for Lambda and RDS

Here are some AWS CLI commands for managing the Lambda function:

### Update Lambda Code

```bash
aws lambda update-function-code \
    --function-name my-python-function \
    --s3-bucket your-lambda-bucket-name \
    --s3-key functions/lambda_function.zip
```

### Invoke Lambda Function

```bash
aws lambda invoke \
    --function-name my-python-function \
    --payload '{"key": "value"}' \
    response.json
```

### Update Lambda VPC Configuration

```bash
aws lambda update-function-configuration \
    --function-name my-python-function \
    --vpc-config SubnetIds=subnet-123abc,subnet-456def,SecurityGroupIds=sg-0123abcd
```

---

> This setup allows your Lambda function to securely connect to the RDS instance within the same VPC. Ensure proper security group configurations to avoid connectivity issues.
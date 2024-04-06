# Task1 

## Scenario:
Deploy a simple web application using AWS CloudFormation or Terraform.
The application should consist of an EC2 instance hosting a static website (html file showing "hello world").

## Requirements:
Define necessary networking components (VPC, Subnets, Security Groups).
Use a configuration management tool like AWS CloudFormation or Terraform.
Ensure proper tagging and IAM roles for security.


## Deliverables:


### Share the code repository with your infrastructure code.

code is under:  [terraform/webserver](../terraform/webserver/) 

### Provide instructions for deploying and tearing down the infrastructure.

Step-by-step instructions to install and configure the project.

1. Clone the repository: `[repository https://github.com/orenevan/]`
2. You can modify variables under    [terraform/webserver](../terraform/webserver/terraform.tfvars) 
2. Navigate to the project directory: `cd `
3. For deploying the web server perform the following:  
   ------------------------------------------------------
    1. cd ``terraform/web_server`` directory
    2. terraform init 
    3. terraform plan               `checking out that plan looks ok`
    4. terraform apply  
    5. terraform destroy            `for tearing down` 
        
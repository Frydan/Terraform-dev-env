# Project Terraform Dev Env

Requirements:
 - Terraform (0.15 or newer)
 - AWS Account (Free Tier)

<br />
<br />
To deploy this AWS pipeline follow the steps listed below:
<br />
<br />

**0. Prerequisites**

Make sure Your installed Terraform version is **0.15 or newer**:
>$ terraform -v

Make sure You are logged in to AWS and if not use this command to do so:
>$ aws credentials

<br />
<br />

**1. Clone this repository**
>$ git clone https://github.com/Frydan/Terraform-dev-env.git

<br />
<br />

**2. Setup Your AWS Git credentials**

On AWS web console go to: <br />
IAM > Users > {your_username} > Security credentials > Http Git credentials for AWS CodeCommit > Generate <br /> <br />
And copy Your AWS Git credentials

<br />
<br />

**3. Generate key pair for web server EC2 instances**

On AWS web console go to: <br />
EC2 > Key pairs > Create key pair <br /> <br />
Setup name, extension, create it and download

<br />
<br />

**4. Setup Terraform variables**

In main directory **variables.tf** set these default variables: <br />
**region** = Your AWS region e.g. **eu-central-1** <br />
**key_webservers** = Name of the keypair generated for web server instances <br />
**shared_credentials_file** = Place where Your AWS credentials are stored e.g. **/home/myuser/.aws/credentials** <br />

<br />
<br />

**5. Run Terraform**
>$ terraform init

>$ terraform plan

Check if everything seems good

>$ terraform apply

<br />
<br />

**6. Check if everything is working**

After couple minutes go to displayed Elastic Load Balancer's DNS. <br />
When refreshing site displayed instance-id should circle around all of created web server instances

<br />
<br />

**7. Clone, add Appspec.yml, Modify and Commit code to CodeCommit repository**
In diffrent directory: <br />
>$ git clone {link_to_your_AWS_CodeCommit_repo} <br />
>$ git checkout -b master <br />
>$ subl index.html <br />
Copy Appspec.yml file from this repository <br /> 
>$ git add . <br />
>$ git commit -m "Commit message" <br />
>$ git push origin master <br />

Now while pushing new code to CodeCommit repository with Your AWS Git credentials created pipeline should update existing EC2 web server instances with new index.html file from repository

<br />
<br />

## Note

This project was a learning experience for me while learning about Terraform and AWS cloud services. <br />
It may not work perfectly yet but i will continue to develop it further as I learn more and more. <br />
Some of the things I want to add now are: third (build) stage of pipeline with Jenkins, switch from CodeCommit to GitHub for source stage, Auto Scaling Groups depending on load for web server instances, networking ( things like VPCs, subnets, NACLs etc. ) and others.


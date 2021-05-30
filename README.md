# Project Terraform Dev Env

This project was (and still is) created to automate creation of CI/CD pipeline using Terraform and AWS cloud services.
The main focus was automating deployment of new web application versions so You can focus on coding while everything server-side like load balancing, auto scaling depending on server load or deploying new versions is taken care of automatically.

<br />

**Requirements:**
 - Terraform (0.15 or newer)
 - AWS Account (Free Tier)

<br />
<br />

## To deploy this AWS pipeline follow the steps listed below:

<br />
<br />

### **0. Prerequisites**

Make sure Your installed Terraform version is **0.15 or newer**:
>$ terraform -v

Make sure You are logged in to AWS and if not use this command to do so:
>$ aws credentials

<br />
<br />

### **1. Clone this repository**
>$ git clone https://github.com/Frydan/Terraform-dev-env.git

<br />
<br />

### **2. Setup Your AWS Git credentials**

On AWS web console go to: <br />
IAM > Users > {your_username} > Security credentials > Http Git credentials for AWS CodeCommit > Generate <br /> <br />
And copy Your AWS Git credentials

<br />
<br />

### **3. Generate key pair for web server EC2 instances**

On AWS web console go to: <br />
EC2 > Key pairs > Create key pair <br /> <br />
Setup name, extension, create it and download

<br />
<br />

### **4. Manually create s3 bucket for tfstate file**

On AWS web console go to: <br />
S3 > Create Bucket<br /> <br />
Set the name, enable versioning and encryption with SSE-S3
Now change the **bucket** and **region** variables inside **state.tf** file so that the info matches with the bucket You created.

<br />
<br />

### **5. Setup Terraform variables**

In main directory **variables.tf** set these default variables: <br />
**region** = Your AWS region e.g. **eu-central-1** <br />
**key_webservers** = Name of the keypair generated for web server instances <br />
**shared_credentials_file** = Place where Your AWS credentials are stored e.g. **/home/myuser/.aws/credentials** <br />
These 3 are the most important ones, You can also modify a lot more variables I've put here. <br />
All of them are described <br />

<br />
<br />

### **6. Run Terraform**
>$ terraform init

>$ terraform plan

Check if everything seems good

>$ terraform apply

<br />
<br />

### **7. Check if everything is working**

After couple minutes go to displayed Elastic Load Balancer's DNS. <br />
When refreshing site displayed instance-id should circle around all of created web server instances

<br />
<br />

### **8. Clone, add Appspec.yml, Modify and Commit code to CodeCommit repository**
In diffrent directory: <br />
>$ git clone {link_to_your_AWS_CodeCommit_repo}


>$ git checkout -b master

Copy **appspec.yml** file and also **deploy_scripts** directory from this repository <br />
All website files should be stored in new **/html** directory <br />

>$ subl ./html/index.html


>$ echo "\<h1>New site\</h1>" > ./html/second.html


Your repository contents should something look like this: <br />
![image](https://user-images.githubusercontent.com/74418919/119979085-bf587600-bfba-11eb-8433-28950d65fd60.png)

>$ git add .


>$ git commit -m "Commit message"


>$ git push origin master

Now while pushing new code to CodeCommit repository with Your AWS Git credentials created pipeline should update existing EC2 web server instances with new files from **html** directory. <br />
Also for testing purposes I've added responding EC2 instance's ID so You could check which instance is responding / whether Elastic Load Balancer is working. <br />
Update takes about 2 minutes per instance to display new content after push command so be patient :) <br /> 
<br />
<br />

## Note

This project was a learning experience for me while learning about Terraform and AWS cloud services. <br />
It may not work perfectly yet but i will continue to develop it further as I learn more and more. <br />
Some of the things I want to add now are: third (build) stage of pipeline with Jenkins and switch from CodeCommit to GitHub for source stage


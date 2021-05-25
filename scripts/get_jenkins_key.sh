#!/bin/bash
chmod 400 $1
ssh -i $1 ec2-user@$2 "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
#!/bin/bash

# Author : Vinayak Pawar

echo "What would you like to upload?"

read -p "1) Staging-Build 2) Production-Build"$'\n' choice

if [[ $choice -eq 1 ]];then
    read -p "Are you sure to proceed with Staging Build (y/n)?"$'\n' c
elif [[ $choice -eq 2 ]];then
    read -p "Are you sure to proceed with Production Build (y/n)?"$'\n' c
fi
# read -p "Are you sure to proceed with $choice (y/n)?"$'\n' c

if [ "$c" == "y" ]; then
    case $choice in  
    1) cd staging-build &&
        echo -e "Uploading Staging Build \n" && aws s3 cp . s3://test-stag-bfk --recursive --profile bfk-script &&
        echo "Updating the server" && aws cloudfront create-invalidation --distribution-id E38UIKRMLO50NG --paths "/*" --profile bfk-script &&
        echo "Staging-Build is updated";;
    2) cd production-build &&
        echo -e "Uploading Production Build \n" && aws s3 cp . s3://test-prod-bfk --recursive --profile bfk-script &&
        echo "Updating the server" && aws cloudfront create-invalidation --distribution-id E357NZNIK90R5X --paths "/*" --profile bfk-script &&
        echo "Production-build is updated";;
    *) echo -e "Please select Valid choice";; 
    esac
fi

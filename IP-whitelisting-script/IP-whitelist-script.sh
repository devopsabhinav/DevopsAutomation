#!/bin/bash

if jq --version; then
  echo "Dependencies are Installed and Ready to Go!"
else 
  echo "Please Install the jq package and try again (Dependencies failed)"
  exit 1;
fi
echo "Available AWS profiles:"
aws configure list-profiles | nl

read -p "Enter the number of the AWS profile: " PROFILE_NUMBER
profile=$(aws configure list-profiles | sed -n "${PROFILE_NUMBER}p")

echo "Available security groups in $profile profile:"
SG_JSON=$(aws ec2 describe-security-groups --profile $profile --query "SecurityGroups[*].{ID:GroupId,Name:GroupName}")
SG_LIST=$(echo $SG_JSON | jq -r '.[] | "\(.ID) - \(.Name)"')
echo "$SG_LIST" | nl

read -p "Enter the number of the security group: " SG_NUMBER
SECURITY_GROUP_ID=$(echo $SG_JSON | jq -r --argjson n "$((SG_NUMBER-1))" '.[$n].ID')

read -p "Enter port number: " PORT

read -p "1)AutoDetect IP 2) Enter IP manually"$'\n' choice

if [[ $choice -eq 1 ]];then
    IP_ADDRESS=$(curl -s https://api.ipify.org)
    read -p "confirm your IP $IP_ADDRESS (y/n)?"$'\n' c
    if [[ "$c" != "y" ]]; then
        echo "Whitelisting cancelled"
        exit 1
    fi
elif [[ $choice -eq 2 ]];then
    read -p "Enter IP address manually: " IP_ADDRESS
fi

read -p "Are you sure you want to whitelist IP address $IP_ADDRESS in security group $SECURITY_GROUP_ID? (y/n) " CONFIRMATION

if [[ "$CONFIRMATION" != "y" ]]; then
  echo "Whitelisting cancelled"
  exit 1
fi

if echo $(aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" --protocol tcp --port "$PORT" --cidr "$IP_ADDRESS"/32 --profile "$profile"); then
  echo "Whitelisting is Successful with $PROTOCOL port $PORT from $IP_ADDRESS in security group $SG_ID"
else
  echo "Whitelisting Failed!!!"
fi
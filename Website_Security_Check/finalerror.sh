#!/bin/bash

read -p "Enter the URL to Scan: " url

read -p "Are you sure to proceed with $url (y/n)? " response

if [ "$response" == 'y' ]; then 
    while IFS= read -r path
    do
        status_code=$(curl -s -o /dev/null -w "%{http_code}" "https://$url$path")
        echo "Path: $path, Status Code: $status_code"
    done < url.txt
fi

echo "Performing port scanning for $url..."
nmap_output=$(nmap -p 1-36000 "$url")

# Print the Nmap scan results
echo "Nmap scan results for $url:"
echo "$nmap_output"
echo

echo "Performing OWASP ZAP security scan for $url..."
# zap_output=$(zap-cli --zap-path /opt/homebrew/bin/zap-cli --cmd active-scan -r "$url")
zap-cli --zap-path /Applications/OWASP\ ZAP.app/Contents/Java/zap.sh quick-scan --self-contained --spider --start-options "-config api.disablekey=true" -f json > report.json "https://$url"
# Print the OWASP ZAP scan results
# echo "OWASP ZAP scan results for $url:"
# echo "$zap_output"
echo "Report Generated in Report.json file"


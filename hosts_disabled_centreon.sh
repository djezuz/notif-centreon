#!/bin/sh

####################################
# Export mail des hosts en disbled #
#       dans Centreon/Nagios       #
#        27/09/2011 - Jerome       #
####################################

sendto=myemail@mydomain.fr
query=$(mysql centreon2_db --exec="SELECT host_name , host_address , host_alias , host_comment  FROM host WHERE host_activate = '0';" -H)

sleep 10 && (
echo "From: centreon@mydomain.fr"
echo "To: $sendto"
echo "MIME-Version: 1.0"
echo "Content-Type: multipart/alternative; " 
echo ' boundary="PAA08673.1018277622/myserver.mydomain.fr"' 
echo "Subject: Nagios - Host Desactive" 
echo "" 
echo "This is a MIME-encapsulated message" 
echo "" 
echo "--PAA08673.1018277622/myserver.mydomain.fr" 
echo "Content-Type: text/html" 
echo "" 
echo "<html> 
<head>
<title>Host Desactive Centreon</title>
</head>
<body>
$query
</body>
</html>"
echo "--PAA08673.1018277622/myserver.mydomain.fr"
) | sendmail.postfix -t

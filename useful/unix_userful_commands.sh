#############################################################
# Get the latency of requests inside an EC2 instance on AWS.#
#############################################################

for X in 'seq 60'; do curl -Ik -w "HTTPCode=%{http_code} TotalTime=%{time_total}\n" http://google.com -so /dev/null; done


#############################################################
# Create a socket TCP or UDP server to debug protocol       #
#############################################################


#############################################################
# List all images from a docker registry repository
#############################################################

curl -k https://<docker_URL>/v2/_catalog?n=1000


#############################################################
# Listen all trafic on port 9999
#############################################################

lsof -i TCP:9999

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


### NetCat Commands

#############################################################
# Send a package to specific server
#############################################################

echo "foobar:12345" | nc -w 1 -u -4 localhost 1234

#############################################################
# Create a server (TCP/UDP) on specific port
#############################################################

nc -ulv 1234

#############################################################
# Cleanup DNS cache on MacOS
#############################################################
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder


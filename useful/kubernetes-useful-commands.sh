
#############################################################
# Get the composer-auth secrets of the namespace tekton-builds from a kubernetes cluster
#############################################################
k get secrets composer-auth -n tekton-builds -o jsonpath='{.data}' | jq .COMPOSER_AUTH | base64 -D

#############################################################
# Port forward to argocd server
#############################################################
kubectl port-forward svc/argocd-server 8080:80 -n argocd 


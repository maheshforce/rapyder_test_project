kubectl create namespace ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx

kubectl apply -f ./app/helm/ingress/ingress.yml

helm install app ./app/helm/nginx-sample/ -f ./app/helm/nginx-values.yaml

kubectl apply -f ./app/helm/ingress/ingress.yml 

aws eks update-kubeconfig --region us-east-1 --name test-eks

kubectl -n kube-system get configmap aws-auth -o yaml > auth1.yml
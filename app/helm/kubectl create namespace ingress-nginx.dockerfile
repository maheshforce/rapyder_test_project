kubectl create namespace ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx

  helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.nodeSelector.role=system
  
kubectl apply -f ./app/helm/ingress/ingress.yml

helm install app ./app/helm/nginx-sample/ -f ./app/helm/nginx-values.yaml

kubectl apply -f ./app/helm/ingress/ingress.yml 

aws eks update-kubeconfig --region us-east-1 --name test-eks

kubectl -n kube-system get configmap aws-auth -o yaml > auth1.yml



helm upgrade --install karpenter-crd oci://public.ecr.aws/karpenter/karpenter-crd \
  --version "${KARPENTER_VERSION}" \
  --namespace "${KARPENTER_NAMESPACE}" \
  --create-namespace





  helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version "1.8.3" \
  --namespace "kube-system" \
  -f ./app/helm/karpenter/values.yaml

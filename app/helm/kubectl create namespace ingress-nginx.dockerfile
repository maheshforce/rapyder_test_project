kubectl create namespace ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx

kubectl get po -n ingress-nginx

  helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.nodeSelector.role=system
  
kubectl apply -f ./app/helm/ingress/ingress.yml

helm install app ./app/helm/nginx-sample/ -f ./app/helm/nginx-sample/values.yaml

kubectl apply -f ./app/helm/ingress/ingress.yml 

aws eks update-kubeconfig --region us-east-1 --name test-eks

kubectl -n kube-system get configmap aws-auth -o yaml > auth1.yml

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

helm repo add karpenter https://charts.karpenter.sh
helm repo update

helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version "1.8.3" \
  --namespace "kube-system" \
  -f ./app/helm/karpenter/values.yaml



kubectl apply -f ./app/helm/karpenter/nodeclass.yaml
kubectl get EC2NodeClass

kubectl apply -f ./app/helm/karpenter/appnodepool.yaml
kubectl get Nodepool


helm repo add kedacore https://kedacore.github.io/charts
helm repo update

kubectl create namespace keda


helm install keda kedacore/keda \
  --namespace keda \
  --version 2.14.2 \
  -f ./app/helm/KEDA/values.yaml


kubetl create namespace monitoring

  helm install monitoring prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f ./app/helm/monitoring/monitoring-values.yaml
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack -n monitoring -f ./app/helm/monitoring/values.yaml

kubectl apply -f ./app/helm/monitoring/ingress.yaml

kubectl rollout restart deployment -n monitoring

kubectl logs ingress-nginx-controller-5bfcb7d69d-752bn -n ingress-nginx







  helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version "1.8.3" \
  --namespace "kube-system" \
  -f ./app/helm/karpenter/values.yaml

  kubectl apply -f ./app/helm/karpenter/appnodepool.yaml
  kubectl apply -f ./app/helm/karpenter/nodeclass.yaml

kubectl apply -f ./app/helm/KEDA/cpu-scaledobject.yaml


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack \
  -n monitoring \
  --version 56.6.2 \
  -f ./app/helm/monitoring/monitoring-values.yaml

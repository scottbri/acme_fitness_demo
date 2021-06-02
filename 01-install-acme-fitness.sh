NAMESPACE=acme-fitness
APPNAME=${NAMESPACE}

REDIS_PASS="superSecretPassword!"
MONGO_PASS="superSecretPassword!"
POSTGRESS_PASS="superSecretPassword!"


kubectl create ns ${NAMESPACE}

mkdir secrets

kubectl create secret generic cart-redis-pass --from-literal=password=${REDIS_PASS} --dry-run -oyaml > secrets/redis-pass.yaml
kubectl create secret generic catalog-mongo-pass --from-literal=password=${MONGO_PASS} --dry-run -oyaml > secrets/mongo-pass.yaml
kubectl create secret generic order-postgres-pass --from-literal=password=${POSTGRESS_PASS} --dry-run -oyaml > secrets/postgress-pass.yaml

kapp deploy -a ${APPNAME} -n ${NAMESPACE} -f ./secrets/ -f ./kubernetes-manifests/ 

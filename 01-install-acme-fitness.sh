NAMESPACE=acme-fitness
APPNAME=${NAMESPACE}

CART_PASS="superSecretPassword!"
CATALOG_PASS="superSecretPassword!"
ORDER_PASS="superSecretPassword!"
USERS_PASS="superSecretPassword!"


kubectl create ns ${NAMESPACE}

mkdir secrets

kubectl create secret generic cart-redis-pass --from-literal=password=${CART_PASS} --dry-run -oyaml > secrets/cart-redis-pass.yaml
kubectl create secret generic catalog-mongo-pass --from-literal=password=${CATALOG_PASS} --dry-run -oyaml > secrets/catalog-mongo-pass.yaml
kubectl create secret generic order-postgres-pass --from-literal=password=${ORDER_PASS} --dry-run -oyaml > secrets/-order-postgress-pass.yaml
kubectl create secret generic users-mongo-pass --from-literal=password=${USERS_PASS} --dry-run -oyaml > secrets/users-mongo-pass.yaml
kubectl create secret generic users-redis-pass --from-literal=password=${USERS_PASS} --dry-run -oyaml > secrets/users-redis-pass.yaml

kapp deploy -y -a ${APPNAME} -n ${NAMESPACE} -f ./secrets/ -f ./kubernetes-manifests/ 

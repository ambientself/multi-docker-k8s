docker build -t ambientself/multi-client:latest -t ambientself/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ambientself/multi-server:latest -t ambientself/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ambientself/multi-worker:latest -t ambientself/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ambientself/multi-client:latest
docker push ambientself/multi-server:latest
docker push ambientself/multi-worker:latest

docker push ambientself/multi-client:$SHA
docker push ambientself/multi-server:$SHA
docker push ambientself/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ambientself/multi-client:$SHA
kubectl set image deployments/server-deployment server=ambientself/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ambientself/multi-worker:$SHA
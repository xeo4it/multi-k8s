docker build -t dongimmi/multi-client:latest -t dongimmi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dongimmi/multi-server:latest -t dongimmi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dongimmi/multi-worker:latest -t dongimmi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dongimmi/multi-client:latest
docker push dongimmi/multi-server:latest
docker push dongimmi/multi-worker:latest

docker push dongimmi/multi-client:$SHA
docker push dongimmi/multi-server:$SHA
docker push dongimmi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dongimmi/multi-server:$SHA
kubectl set image deployments/client-deployment client=dongimmi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dongimmi/multi-worker:$SHA

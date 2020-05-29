docker build -t jcesarpabreu/multi-client:latest -t jcesarpabreu/multi-client:$SHA ./client/Dockerfile ./client
docker build -t jcesarpabreu/multi-worker:latest -t jcesarpabreu/multi-worker:$SHA ./worker/Dockerfile ./worker
docker build -t jcesarpabreu/multi-server:latest -t jcesarpabreu/multi-server:$SHA ./server/Dockerfile ./server

docker push jcesarpabreu/multi-client:latest
docker push jcesarpabreu/multi-worker:latest
docker push jcesarpabreu/multi-server:latest

docker push jcesarpabreu/multi-client:$SHA
docker push jcesarpabreu/multi-worker:$SHA
docker push jcesarpabreu/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jcesarpabreu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jcesarpabreu/multi-worker:$SHA
kubectl set image deployments/server-deployment server=jcesarpabreu/multi-server:$SHA

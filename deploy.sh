
docker build -t mightycontainer002/multi-client:latest -t mightycontainer002/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mightycontainer002/multi-server:latest -t mightycontainer002/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mightycontainer002/multi-worker:latest -t mightycontainer002/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mightycontainer002/multi-client:latest
docker push mightycontainer002/multi-client:$SHA
docker push mightycontainer002/multi-server:latest
docker push mightycontainer002/multi-server:$SHA
docker push mightycontainer002/multi-worker:latest
docker push mightycontainer002/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mightycontainer002/multi-server:$SHA
kubectl set image deployments/client-deployment client=mightycontainer002/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mightycontainer002/multi-worker:$SHA
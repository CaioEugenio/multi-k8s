docker build -t eugeniocaio10/multi-client:latest -t eugeniocaio10/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eugeniocaio10/multi-server:latest -t eugeniocaio10/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eugeniocaio10/multi-worker:latest -t eugeniocaio10/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eugeniocaio10/multi-client:latest
docker push eugeniocaio10/multi-server:latest
docker push eugeniocaio10/multi-worker:latest

docker push eugeniocaio10/multi-client:$SHA
docker push eugeniocaio10/multi-server:$SHA
docker push eugeniocaio10/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eugeniocaio10/multi-server:$SHA
kubectl set image deployments/client-deployment client=eugeniocaio10/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eugeniocaio10/multi-worker:$SHA
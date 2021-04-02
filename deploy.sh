docker build -t craigdurant2001/multi-client:latest -t craigdurant2001/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t craigdurant2001/multi-server:latest -t craigdurant2001/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t craigdurant2001/multi-worker:latest -t craigdurant2001/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push craigdurant2001/multi-client:latest
docker push craigdurant2001/multi-server:latest
docker push craigdurant2001/multi-worker:latest

docker push craigdurant2001/multi-client:$SHA
docker push craigdurant2001/multi-server:$SHA
docker push craigdurant2001/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=craigdurant2001/multi-server:$SHA
kubectl set image deployments/client-deployment client=craigdurant2001/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=craigdurant2001/multi-worker:$SHA

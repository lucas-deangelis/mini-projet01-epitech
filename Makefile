KEY_FILE:=gotham-254312-cd30ddd476eb.json
PROJECT_ID:=gotham-254312
K8s_CLUSTER:=standard-cluster-1
ZONE:=europe-west1-b

IMAGE_VERSION=latest

gauth:
	@gcloud auth activate-service-account --key-file ${KEY_FILE}

gconfig:
	@gcloud config set project $(PROJECT_ID)
	@gcloud container clusters \
		get-credentials $(K8s_CLUSTER) \
		--zone $(ZONE) \
		--project $(PROJECT_ID)
	@gcloud auth configure-docker

run:
	@docker run -p 4000:4000 gcr.io/$(PROJECT_ID)/backend:$(IMAGE_VERSION)
	@docker run -p 8080:8080 gcr.io/$(PROJECT_ID)/frontend:$(IMAGE_VERSION)

push:
	@docker push gcr.io/$(PROJECT_ID)/frontend:$(IMAGE_VERSION)
	@docker push gcr.io/$(PROJECT_ID)/backend:$(IMAGE_VERSION)
	@docker push gcr.io/$(PROJECT_ID)/db:$(IMAGE_VERSION)

deploy: gconfig
	@kubectl apply -f k8s.yaml
# https://github.com/kubernetes/kubernetes/issues/27081#issuecomment-238078103
	@kubectl patch deployment backend -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
	@kubectl patch deployment frontend -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
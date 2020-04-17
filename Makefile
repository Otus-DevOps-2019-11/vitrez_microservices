# adding variables or rules from external file
include ./docker/.env

# define of variable USERNAME if it was not previously defined from file; otherwise, this definition is ignored.
USERNAME ?= vitrez

# declaration abstract target
.PHONY : all

$(info Build reddit app and infra docker images and push it to Dockerhub. Login before push.)

# default goal
all: build push


# abstract target 'build' dependent on other abstract goals
.PHONY : build ui comment post prometheus blackbox alertmanager grafana

build: ui comment post prometheus blackbox alertmanager grafana
	@echo "Building reddit app and infra docker images finished."

ui:
	cd src/ui && docker build -t ${USERNAME}/ui .

comment:
	cd src/comment && docker build -t ${USERNAME}/comment .

post:
	cd src/post-py && docker build -t ${USERNAME}/post .

prometheus:
	cd monitoring/prometheus && docker build -t ${USERNAME}/prometheus .

blackbox:
	cd monitoring/blackbox_exporter && docker build -t ${USERNAME}/blackbox_exporter .

alertmanager:
	cd monitoring/alertmanager && docker build -t ${USERNAME}/alertmanager .

grafana:
	cd monitoring/grafana && docker build -t ${USERNAME}/grafana .


# abstract target 'push' dependent on other abstract goals
.PHONY : push ui-push comment-push post-push prometheus-push blackbox-push alertmanager-push grafana-push

push: ui-push comment-push post-push prometheus-push blackbox-push alertmanager-push grafana-push
	@echo "Pushing docker images to Dockerhub finished."

ui-push:
	docker push ${USERNAME}/ui:latest

comment-push:
	docker push ${USERNAME}/comment:latest

post-push:
	docker push ${USERNAME}/post:latest

prometheus-push:
	docker push ${USERNAME}/ui:latest

blackbox-push:
	docker push ${USERNAME}/blackbox_exporter:latest

alertmanager-push:
        docker push ${USERNAME}/alertmanager:latest

grafana-push:
        docker push ${USERNAME}/grafana:latest

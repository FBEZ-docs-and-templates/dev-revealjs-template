IMAGE_NAME ?= python-dev
CONTAINER_NAME ?= python-dev
VERSION ?= latest

.PHONY: build shell run stop rm dev-run compile-theme

build: Dockerfile
	docker build -t $(IMAGE_NAME):$(VERSION) -f Dockerfile .

dev-run: 
	docker run -it --rm -p 8000:8000 -v $$PWD/src/index.html:/reveal.js/index.html -v $$PWD/src/media:/reveal.js/media -v $$PWD/src/custom.css:/reveal.js/css/theme/custom.css -v $$PWD/src/menu:/reveal.js/plugin/menu nbrown/revealjs

run:
	docker run --rm --name $(CONTAINER_NAME) $(IMAGE_NAME):$(VERSION)

shell:
	docker run --rm --name $(CONTAINER_NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(IMAGE_NAME):$(VERSION) /bin/bash

stop:
	docker stop $(CONTAINER_NAME)

rm:
	docker rm $(CONTAINER_NAME)
	
compile-theme: 
	rm -f src/custom.css>/dev/null 
	touch src/custom.css
	docker run -it --rm -v $$PWD/src/custom.css:/reveal.js/css/themes/custom.css -v $$PWD/src/custom.scss:/reveal.js/css/themes/source/custom.scss nbrown/revealjs grunt css-themes

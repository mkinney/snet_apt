.DEFAULT_GOAL := build

version=0.4.0

.PHONY: build

build: FORCE
	docker build -t mkinney:snet_apt --build-arg version=$(version) .
	docker cp $(shell docker create mkinney:snet_apt):/root/snet_$(version)-1_amd64.deb .

clean:
	docker rmi mkinney:snet_apt || true
	docker system prune
	@rm *.deb 2> /dev/null || true

FORCE: ;

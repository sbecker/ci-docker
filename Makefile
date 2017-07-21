clean:
	rm -rf build/

build: build/linux_amd64/ci-docker build/docker-image

build/linux_amd64/ci-docker:
	GOOS=linux \
	GOARCH=amd64 \
	CGO_ENABLED=0 \
	go build \
	-ldflags '-w -s' -a -installsuffix cgo \
	-o build/linux_amd64/ci-docker

build/docker-image: build
	docker build . -t sbecker/ci-docker
	touch build/docker-image

docker-run: build/docker-image
	docker run -d -it \
	-p 8080:8080 \
	--name ci-docker \
	sbecker/ci-docker \
	./ci-docker

docker-stop:
	docker kill ci-docker && \
	docker rm ci-docker
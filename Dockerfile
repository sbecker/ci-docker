FROM alpine:3.5
ADD build/linux_amd64/ci-docker /bin/
ENTRYPOINT /bin/ci-docker
EXPOSE 8080
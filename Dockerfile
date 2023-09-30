FROM ubuntu:latest
LABEL authors="sosa"

ENTRYPOINT ["top", "-b"]
FROM ubuntu:latest
# COPY . /app
RUN apt-get update && apt-get install zip make curl -y
RUN curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | bash
WORKDIR /app
CMD ["pack"]
ENTRYPOINT [ "make" ]

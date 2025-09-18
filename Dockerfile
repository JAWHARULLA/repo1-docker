FROM alpine:3.18
WORKDIR /opt/app
COPY . /opt/app
CMD ["sh", "-c", "if [ -f repo2/hello.txt ]; then cat repo2/hello.txt; else echo No_hello_file_found; fi"]

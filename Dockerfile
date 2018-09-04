FROM alpine:3.5
RUN apk add --no-cache curl bash
RUN curl -sfLS https://import.pw > /usr/bin/import && chmod +x /usr/bin/import
WORKDIR /public
COPY . .
RUN sh /usr/bin/import ./test.sh
RUN bash /usr/bin/import ./test.sh
RUN echo "All tests passed!" > index.txt

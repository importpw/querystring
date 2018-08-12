FROM alpine:3.5
RUN apk add --no-cache curl bash
WORKDIR /public
COPY . .
RUN sh --help 2>&1 | head -n1 && sh ./test.sh
RUN bash --version && bash ./test.sh
RUN echo "All tests passed!" > index.txt

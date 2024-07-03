# Build image
FROM golang:1.22.5-alpine3.19 as builder

WORKDIR /app

COPY . .

RUN apk add \
    --no-cache \
    --allow-untrusted \
    --repository https://dl-cdn.alpinelinux.org/alpine/v3.19/main \
    --update git

RUN go mod download

EXPOSE 8089

CMD [ "go", "run", "main.go" ]
# syntax=docker/dockerfile:1.4
FROM golang:1.18-alpine AS builder

WORKDIR /code

ENV CGO_ENABLED 0
ENV GOPATH /go
ENV GOCACHE /go-build

COPY go.mod go.sum ./
RUN target=/go/pkg/mod/cache go mod download

COPY . .

RUN target=/go/pkg/mod/cache target=/go-build go build -o bin/backend main.go

CMD ["/code/bin/backend"]

FROM builder AS dev-envs

RUN apt-get update && apt-get install git && apt-get install curl

RUN addgroup -S docker && adduser -S --shell /bin/bash --ingroup docker vscode


# install Docker tools (cli, buildx, compose)
COPY --from=gloursdocker/docker / /

CMD ["go", "run", "main.go"]

FROM scratch
COPY --from=builder /code/bin/backend /usr/local/bin/backend
CMD ["/usr/local/bin/backend"]

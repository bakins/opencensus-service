FROM golang:1.14.2 AS builder
 
ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64
ARG GO111MODULE=on
 
COPY . /src
RUN cd /src && go build -mod=vendor -o /tmp/ocagent ./cmd/ocagent
RUN cd /src && go build -mod=vendor -o /tmp/occollector ./cmd/occollector

FROM gcr.io/distroless/base
 
COPY --from=builder /tmp/ocagent /usr/bin/
COPY --from=builder /tmp/occollector /usr/bin/



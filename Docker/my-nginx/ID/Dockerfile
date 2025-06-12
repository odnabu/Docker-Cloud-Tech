# Build Stage
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod init docker-example-app || true
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /docker-example .
# Final Stage
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /docker-example .
EXPOSE 8080
CMD ["/root/docker-example"]


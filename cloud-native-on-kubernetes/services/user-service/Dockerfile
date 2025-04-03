FROM golang:1.23.7-bookworm AS builder
WORKDIR /app
COPY . .
RUN go mod tidy
RUN go build -o user-service

FROM debian:bookworm
WORKDIR /root/
COPY --from=builder /app/user-service .
# COPY --from=builder /app/.env .
EXPOSE 8080
CMD ["./user-service"]
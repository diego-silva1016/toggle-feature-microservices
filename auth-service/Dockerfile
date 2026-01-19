FROM golang:1.24-alpine AS builder
ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /app

COPY . .
RUN go mod tidy

# O binário será gerado com o nome 'myapp' dentro de /app
RUN go build -o myapp .

# Estágio final
FROM alpine:3.21 AS final

WORKDIR /root/
# Copiamos apenas o EXECUTÁVEL do estágio builder para a pasta atual
COPY --from=builder /app/myapp .

EXPOSE 8080

# Executamos o binário (agora ele está em /root/myapp)
CMD ["./myapp"]
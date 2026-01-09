#!/bin/sh
# entrypoint.sh

# Sai imediatamente se um comando falhar
set -e

# Se as variáveis não estiverem definidas, usa os padrões do Postgres
HOST="${DB_HOST:-postgres-service}"
PORT_DB="${DB_PORT:-5432}"

echo "Aguardando $HOST:$PORT_DB ficar pronto..."

# No Alpine, o comando nc -z precisa de um tempo de resposta (timeout)
# O loop continua enquanto nc não conseguir conectar
until nc -z -w 2 "$HOST" "$PORT_DB"; do
  echo "Banco ainda não disponível em $HOST:$PORT_DB... aguardando 1s"
  sleep 1
done

echo "O banco de dados $HOST está ativo! Executando comando final: $@"

# Executa o CMD do Dockerfile (que deve ser o seu app Go)
exec "$@"
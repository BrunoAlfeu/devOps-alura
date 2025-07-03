# 1. Use uma imagem base oficial e estável do Python.
# Usar uma imagem 'slim' é uma boa prática para manter o tamanho da imagem menor.
# A versão 3.11 é estável e atende ao pré-requisito do projeto (3.10+).
FROM python:3.11-slim

# 2. Defina o diretório de trabalho no contêiner.
WORKDIR /app

# 3. Copie o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# 4. Instale as dependências.
# A flag --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copie o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Exponha a porta em que o aplicativo será executado.
EXPOSE 8000

# 7. Comando para executar a aplicação quando o contêiner iniciar.
# Use 0.0.0.0 para o host para que a aplicação seja acessível de fora do contêiner.
# O --reload não é recomendado para um ambiente de produção/contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

FROM ruby:3.3.0

# Instale dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configuração do diretório de trabalho
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instale as dependências do projeto
RUN bundle install

# Copie todo o código do projeto para o contêiner
COPY . .

# Exponha a porta 3000
EXPOSE 3000

# Comando padrão para iniciar o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]
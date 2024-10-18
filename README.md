# Courses API

## Description

Courses API é um projeto desenvolvido em Ruby on Rails que permite a criação e gerenciamento de cursos. A API fornece endpoints para manipular informações sobre cursos, como título, descrição, datas de início, término e seus vídeos.

## Features

- Criar, ler, atualizar e excluir cursos
- Adicionar e excluir vídeos ao curso
- Validações de entrada para garantir a integridade dos dados

## Requirements

- Ruby 3.3.0
- Rails 7.1.3
- PostgreSQL

## Getting Started

### Setup

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/dayrajefil/courses-api.git
   cd courses-api
   ```

2. **Instale as dependências:**
  ```
  bundle install
  ```

3. **Configure o banco de dados:**

Crie um arquivo .env na raiz do projeto e adicione suas credenciais do PostgreSQL

  ```
    DB_USERNAME=seu_usuario
    DB_PASSWORD=suasenha
  ```

Depois, configure o banco de dados com:

  ```
  rails db:create
  rails db:migrate
  ```

4. **Carregue dados iniciais:**
  ```
  rails db:fixtures:load
  ```

5. **Prepare a base (opcional):**
  ```
  rake setup:development
  ```

### Running the Application

  ```
  rails server
  ```

## Running Tests

1. **Prepare o banco de teste:**

  ```
  rails db:test:prepare
  ```

2. **Rode os testes:**

  ```
  bundle exec rspec
  ```

## Example Usage

Você pode interagir com a API usando o projeto Course-front ou, se preferir, ferramentas como Postman ou curl.

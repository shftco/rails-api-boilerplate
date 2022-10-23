![build & test & quality](https://github.com/cousins-factory/rails-api-boilerplate/actions/workflows/main.yml/badge.svg?branch=main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version-3.1.2-blue.svg)
![Rails Version](https://img.shields.io/badge/rails_version-7.0.4-c52f24.svg)
[![Swagger documentation](https://img.shields.io/badge/swagger_documentation-84e92c.svg?&logo=swagger&logoColor=black)](docs/SWAGGER.md)

# Rails API Boilerplate
![cover](docs/cover.png)

# How to Works?
```mermaid
flowchart TD
  R[Request] --> C[Application Controller]
  C --> O[Application Operation]
  O -- Validate Params --> AC[Application Contract]
  O -- Application Contract returned success?--> S[Application Service]
  AC -- Validation success? --> O[Application Operation]
  AC -- Validation failed? --> E[Contract Errors]
  E --> RE
  S -- Process successful? --> RS[Resource]
  S -- Process failed? --> OE[Resource Errors]
  OE --> RE[Response]
  RS --> RE
  RE -- Returns --> C
```

# Documentations
- [Swagger](docs/SWAGGER.md)
- [Service generator](docs/SERVICE.md)
- [Contract generator](docs/CONTRACT.md)
- [Search & Filter & Sort](docs/RANSACK.md)

# Installation
## Prerequisites
- [Ruby](https://rvm.io/)
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)

## Installation
- Install GEM dependencies:
  ```bash
  bundle install
  ```

- Create database, migrate tables and run the seed data:
  ```bash
  rails db:create
  rails db:migrate
  rails db:seed
  ```

- If you are setting up again, when you already have previous databases:
  ```bash
  rails db:reset
  ```
  `reset` is equivalent of `rails db:drop & rails db:setup`.

-  Run the server
   ```bash
   ./bin/dev
   ```

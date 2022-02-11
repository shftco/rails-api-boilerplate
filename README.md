[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version-3.1.0-blue.svg)
![Rails Version](https://img.shields.io/badge/rails_version-7.0.2-c52f24.svg)

# Rails API Boilerplate

![cover](docs/cover.jpeg)

# Installation
## Prerequisites
- [Ruby](https://rvm.io/)
- [PostgreSQL](https://www.postgresql.org/)

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

- Then you need to keys of credentials for environments, you can get it from the project manager.

- If you are setting up again, when you already have previous databases:
  ```bash
  rails db:reset
  ```
  `reset` is equivalent of `rails db:drop & rails db:setup`.

web: bin/rails server
worker: bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate -t

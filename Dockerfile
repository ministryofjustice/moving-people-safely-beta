FROM ministryofjustice/ruby:2.3.0-webapp-onbuild

RUN apt-get update
RUN apt-get install -y wkhtmltopdf

ENV UNICORN_PORT 3000
EXPOSE $UNICORN_PORT

RUN RAILS_ENV=production SERVICE_URL=foo bundle exec rake assets:precompile --trace

ENTRYPOINT ["./run.sh"]

FROM ministryofjustice/ruby:2.3.0-webapp-onbuild

RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN xz -d wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN tar xf wkhtmltox-0.12.3_linux-generic-amd64.tar
RUN cp wkhtmltox/bin/wkhtmltopdf /usr/local/bin
RUN chmod 755 /usr/local/bin/wkhtmltopdf
RUN rm -rf wkhtmltox

ENV UNICORN_PORT 3000
EXPOSE $UNICORN_PORT

RUN RAILS_ENV=production SERVICE_URL=foo bundle exec rake assets:precompile --trace

ENTRYPOINT ["./run.sh"]

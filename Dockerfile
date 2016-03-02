FROM ministryofjustice/ruby:2.3.0-webapp-onbuild

RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN xz -d wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN tar xf wkhtmltox-0.12.3_linux-generic-amd64.tar
RUN cp wkhtmltox/bin/wkhtmltopdf /usr/local/bin
RUN chmod 755 /usr/local/bin/wkhtmltopdf
RUN rm -rf wkhtmltox

RUN cp -r ./fonts/liberation_sans /usr/share/fonts/truetype/
RUN fc-cache -f -v

ENV UNICORN_PORT 3000
EXPOSE $UNICORN_PORT

RUN RAILS_ENV=production SERVICE_URL=foo SMTP_DOMAIN=smtp_domain SMTP_HOSTNAME=smtp_hostname SMTP_PASSWORD=smtp_password SMTP_PORT=587 SMTP_USERNAME=smtp_username SECRET_KEY_BASE=foo exec rake assets:precompile --trace

ENTRYPOINT ["./run.sh"]

FROM python:3.9.7-alpine3.14

WORKDIR /usr/src/reminiscence

RUN apk add --no-cache \
  gcc=9.3.0-r2 \
  libxslt-dev=1.1.34-r0 \
  libxml2-dev \
  musl-dev \
  postgresql-dev \
  wkhtmltopdf=0.12.5-r1

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

RUN mkdir -p logs archive tmp

RUN python manage.py applysettings --docker yes
RUN python manage.py generatesecretkey

ENTRYPOINT [ "./entrypoint.sh" ]
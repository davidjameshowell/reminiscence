FROM python:3.9.7-alpine3.14

WORKDIR /usr/src/reminiscence

RUN apk add --no-cache \
  gcc \
  libxslt-dev \
  libxml2-dev \
  musl-dev \
  postgresql-dev \
  wkhtmltopdf \
  chromium

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

RUN mkdir -p logs archive tmp

RUN python manage.py applysettings --docker yes
RUN python manage.py generatesecretkey
RUN ln -s /usr/bin/chromium-brwoser /usr/bin/chromium

ENTRYPOINT [ "/usr/src/reminiscence/entrypoint.sh" ]

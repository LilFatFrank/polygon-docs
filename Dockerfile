FROM python:3.9-alpine

RUN apk update
RUN apk add rsync
RUN apk add git
RUN apk add nodejs npm
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt --no-cache-dir

# Copy mkdocs.yml into the Docker image
COPY mkdocs.yml mkdocs.yml
COPY overrides /overrides

# Build doc by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr", "0.0.0.0:8000"]

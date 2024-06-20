# Use an Alpine-based Python image for a smaller footprint
FROM python:3.9-alpine

# Update apk repositories and install necessary packages
RUN apk update && apk add --no-cache \
    rsync \
    git \
    nodejs \
    npm

# Copy the requirements file into the container
COPY requirements.txt.

# Install Python dependencies
RUN pip install -r requirements.txt --no-cache-dir

# Copy MkDocs configuration and documentation sources into the container
COPY mkdocs.yml.
COPY overrides /overrides
COPY docs /docs

# Expose port 8000 for the MkDocs server
EXPOSE 8000

# Serve the MkDocs site
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr", "0.0.0.0:8000"]

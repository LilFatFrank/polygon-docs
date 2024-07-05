# Use an Alpine-based Python image for a smaller footprint
FROM python:3.9-alpine

# Update apk repositories and install necessary packages
RUN apk update && apk add --no-cache \
    rsync \
    git \
    nodejs \
    npm \
    nginx

# Copy the requirements file into the container
COPY requirements.txt /requirements.txt

# Install Python dependencies
RUN pip install -r requirements.txt --no-cache-dir

# Copy MkDocs configuration and documentation sources into the container
COPY mkdocs.yml /mkdocs.yml
COPY overrides /overrides
COPY docs /docs

# Build the MkDocs site
RUN mkdocs build

# Copy the static site to Nginx's HTML directory
RUN cp -R site/* /usr/share/nginx/html/

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]

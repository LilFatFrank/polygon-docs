# Use an Alpine-based Python image for a smaller footprint
FROM python:3.9-alpine as builder

# Update apk repositories and install necessary packages
RUN apk update && \
    apk add --no-cache rsync git nodejs npm nginx bash && \
    rm -rf /var/cache/apk/*

# Copy the requirements file into the container
COPY requirements.txt /requirements.txt

# Install Python dependencies
RUN pip install -r /requirements.txt --no-cache-dir

# Copy your project code (including the MkDocs configuration)
COPY . .

# Build the MkDocs site - ensure this succeeds before copying
RUN mkdocs build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /site /usr/share/nginx/html

# Expose port 3000 for the web server
EXPOSE 3000

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]

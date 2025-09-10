# Use the official n8n image
FROM n8nio/n8n

# Copy your workflow files into the container
# The destination /data/n8n is where n8n inside Docker looks for import files
COPY *.json /data/n8n/

# (Optional) Set a default timezone if needed, e.g., 'Europe/Berlin'
# ENV TZ="UTC"
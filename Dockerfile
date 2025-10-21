# Use official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /data

# Install Django (and optional system dependencies if needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && pip install --no-cache-dir django==3.2 \
 && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Run database migrations
RUN python manage.py migrate --noinput

# Expose Django's default port
EXPOSE 8000

# Run Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

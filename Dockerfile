FROM python:3.9-slim

# Set working directory
WORKDIR /data

# Install system dependencies (optional, for building some Python packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
 && rm -rf /var/lib/apt/lists/*

# Copy dependency file if available (optional)
COPY requirements.txt .

# Install dependencies (try requirements.txt first, else Django 3.2)
RUN pip install --no-cache-dir -r requirements.txt || pip install django==3.2

# Copy project files
COPY . .

# Apply migrations
RUN python manage.py migrate --noinput

# Expose Django port
EXPOSE 8000

# Start Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Base image
FROM python:3.10-slim

# Set work directory inside container
WORKDIR /api

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all bot files
COPY . .

# Expose port for webhook mode (Koyeb needs this)
EXPOSE 8080

# Default environment variables (Koyeb overrides these)
ENV PORT=8080

# Run bot
CMD ["python", "bot.py"]

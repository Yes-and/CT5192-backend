FROM python:3.10-slim

WORKDIR /app

# Add build arg for New Relic license key
ARG NEW_RELIC_LICENSE_KEY
ENV NEW_RELIC_LICENSE_KEY=$NEW_RELIC_LICENSE_KEY
ENV NEW_RELIC_APP_NAME="LMS System - Backend"
ENV NEW_RELIC_ENVIRONMENT=production
ENV NEW_RELIC_CONFIG_FILE=newrelic.ini

# Install required packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose the application port
EXPOSE 4000

# Command to run the application with New Relic monitoring
CMD ["newrelic-admin", "run-program", "python", "app.py"]

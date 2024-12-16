# Use a base image with Python
FROM python:3.12-slim

# Install system dependencies including OpenCV, ZBar, and Pillow (PIL) dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \            
    libglib2.0-0 \                
    zbar-tools \                  
    libjpeg-dev \                 
    libpng-dev \                 
    libtiff-dev \                 
    libfreetype6-dev \           
    liblcms2-dev \                
    libwebp-dev \                
    && rm -rf /var/lib/apt/lists/*

# Set up a working directory
WORKDIR /app

# Copy the requirements file and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 8000

# Set the command to run your Flask app using Gunicorn
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8000"]

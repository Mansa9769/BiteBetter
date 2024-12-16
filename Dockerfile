# Use a base image with Python
FROM python:3.12-slim

# Install system dependencies including OpenCV, ZBar, and Pillow (PIL) dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \            # For OpenCV (libGL.so.1)
    libglib2.0-0 \                # For OpenCV
    zbar-tools \                  # For barcode/QR code scanning
    libjpeg-dev \                 # For JPEG support in Pillow
    libpng-dev \                  # For PNG support in Pillow
    libtiff-dev \                 # For TIFF support in Pillow
    libfreetype6-dev \            # For FreeType support in Pillow
    liblcms2-dev \                # For color management in Pillow
    libwebp-dev \                 # For WebP support in Pillow
    && rm -rf /var/lib/apt/lists/*  # Clean up APT cache to reduce image size

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

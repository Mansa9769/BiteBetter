FROM python:3.12-slim

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

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

WORKDIR /app

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8000"]

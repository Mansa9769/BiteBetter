FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \           
    libglib2.0-0 \                
    zbar-tools \                 
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

WORKDIR /app

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8000"]

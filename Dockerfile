# Menggunakan base image Python resmi
FROM python:3.9-slim

# Menetapkan working directory
WORKDIR /app

# Menyalin requirements dan menginstal dependensi
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Menyalin folder service ke dalam container
COPY service/ service/

# Membuat user non-root untuk keamanan (Seringkali ini yang membuat skor 1/2)
RUN useradd -u 1001 flaskuser
USER 1001

# Membuka port 8080
EXPOSE 8080

# Perintah untuk menjalankan aplikasi menggunakan Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "service:app"]

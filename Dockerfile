FROM python:3.10-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 \
    libgl1 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Install ultralytics and all deps first
RUN pip install --no-cache-dir -r requirements.txt

# Now forcibly replace opencv-python with headless using --ignore-installed
# This overwrites whatever opencv variant ultralytics pulled in
RUN pip install --no-cache-dir --ignore-installed opencv-python-headless

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
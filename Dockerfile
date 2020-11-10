FROM python:3.8

# Create app directory

WORKDIR /app

#Install app dependencies
COPY src/requirements.txt ./

RUN pip install -r requirements.txt

# Copy files from local
COPY src /app

CMD ["python","main.py"]

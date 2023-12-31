FROM python:3.8-alpine
RUN mkdir /app
ADD . /app
WORKDIR /app
EXPOSE 8080
RUN pip install -r requirements.txt
CMD ["python3", "app.py"]

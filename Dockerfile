FROM python:3.10.10

# Set working directory
WORKDIR /app

# Install g4f and FastAPI-related dependencies
RUN pip install g4f==0.5.2.1 \
    && pip install uvicorn python-multipart fastapi

# Copy the rest of the application code
COPY . /app

# Expose port for g4f API
EXPOSE 2400

# Start the g4f API server
CMD ["python", "-m", "g4f.cli", "api", "--bind", "0.0.0.0:2400"]

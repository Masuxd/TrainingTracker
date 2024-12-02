# Use the official Flutter image as the base image
FROM ghcr.io/cirruslabs/flutter:3.24.3

# Install necessary dependencies for running Flutter on web
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    && apt-get clean

# Enable web support
RUN flutter config --enable-web

# Create and set the working directory inside the container

WORKDIR /app

# Copy the application source code
COPY . .

# Get the dependencies
RUN flutter pub get

# Expose port 80
EXPOSE 80

# Run the Flutter web application
CMD ["flutter", "run", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "80"]
# Use the official Dart image for the build stage
FROM dart:stable AS build-env

# Install necessary dependencies for running Flutter on web
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    && apt-get clean

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-download Flutter dependencies
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade

# Enable web support
RUN flutter config --enable-web

# Create and set the working directory inside the container
RUN mkdir /app/
WORKDIR /app/

# Copy the application source code
COPY . /app/

# Build the Flutter web application
RUN flutter build web --release --web-renderer html

# Use a lighter base image for the final stage
FROM nginx:alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

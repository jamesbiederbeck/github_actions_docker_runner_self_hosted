FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    curl \
    tar \
    ca-certificates \
    git \
    libicu66 \
    libssl1.1 \
    libunwind8 \
    && rm -rf /var/lib/apt/lists/*

# Create the actions-runner directory
RUN mkdir /actions-runner

# Download the latest GitHub Actions runner
RUN curl -o /actions-runner/actions-runner-linux-arm64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-arm64-2.321.0.tar.gz

# Validate the hash (optional but recommended)
RUN echo "62cc5735d63057d8d07441507c3d6974e90c1854bdb33e9c8b26c0da086336e1  /actions-runner/actions-runner-linux-arm64-2.321.0.tar.gz" | sha256sum -c -

# Extract the runner
RUN tar xzf /actions-runner/actions-runner-linux-arm64-2.321.0.tar.gz -C /actions-runner

# Set working directory to the runner directory
WORKDIR /actions-runner

# Configure the runner (will use token from environment variable at runtime)
ENTRYPOINT ["./run.sh"]

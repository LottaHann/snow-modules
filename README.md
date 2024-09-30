

# Docker Compose Setup for Detection API and Expression API

This is the more automated version of snow object detection and expressions.
It will install pull and install two programs. One is the custom depthai object detection server.
The other is the Expressios api server


## Prerequisites

A ubuntu based OS

Before you begin, ensure you have the following installed on your system:

1. Docker 
2. Docker Compose 
3. Git 

## Getting Started

### 1. Clone the Repository

If you haven't already, clone the repository containing the Docker Compose file and the API services:

```bash
git clone https://github.com/Dodisbeaver/snow-modules.git
cd snow-modules
```

### 2. Install with setup Script

This script will clone the repositories and install them in containers.

```bash
chmod +x setup.sh
./setup.sh
```

After this, you can start the modules with the default depht AI camera environment:

```bash
docker compose up
```

If you do not have an depth ai camera. You can start the containers with

```bash
CAMERA=pedro docker compose up
```

This will use any camera attached to dev/video0
You can modify the code inside the camera_pedro.py to use the correct /dev/videoX if this is not the camera you want to use.

### 3. Verify the Services are Running

Check the status of your services in another terminal:

```bash
docker compose ps
```

You should see both `detection-api` and `expression-api` services listed as running.

### 5. Accessing the Services

- The Detection API will be available at `http://localhost:8008`
This is just for inspection and fun.

- The Expression API will be available at `http://localhost:5000`
This is where the expressions are rendered.

## Additional Commands

- To stop the services:
Press ctrl+C in terminal window or in another terminal window. Remember to be on the right folder path.
  ```bash
  docker compose down
  ```

- To view logs:
  ```bash
  docker compose logs
  ```

- To rebuild a specific service:
  ```bash
  docker compose build <service-name>
  ```

## Troubleshooting

- If you encounter issues with USB device access for the Detection API, ensure your user has the necessary permissions to access USB devices.
- For any other issues, check the logs of the specific service:
  ```bash
  docker compose logs <service-name>
  ```

## Notes

- The Expression API depends on the Detection API, so Docker Compose will ensure the Detection API starts first.
- Both services are connected through a custom bridge network named `app-network`.
- The Expression API service mounts a local directory to `/app` in the container, which can be useful for development purposes.

For more detailed information about the services and their configurations, refer to the `docker-compose.yml` file and the individual service documentation.
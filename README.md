# saunafs-container
Experimental container-based deployment cluster for [SaunaFS](https://github.com/leil-io/saunafs)

The ultimate goal of this repository is to create all advantages of containers into SaunaFS project.

## Warning - about testing and educational usage only

This project was created for making fast DEMOs and playground purpose.

**It should NOT be used for production data!**

## Requirements

Project requires `docker` and `docker-compose`

Also some (`1GB`) free space on hdd is recommended for efficient simulation of storage replication.

## Usage

Clone the repository:

```shell
git clone https://github.com/leil-io/saunafs-container.git
cd saunafs-container
```

Before building the images, create a file named `saunafs-apt-auth.conf` in the project root directory with your SaunaFS repository credentials:

```
machine repo.saunafs.com
login YOUR_USERNAME
password YOUR_PASSWORD
```

This file securely provides authentication for accessing the private SaunaFS APT repository during image builds.

> **Note:**  
> If you would like your own access key to the SaunaFS APT repositories, please email [contact@saunafs.com](mailto:contact@saunafs.com).

---

### Build and Run with Docker

```shell
# Build the shared base image
DOCKER_BUILDKIT=1 docker build \
  --secret id=apt_auth,src=saunafs-apt-auth.conf \
  -f saunafs-base/Dockerfile \
  -t saunafs-base saunafs-base/

# Build and start all services
docker compose up --build
```

### Build and Run with Podman

If you previously created a `./volumes` folder while using Docker, please delete it before deploying with Podman. This prevents permission issues that can occur due to differences in how Docker and Podman handle volume ownership.

```shell
# Build the shared base image
podman build \
  --secret id=apt_auth,src=saunafs-apt-auth.conf \
  -f saunafs-base/Dockerfile \
  -t saunafs-base saunafs-base/

# Build and start all services
podman-compose up --build
```

> **Note:**  
> `docker compose` (v2) or `podman-compose` is recommended.

---

Visit [http://localhost:29425/sfs.cgi?masterhost=master&masterport=9421](http://localhost:29425/sfs.cgi?masterhost=master&masterport=9421) to access the SaunaFS CGI.

## Data Persistence and Initialization

This Docker deployment is designed for ease of use and demonstration.
- **No Pre-committed Data**: The `volumes/` directory is no longer part of this repository.
- **Automatic Initialization**: On first startup, each service (master, metalogger, chunkservers) will automatically:
    - Create necessary configuration files using defaults from the SaunaFS packages (found in `/usr/share/doc/saunafs-*/examples/` within the containers).
    - Initialize their respective data directories.
- **Persistent Data**: If you map Docker volumes to the standard SaunaFS data and configuration paths (e.g., `/var/lib/saunafs/`, `/etc/saunafs/`), your data and custom configurations will persist across container restarts. If these mapped volumes are empty on first start, they will be initialized as described above.
- **Chunkserver Storage**:
    - Chunkservers will look for mount points at `/mnt/hdd001`, `/mnt/hdd002`, etc.
    - If you provide external volumes mounted to these paths in your `docker-compose.yml`, they will be used.
    - If these paths are not externally mounted, the startup script will create them as directories within the container (volatile storage) and issue a warning. This is suitable for testing but not for production data.

This setup ensures that you can get a SaunaFS cluster running quickly without manual configuration steps, while still allowing for persistent storage and custom configurations when needed.

## Cleaning Up Data

If you have used Docker named volumes or host-mounted directories (e.g., by customizing `docker-compose.yml` to map local paths like `./volumes/master/data:/var/lib/saunafs`), your SaunaFS data will persist even after containers are stopped and removed.

To completely reset the SaunaFS environment and start fresh, you will need to remove this persistent data. 

- **If using Docker named volumes**: You can list them with `docker volume ls` and remove them with `docker volume rm <volume_name>`.
- **If using host-mounted directories**: For example, if you created a local `volumes` directory in your project and mapped subdirectories from it (e.g., `volumes/master/data`, `volumes/chunkserver1/hdd001`, etc.), you would need to manually delete these local directories. 

  **Example for host-mounted `./volumes/` directory:**
  If you had a structure like:
  ```
  your-project-root/
    docker-compose.yml
    volumes/
      master/
        etc/
        var_lib/
      chunkserver1/
        hdd001/
        hdd002/
      ...
  ```
  You would remove the data by deleting the `volumes` directory from your host machine:
  ```shell
  # WARNING: This command permanently deletes data!
  # Ensure you are in your project root and understand the consequences.
  sudo rm -r ./volumes
  ```
  **Be extremely careful with `rm -r` commands.** Double-check the path to ensure you are deleting the correct directory. Incorrect usage can lead to irreversible data loss on your system.

After cleaning up persistent data, the next `docker compose up` will re-initialize everything from scratch using the default configurations.

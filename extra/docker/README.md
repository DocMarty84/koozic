This folder provides a basic Docker configuration file in order to run a fully functional KooZic
installation. It includes:
- Ubuntu 16.04
- KooZic 0.7.0
- PostgreSQL 9.5
- FFmpeg 3.4

By default, it is configured to take advantage of multi-processing. The container runs its own
PostgreSQL server on port 54321. Therefore, the latter should be available on your host system.

# Set up the container

1. Install Docker following the
[official instructions](https://docs.docker.com/engine/installation/)
2. Build:
```
docker build -t koozic .
```
3. Run:
```
docker run -d -p 8069:8069 -p 8072:8072 -v <host_folder>:/mnt/host:ro --name koozic koozic
```
Replace `<host_folder>` by the music folder you want to share. It will be available in `/mnt/host`
inside the container. KooZic should now be available at
[http://localhost:8069](http://localhost:8069).

# Execute the container

The usual Docker instructions can be used to start and stop the container:
```
docker start koozic
docker stop koozic
```

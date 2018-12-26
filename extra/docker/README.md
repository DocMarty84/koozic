This folder provides a basic Docker configuration using Docker-compose in order to run a fully functional KooZic
installation. It includes:
- Debian 9
- KooZic 1.1.0
- FFmpeg 3.4
- PostgreSQL from Docker hub

# Set up containers

1. Install Docker following the
[official instructions](https://docs.docker.com/engine/installation/)
2. Build:
```
docker-compose build
```
3. Configure:
Edit `docker-compose.yml` and replace `/music` by the music folder you want to share.
4. Run:
```
docker-compose up -d
```

KooZic should now be available at [http://localhost:8069](http://localhost:8069).
Don't forget to add `/mnt/host` in the Folders section.

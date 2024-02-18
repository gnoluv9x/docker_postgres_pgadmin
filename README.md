### Run this command to build docker container and run service

```bash
docker compose up --build -d
```

### Access: http://localhost:8800 to using pgAdmin

- Add new server
- Hostname using postgresql service name

### Using cli

```bash
docker exec -it <container-name> bash
psql -U <databaseUsername> <databaseName>
```

# Zeus Neon Database Configuration

## Overview
Zeus runs a Neon database instance, which consists of three main components:
- Pageserver: Handles storage and page delivery
- Safekeeper: Ensures durability and consistency
- Compute Node: Processes queries and manages connections

## Connection Details
- Port: 55432
- Host: 127.0.0.1 (localhost)
- Default user: neon
- Initial password is set during first start

## Components

### Pageserver
- HTTP API Port: 9898
- Data Directory: /var/lib/neon/pageserver
- Manages storage layers and page delivery

### Safekeeper
- Port: 5454
- Data Directory: /var/lib/neon/safekeepers/sk1
- Ensures WAL durability

### Compute Node
- Port: 55432
- Data Directory: /var/lib/neon/compute
- Handles query processing

## Usage

1. Connect to the database:
```bash
psql -h localhost -p 55432 -U neon
```

2. Check Neon status:
```bash
curl http://localhost:9898/v1/status
```

3. Monitor the services:
```bash
systemctl status neon-pageserver
systemctl status neon-safekeeper
systemctl status neon-compute
```

## Configuration

The Neon setup is optimized for performance:
- shared_buffers: 2GB
- effective_cache_size: 6GB
- maintenance_work_mem: 512MB
- work_mem: 20MB
- max_connections: 100

## Logs

View service logs:
```bash
journalctl -u neon-pageserver
journalctl -u neon-safekeeper
journalctl -u neon-compute
```

## Backup

Backup the Neon data directory:
```bash
sudo -u neon tar czf neon-backup.tar.gz /var/lib/neon
```

## Security

- All services listen on localhost by default
- Firewall rules only allow necessary ports
- Data directory permissions are set to 750
- Services run under the neon user
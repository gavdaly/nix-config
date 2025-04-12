# Hestia Database Storage Configuration

## BCacheFS Setup

This configuration uses BCacheFS to create a high-performance database storage system with:
- 5 SSDs for primary database storage
- 3 HDDs for backup and cold storage

### Storage Layout

The storage is configured with:
- Tier 0: SSD pool (5 devices)
  - Primary storage for all databases
  - All active database files
  - Write-ahead logs (WAL)
  - Indexes
- Tier 1: HDD pool (3 devices)
  - Backup storage
  - Archive storage
  - Cold data

### Database Configuration

1. PostgreSQL
   - Optimized for OLTP workloads
   - High I/O priority
   - Always kept on SSD tier
   - Path: `/var/lib/postgresql`

2. Neon Database
   - Optimized for high performance
   - High I/O priority
   - Always kept on SSD tier
   - Path: `/var/lib/neon`

3. CouchDB
   - Optimized for document storage
   - High I/O priority
   - Always kept on SSD tier
   - Path: `/var/lib/couchdb`

### Setup Instructions

1. Edit `setup-bcachefs.sh` to match your disk IDs:
```bash
# Find your disk IDs
ls -l /dev/disk/by-id/
```

2. Make the script executable:
```bash
chmod +x setup-bcachefs.sh
```

3. Run the setup script:
```bash
sudo ./setup-bcachefs.sh
```

### Configuration Details

The BCacheFS configuration is optimized for database workloads:
- Metadata and data are replicated across 2 devices for redundancy
- ZStd compression enabled for all data
- CRC32C checksums for both data and metadata
- Durability level set to 1 (immediate durability)
- High I/O priority for database volumes
- All database data prioritizes SSD tier

### Performance Optimizations

1. Replication Strategy
   - 2x replication for both data and metadata
   - Ensures data safety while maintaining performance

2. Compression
   - ZStd compression enabled
   - Good balance of compression ratio and performance
   - Especially effective for database text data

3. I/O Scheduling
   - High I/O priority for database subvolumes
   - Ensures consistent performance for database operations

4. Tiering Policy
   - Database files always stay on SSDs
   - Background data can move to HDDs based on access patterns

### Monitoring

Check filesystem status:
```bash
bcachefs fs usage /mnt
```

View subvolume details:
```bash
bcachefs subvolume list /mnt
```

### Maintenance

Regular maintenance tasks:
```bash
# Check filesystem
bcachefs fsck /dev/disk/by-label/bcache-pool

# Show device stats
bcachefs device list /mnt
```
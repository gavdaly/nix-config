#!/usr/bin/env bash
set -euo pipefail

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# SSDs for fast tier (database storage)
SSD1="/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_1"
SSD2="/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_2"
SSD3="/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_3"
SSD4="/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_4"
SSD5="/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_5"

# HDDs for backup tier
HDD1="/dev/disk/by-id/ata-WD_Red_14TB_1"
HDD2="/dev/disk/by-id/ata-WD_Red_14TB_2"
HDD3="/dev/disk/by-id/ata-WD_Red_14TB_3"

# Create the bcachefs pool with tiered storage
echo "Creating bcachefs pool..."
bcachefs format \
    --foreground \
    --replicas=2 \
    --label=bcache-pool \
    --tier=0 \
    --bucket=ssd \
    --error-action=panic \
    --compression=zstd \
    --metadata_replicas=2 \
    --data_replicas=2 \
    --durability=1 \
    --data_checksum_type=crc32c \
    --metadata_checksum_type=crc32c \
    "$SSD1" "$SSD2" "$SSD3" "$SSD4" "$SSD5" \
    --tier=1 \
    --bucket=hdd \
    "$HDD1" "$HDD2" "$HDD3"

# Mount the filesystem
echo "Mounting bcachefs pool..."
mount -t bcachefs /dev/disk/by-label/bcache-pool /mnt

# Create subvolumes for different databases
echo "Creating subvolumes..."
bcachefs subvolume create /mnt/postgresql
bcachefs subvolume create /mnt/neon
bcachefs subvolume create /mnt/couchdb

# Set properties for subvolumes
echo "Setting subvolume properties..."

# PostgreSQL - optimized for OLTP workloads
bcachefs set-option /mnt/postgresql \
    promotion_policy=always \
    background_target=0 \
    foreground_target=0 \
    compression=zstd \
    io_priority=high

# Neon database - optimized for high performance
bcachefs set-option /mnt/neon \
    promotion_policy=always \
    background_target=0 \
    foreground_target=0 \
    compression=zstd \
    io_priority=high

# CouchDB - optimized for document storage
bcachefs set-option /mnt/couchdb \
    promotion_policy=always \
    background_target=0 \
    foreground_target=0 \
    compression=zstd \
    io_priority=high

# Create directories with appropriate permissions
echo "Setting up permissions..."
install -d -m 750 -o postgres -g postgres /mnt/postgresql
install -d -m 750 -o neon -g neon /mnt/neon
install -d -m 750 -o couchdb -g couchdb /mnt/couchdb

echo "Setup complete. The bcachefs pool is mounted at /mnt"
echo ""
echo "Pool status:"
bcachefs fs usage /mnt
#!/usr/bin/env python3
import struct
import sys

# LP Metadata magic: 0x616c4c50 ("0PLa" in ASCII)
LP_MAGIC = 0x616c4c50
LP_HEADER_SIZE = 4096

def parse_lp_metadata(img_path):
    with open(img_path, 'rb') as f:
        # Find LP metadata (usually at offset 4096 or 12288)
        for offset in [4096, 12288]:
            f.seek(offset)
            magic = struct.unpack('<I', f.read(4))[0]
            if magic == LP_MAGIC:
                print(f"Found LP metadata at offset {offset} (0x{offset:x})")
                break
        else:
            print("LP metadata not found")
            return None
        
        # Parse header
        f.seek(offset)
        magic, major, minor = struct.unpack('<IHH', f.read(8))
        header_size = struct.unpack('<I', f.read(4))[0]
        
        # Read partition table (simplified)
        # LP metadata has a complex structure, let's scan for partition entries
        f.seek(offset)
        metadata = f.read(8192)
        
        # Look for partition names and their offsets
        partitions = {}
        pos = 0
        while pos < len(metadata) - 36:
            # Partition entry: name (36 bytes), is_dynamic (1 byte), first_extent (8 bytes), num_extents (4 bytes)
            name_bytes = metadata[pos:pos+36]
            if b'\x00' in name_bytes:
                name = name_bytes.split(b'\x00')[0].decode('ascii', errors='ignore')
                if name in ['system', 'vendor', 'product']:
                    # Try to find offset in nearby bytes
                    partitions[name] = {'name_offset': pos}
            pos += 1
        
        return partitions

def find_ext4_partitions(img_path):
    """Scan for ext4 filesystems in the image"""
    partitions = []
    with open(img_path, 'rb') as f:
        img_size = f.seek(0, 2)
        f.seek(0)
        
        # Scan for ext4 superblock magic (0xEF53) at offset 1080 from partition start
        # Check common partition boundaries
        for offset in [0x100000, 0x20000000, 0x40000000, 0x80000000, 0xC0000000]:
            if offset >= img_size:
                continue
            f.seek(offset + 1080)
            magic = f.read(2)
            if magic == b'\x53\xef':
                # Found ext4, read superblock to get size
                f.seek(offset + 1024)
                sb = f.read(1024)
                blocks_count = struct.unpack('<I', sb[4:8])[0]
                block_size = 1024 << struct.unpack('<I', sb[24:28])[0]
                size = blocks_count * block_size
                partitions.append({
                    'offset': offset,
                    'size': size,
                    'type': 'ext4'
                })
                print(f"Found ext4 at 0x{offset:x}, size {size/1024/1024:.1f} MB")
    
    return partitions

if __name__ == '__main__':
    img_path = '/tmp/rooting/dump/super.img'
    print("=== Scanning for partitions in super.img ===\n")
    
    # Parse LP metadata
    lp_parts = parse_lp_metadata(img_path)
    if lp_parts:
        print(f"\nFound {len(lp_parts)} logical partitions in metadata")
    
    # Scan for ext4 filesystems
    print("\n=== Scanning for ext4 filesystems ===")
    ext4_parts = find_ext4_partitions(img_path)
    print(f"\nFound {len(ext4_parts)} ext4 filesystems")

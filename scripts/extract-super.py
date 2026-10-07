#!/usr/bin/env python3
"""
extract-super.py - Extract logical partitions (system, vendor, product) from a
raw MediaTek/Android super.img dump.

The super partition uses Android's "Logical Partitions" (LP) metadata, magic
"0PLA" (0x414c5030), typically located at offset 0x3000 in the image.

Layout of the metadata (as found on the Blackview BL6000 Pro):
    0x3000 + 0   : LpMetadataHeader (128 bytes)
    0x3000 + 128 : partition table, 52 bytes/entry
                     name[36], attributes(4), first_extent_index(4),
                     num_extents(4), group_index(4)
    <after table>: extents table, 24 bytes/entry
                     num_sectors(8), target_type(4), target_data(8),
                     target_source(4)
    target_data is a 512-byte sector number into the super image.

A single logical partition may be made of several extents, which appear
contiguously inside the logical partition. We concatenate them in order.

Usage:
    python3 extract-super.py <super.img> <output-dir>
"""
import os
import struct
import sys

LP_META_OFFSET = 0x3000          # common location of LP metadata
PART_ENTRY_SIZE = 52
EXTENT_ENTRY_SIZE = 24
SECTOR_SIZE = 512


def parse_metadata(img_path):
    with open(img_path, "rb") as f:
        f.seek(LP_META_OFFSET)
        meta = f.read(4096)

    if meta[:4] != b"0PLA":
        raise SystemExit("LP metadata magic '0PLA' not found at 0x3000")

    header_size = struct.unpack("<I", meta[8:12])[0]
    table_start = header_size

    partitions = []
    i = 0
    while True:
        base = table_start + i * PART_ENTRY_SIZE
        ent = meta[base:base + PART_ENTRY_SIZE]
        if len(ent) < PART_ENTRY_SIZE:
            break
        name = ent[0:36].split(b"\x00")[0]
        if not name or not all(32 <= c < 127 for c in name):
            break
        attrs, first_extent, num_extents, group = struct.unpack("<IIII", ent[36:52])
        partitions.append({
            "name": name.decode("ascii"),
            "first_extent": first_extent,
            "num_extents": num_extents,
        })
        i += 1

    extents_start = table_start + len(partitions) * PART_ENTRY_SIZE
    # Number of extents = max(first_extent + num_extents)
    n_extents = max(p["first_extent"] + p["num_extents"] for p in partitions)
    extents = []
    for j in range(n_extents):
        base = extents_start + j * EXTENT_ENTRY_SIZE
        num_sectors, ttype, target_data, tsource = struct.unpack(
            "<QIQI", meta[base:base + EXTENT_ENTRY_SIZE]
        )
        extents.append({
            "num_sectors": num_sectors,
            "offset": target_data * SECTOR_SIZE,
            "size": num_sectors * SECTOR_SIZE,
        })

    for p in partitions:
        p["extents"] = extents[p["first_extent"]: p["first_extent"] + p["num_extents"]]

    return partitions


def extract_partition(img_path, out_path, part):
    """Concatenate all extents of a partition into out_path."""
    total = sum(e["size"] for e in part["extents"])
    with open(img_path, "rb") as src, open(out_path, "wb") as dst:
        for e in part["extents"]:
            src.seek(e["offset"])
            remaining = e["size"]
            # copy in 8 MB chunks
            chunk = 8 * 1024 * 1024
            while remaining > 0:
                data = src.read(min(chunk, remaining))
                if not data:
                    break
                dst.write(data)
                remaining -= len(data)
    return total


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)
    img_path, out_dir = sys.argv[1], sys.argv[2]
    os.makedirs(out_dir, exist_ok=True)

    parts = parse_metadata(img_path)
    print(f"Found {len(parts)} logical partitions:\n")
    for p in parts:
        total = sum(e["size"] for e in p["extents"])
        print(f"  {p['name']:10s} {total/1024/1024:8.1f} MB  ({p['num_extents']} extents)")
        for e in p["extents"]:
            print(f"      @0x{e['offset']:08x}  {e['size']/1024/1024:8.1f} MB")

    print("\nExtracting...")
    for p in parts:
        out = os.path.join(out_dir, f"{p['name']}.img")
        n = extract_partition(img_path, out, p)
        print(f"  wrote {out} ({n/1024/1024:.1f} MB)")
    print("Done.")


if __name__ == "__main__":
    main()


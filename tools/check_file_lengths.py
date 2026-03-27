#!/usr/bin/env python3
"""CI enforcement: fails if any Dart file in lib/ exceeds 300 lines."""
import os
import sys

MAX_LINES = 300
bad = []

for root, _, files in os.walk('lib'):
    for f in files:
        if f.endswith('.dart'):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as fh:
                lines = fh.readlines()
            if len(lines) > MAX_LINES:
                bad.append((path, len(lines)))

if bad:
    print("❌ Files exceeding max lines (300):")
    for p, l in bad:
        print(f"  {p}: {l} lines")
    sys.exit(1)

print("✅ File length check passed.")

#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

{
  echo "version: 1"
  echo "generated_at: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "providers:"
  echo "  - id: squire-components"
  echo "    name: Squire Components"
  echo "    description: Public reusable components for Squire."
  echo "    source: AndreBaltazar8/squire-components"
  echo "    components_dir: components"
  echo "    components:"
  for file in components/*.yaml; do
    id="$(awk -F': *' '$1 == "id" {print $2; exit}' "$file" | tr -d '"')"
    description="$(awk -F': *' '$1 == "description" {print $2; exit}' "$file" | sed 's/^"//; s/"$//')"
    echo "      - id: ${id}"
    echo "        description: ${description}"
    echo "        path: ${file}"
  done
} > index.yaml

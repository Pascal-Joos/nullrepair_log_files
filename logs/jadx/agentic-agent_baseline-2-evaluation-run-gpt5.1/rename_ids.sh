#!/bin/bash
for f in $(ls test-log-*.log | sort -V -r); do
  id=$(echo "$f" | sed -nE 's/test-log-([0-9]+)\.log/\1/p')
  echo "Processing file: $f, extracted id: $id"
  if [[ "$id" =~ ^[0-9]+$ ]] && [ "$id" -ge 21 ]; then
    new_id=$((id + 1))
    echo "Renaming $f to test-log-$new_id.log"
    mv "$f" "test-log-$new_id.log"
  fi
done
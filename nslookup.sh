#!/bin/bash

# File input berisi daftar website
INPUT_FILE="websites.txt"
# File output untuk menyimpan hasil
OUTPUT_FILE="nslookup_report.txt"

# Cek apakah file input ada
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: $INPUT_FILE not found!"
  exit 1
fi

# Hapus konten file report sebelumnya jika ada
> "$OUTPUT_FILE"

# Header untuk report
echo "NSLookup Report" | tee -a "$OUTPUT_FILE"
echo "===================" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# Loop melalui setiap website di dalam file
while IFS= read -r website; do
  # Lewati baris kosong atau baris yang dimulai dengan '#'
  if [[ -z "$website" || "$website" =~ ^# ]]; then
    continue
  fi

  # Melakukan nslookup
  echo "Checking: $website"
  nslookup_result=$(nslookup "$website" 2>&1)

  # Simpan hasil ke dalam file output
  echo "Website: $website" | tee -a "$OUTPUT_FILE"
  echo "$nslookup_result" | tee -a "$OUTPUT_FILE"
  echo "-------------------" | tee -a "$OUTPUT_FILE"
  echo "" | tee -a "$OUTPUT_FILE"

done < "$INPUT_FILE"

# Menampilkan pesan selesai
echo "NSLookup selesai. Hasil tersimpan di $OUTPUT_FILE"

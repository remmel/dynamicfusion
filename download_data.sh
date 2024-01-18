#!/bin/sh

# wget https://cloud9.cs.fau.de/index.php/s/46qcNZSNePHx08A/download # download all datasets
# or https://cloud9.cs.fau.de/index.php/s/46qcNZSNePHx08A # and choose for example umbrella
input_dir="$HOME/Downloads/VolumeDeformData/umbrella/data"
output_dir="data/umbrella"

mkdir -p "$output_dir/color"
mkdir -p "$output_dir/depth"

for file in "$input_dir"/*.color.png; do
    base_name=$(basename "$file" .color.png)
    base_name=${base_name#"frame-"}

    cp $file "$output_dir/color/${base_name}.png"
done

for file in "$input_dir"/*.depth.png; do
    base_name=$(basename "$file" .depth.png)
    base_name=${base_name#"frame-"}

    cp $file "$output_dir/depth/${base_name}.png"
done

#!/usr/bin/env bash
#
# @file: asset-sweeper.sh
# @description: move files with specific extension to another new directory
# @version: 1.0.0
# @author: Loouis Low (loouis@gmail.com)
# @license:
# @copyright:
#

source config.proto

######## funcs ########

function file_mover() {
  # --- args
  source_dir=$1
  file_ext=$2
  target_dir=$3
  # --- worker
  find ${source_dir} \
    -maxdepth 2 \
    -type f \
    -name "*.${file_ext}" \
    -print \
    -exec mv {} ${target_dir} \;
}

function file_organizer() {
  # --- args
  file_extensions=($1)
  target_locations=($2)
  move_to_dir=$3
  # --- worker
  for location in "${target_locations[@]}"; do
    for file in "${file_extensions[@]}"; do
      file_mover ${location} ${file} ${move_to_dir}
    done
  done
}

######## init ########

# --- usage
#
# "EXT1, EXT2, ..." "TARGET_DIR1, TARGET_DIR2, ..." "MOVE_TO_DIR"
#

file_organizer "jpg JPG jpeg JPEG webp WEBP png PNG" "$watch_dir1 $watch_dir2" "$move_to_image_dir"
file_organizer "mp4 mpeg mpg avi mkv" "$watch_dir1 $watch_dir2" "$move_to_video_dir"
file_organizer "zip tar.gz" "$watch_dir1 $watch_dir2" "$move_to_archive_dir"



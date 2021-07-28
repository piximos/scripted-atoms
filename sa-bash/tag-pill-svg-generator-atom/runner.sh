#!/bin/bash

random_id_generator() {
  letters="abcdefghijklmnopqrstuvwxyz"
  chars="${letters}0123456789"
  output="$(echo -n "${chars:RANDOM%${#letters}:1}")"
  for i in {1..8}; do
    output="$output$(echo -n "${chars:RANDOM%${#chars}:1}")"
  done
  echo "$output"
}

total_of_number_and_letters() {
  input_text="${1}"
  echo "$input_text" | awk -F '[0-9a-zA-Z]' '{print NF-1}'
}
total_of_separators() {
  input_text="${1}"
  echo "$input_text" | tr ',' '*' | tr '-' '*' | tr '_' '*' | tr '.' '*' | awk -F '*' '{print NF-1}'
}

container_height="110"
ratio=$((PILL_HEIGHT_IN_PX * 100 / container_height))

container_height=$((container_height * ratio / 100))
pill_height=$((100 * ratio / 100))
font_size=$((50 * ratio / 100))
outer_padding=$((5 * ratio / 100))
inner_padding=$((15 * ratio / 100))
ln_size=$((35 * ratio / 100))
s_size=$((18 * ratio / 100))
text_pos_y=$((70 * ratio / 100))
pill_pos_y=$((5 * ratio / 100))
pill_radius=$((20 * ratio / 100))

if [ "$pill_radius" -lt "5" ]; then
  pill_radius="5"
fi

p_ln_total="$(total_of_number_and_letters "$TAG_PREFIX")"
p_s_total="$(total_of_separators "$TAG_PREFIX")"
version_prefix_text_width=$((p_ln_total * ln_size + p_s_total * s_size))

v_ln_total="$(total_of_number_and_letters "$TAG_VALUE")"
v_s_total="$(total_of_separators "$TAG_VALUE")"
version_tag_text_width=$((v_ln_total * ln_size + v_s_total * s_size))

prefix_container_width=$((version_prefix_text_width + inner_padding * 2))
version_text_pos_x=$((prefix_container_width + outer_padding + inner_padding))
prefix_text_pos_x=$((outer_padding + inner_padding))
prefix_container_pos_x="$outer_padding"
background_container_pos_x="$outer_padding"
background_container_width=$((prefix_container_width + version_tag_text_width + inner_padding * 2))
container_width=$((outer_padding * 2 + background_container_width))
id_prefix="$(random_id_generator)"

cat "$PILL_TEMPLATE" |
  sed "s/{{id_prefix}}/${id_prefix}/g" |
  sed "s/{{outer_padding}}/${outer_padding}/g" |
  sed "s/{{container_width}}/${container_width}/g" |
  sed "s/{{container_height}}/${container_height}/g" |
  sed "s/{{pill_height}}/${pill_height}/g" |
  sed "s/{{font_size}}/${font_size}/g" |
  sed "s/{{text_pos_y}}/${text_pos_y}/g" |
  sed "s/{{pill_pos_y}}/${pill_pos_y}/g" |
  sed "s/{{pill_radius}}/${pill_radius}/g" |
  sed "s/{{background_container_width}}/${background_container_width}/g" |
  sed "s/{{background_container_pos_x}}/${background_container_pos_x}/g" |
  sed "s/{{prefix_container_width}}/${prefix_container_width}/g" |
  sed "s/{{prefix_container_pos_x}}/${prefix_container_pos_x}/g" |
  sed "s/{{prefix_text_pos_x}}/${prefix_text_pos_x}/g" |
  sed "s/{{version_prefix_text}}/${TAG_PREFIX}/g" |
  sed "s/{{version_text_pos_x}}/${version_text_pos_x}/g" |
  sed "s/{{pill_prefix_bg_color}}/${PILL_PREFIX_BG_COLOR}/g" |
  sed "s/{{pill_prefix_color}}/${PILL_PREFIX_COLOR}/g" |
  sed "s/{{pill_value_bg_color}}/${PILL_VALUE_BG_COLOR}/g" |
  sed "s/{{pill_value_color}}/${PILL_VALUE_COLOR}/g" |
  sed "s/{{version_tag_text}}/${TAG_VALUE}/g" \
    >"${PILL_OUTPUT}"

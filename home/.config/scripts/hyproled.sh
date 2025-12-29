#!/usr/bin/env bash
shift=false
invert=false
monitor=0
fill_color='0.0,0.0,0.0,1.0'

STATE_FILE="/dev/shm/hyproled_shift.state"
SHADER_FILE="/dev/shm/hyproled_shader.glsl"

show_help() {
  cat <<EOF
Usage: $(basename "$0") [OPTION]... [off]

Hyprland shader utility to prevent OLED burn in.

version: 0.1.3

Options:
  -a x:y:w:h  The effective area. Useful for bars. [Default: The entire screen]
  -i          Inverts the area. Useful for focus effect of a window or popup.
  -s          Shift lit pixels. Useful to prevent burn in, when called periodically.
  -m ID       Id of your oled monitor (hyprctl monitors). [Default: 0]
  -h          Display this help message.

Argument:
  off         Disable hyproled
EOF
}

is_fullscreen() {
  hyprctl activeworkspace -j | jq -r '.hasfullscreen' 2>/dev/null | grep -q "true"
  echo $?
}

if [[ $1 == off ]]; then
  hyprctl keyword decoration:screen_shader ""
  exit 0
fi

if [[ $1 == update ]]; then
  ~/.config/scripts/hyproled.sh -a 0:0:2880:67 -m 0
  exit 0
fi

if [[ $1 == listen ]]; then
  handle() {
    case $1 in
    "fullscreen>>"* | "workspace>>"*) ~/.config/scripts/hyproled.sh update ;;
    esac
  }
  socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
  exit 0
fi

while getopts ":a:ism:h" opt; do
  case $opt in
  a) area=$OPTARG ;;
  i) invert=true ;;
  s) shift=true ;;
  m) monitor=$OPTARG ;;
  h)
    show_help
    exit 0
    ;;
  *)
    show_help
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

if [[ $(is_fullscreen) -eq 0 ]]; then
  hyprctl keyword decoration:screen_shader ""
  exit 0
fi

# Compute shift offset
last_shift=0
[[ -f $STATE_FILE ]] && read -r last_shift <"$STATE_FILE"

if $shift; then
  shift_offset=$((1 - last_shift))
  echo "$shift_offset" >"$STATE_FILE"
else
  shift_offset=$last_shift
fi

shader_code="#version 300 es
precision highp float;
in vec2 v_texcoord;
uniform sampler2D tex;
uniform int wl_output;
layout(location = 0) out vec4 fragColor;
void main(){
  vec4 orig = texture(tex, v_texcoord);
  if(wl_output != ${monitor}) { fragColor = orig; return; }
  vec2 fc = gl_FragCoord.xy;
  bool even = mod(fc.x + fc.y + float(${shift_offset}),2.0)==0.0;
  vec4 pixel = even ? orig : vec4(${fill_color});
"

if [[ -n $area ]]; then
  if [[ $area =~ ^([0-9]+):([0-9]+):([0-9]+):([0-9]+)$ ]]; then
    read -r x y w h <<<"${BASH_REMATCH[*]:1:4}"
    shader_code+="  bool inRegion = (fc.x >= ${x}.0 && fc.x <= (${x}.0+${w}.0) && fc.y >= ${y}.0 && fc.y <= (${y}.0+${h}.0));
"
    if $invert; then
      shader_code+="  fragColor = inRegion ? orig : pixel;
"
    else
      shader_code+="  fragColor = inRegion ? pixel : orig;
"
    fi
    shader_code+="}
"
  else
    echo "Invalid area format, use x:y:w:h" >&2
    exit 1
  fi
else
  shader_code+="  fragColor = pixel;
}
"
fi

echo "$shader_code" >"$SHADER_FILE"

hyprctl keyword decoration:screen_shader "$SHADER_FILE"

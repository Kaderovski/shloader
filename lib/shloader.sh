#!/bin/bash
# https://github.com/Kaderovski/shloader
# me@kaderovski.com
set -Eeuo pipefail
trap end_shloader SIGINT SIGTERM ERR EXIT RETURN
tput civis


# Loaders
# EMOJIS
emoji_hour=( 0.08 'đ' 'đ' 'đ' 'đ' 'đ' 'đ' 'đ' 'đ' 'đ' 'đ' 'đ' 'đ')
emoji_face=( 0.08 'đ' 'đ' 'đ' 'đ' 'đ' 'đ¨' 'đĄ')
emoji_earth=( 0.1 đ đ đ )
emoji_moon=( 0.08 đ đ đ đ đ đ đ đ )
emoji_orange_pulse=( 0.1 đ¸ đś đ  đ  đś )
emoji_blue_pulse=( 0.1 đš đˇ đľ đľ đˇ )
emoji_blink=( 0.06 đ đ đ đ đ đ đ đ đ đ )
emoji_camera=( 0.05 đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đˇ đ¸ đˇ đ¸ )
emoji_sick=( 0.2 đ¤˘ đ¤˘ đ¤Ž )
emoji_monkey=( 0.2 đ đ đ đ )
emoji_bomb=( 0.2 'đŁ   ' ' đŁ  ' '  đŁ ' '   đŁ' '   đŁ' '   đŁ' '   đŁ' '   đŁ' '   đĽ' '    ' '    ' )
# ASCII
ball=( 0.2 '(â)' '(âŹ)')
arrow=( 0.06 'â' 'â' 'â' 'â' 'â' 'â' 'â' 'â')
cym=( 0.1 'â' 'â' 'â' 'â')
x_plus=( 0.08 'Ă' '+')
line=( 0.08 'â°' 'âą' 'âł' 'âˇ' 'âś' 'â´')
ball_wave=( 0.1 'đđđ' 'đđâ' 'đâÂ°' 'âÂ°â' 'Â°âđ' 'âđđ')
old=( 0.07 'â' "\\" '|' '/' )
dots=( 0.04 'âŁž' 'âŁ˝' 'âŁť' 'â˘ż' 'âĄż' 'âŁ' 'âŁŻ' 'âŁˇ' )
dots2=( 0.04 'â ' 'â ' 'â š' 'â ¸' 'â ź' 'â ´' 'â Ś' 'â §' 'â ' 'â ' )
dots3=( 0.04 'â ' 'â ' 'â ' 'â ' 'â ' 'â Ś' 'â ´' 'â ˛' 'â ł' 'â ' )
dots4=( 0.04 'â ' 'â ' 'â ' 'â ' 'â ' 'â ¸' 'â °' 'â  ' 'â °' 'â ¸' 'â ' 'â ' 'â ' 'â ' )
dots5=( 0.04 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ˛' 'â ´' 'â Ś' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' )
dots6=( 0.04 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ˛' 'â ´' 'â ¤' 'â ' 'â ' 'â ¤' 'â ´' 'â ˛' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' )
dots7=( 0.04 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â Ś' 'â ¤' 'â  ' 'â  ' 'â ¤' 'â Ś' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' )
dots8=( 0.04 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ˛' 'â ´' 'â ¤' 'â ' 'â ' 'â ¤' 'â  ' 'â  ' 'â ¤' 'â Ś' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' 'â ' )
dots9=( 0.04  'â˘š' 'â˘ş' 'â˘ź' 'âŁ¸' 'âŁ' 'âĄ§' 'âĄ' 'âĄ' )
dots10=( 0.04  'â˘' 'â˘' 'â˘' 'âĄ' 'âĄ' 'âĄ' 'âĄ ' )
dots11=( 0.04 'â ' 'â ' 'â ' 'âĄ' 'â˘' 'â  ' 'â ' 'â ' )


die() {
  local code=${2-1}
  exit "$code"
}


usage() {
  cat <<EOF

Available options:

-h, --help            <OPTIONAL>    Print this help and exit
-l, --loader          <OPTIONAL>   Chose loader to display
-m, --message         <OPTIONAL>    Text to display while loading
-e, --ending          <OPTIONAL>    Text to display when finishing

EOF
  exit 0
}


play_shloader() {
  while true ; do
    for frame in "${loader[@]}" ; do
      printf "\r%s" "${frame} ${message}"
      sleep "${speed}"
    done
  done
}


end_shloader() {
  kill "${shloader_pid}" &>/dev/null
  tput cnorm
  if [[ "${ending}" ]]; then
    printf "\r${ending}"; echo
  fi
}


shloader() {
  loader=''
  message=''
  ending=''

  while :; do
    case "${1-}" in
    -h | --help) usage;;
    -l | --loader)
      loader="${2-}"
      shift
      ;;
    -m | --message)
      message="${2-}"
      shift
      ;;
    -e | --ending)
      ending="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  if [[ -z "${loader}" ]] ; then
    loader=dots[@] 
  else
    loader=$loader[@]
  fi

  loader=( ${!loader} )
  speed="${loader[0]}"
  unset "loader[0]"

  tput civis
  play_shloader &
  shloader_pid="${!}"
}
shloader

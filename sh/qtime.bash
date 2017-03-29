#!/usr/bin/env bash
# -*- mode: sh; coding: utf-8 -*-
ME="${0##*/}"
##############################################################################
# This program is free software; you can redistribute it and/or modify it    #
# under the terms of the GNU General Public License as published by the Free #
# Software Foundation; either version 3 of the License, or (at your option)  #
# any later version.                                                         #
#                                                                            #
# This program is distributed in the hope that it will be useful, but with-  #
# out any warranty; without even the implied warranty of merchantability or  #
# fitness for a particular purpose. See the GNU General Public License for   #
# more details. <http://gplv3.fsf.org/>                                      #
##############################################################################

MY_APPNAME='qtime'
MY_AUTHOR='Klaus Alexander Seistrup <klaus@seistrup.dk>'
MY_REVISION='2017-03-29'
MY_VERSION="0.1.2 (${MY_REVISION})"
MY_COPYRIGHT="\
qtime/${MY_VERSION}
Copyright © 2017 ${MY_AUTHOR}

This is free software; see the source for copying conditions. There is no
warranty; not even for merchantability or fitness for a particular purpose.\
"
MY_HELP="
Usage: ${ME} [OPTIONS]

options are:
  -h, --help ........ display this help and exit
  -v, --version ..... output version information and exit
  -c, --copyright ... show copying policy and exit
"
MY_NY=('nearly ' 'almost ' '' 'just after ' 'after ')
MY_DV=('' 'five ' 'ten ' 'a quarter ' 'twenty ' 'twenty-five ' 'half ')
MY_HH=(
  'twelve' 'one' 'two' 'three' 'four' 'five'
  'six' 'seven' 'eight' 'nine' 'ten' 'eleven'
)

die () {
  [[ -n "${1}" ]] && {
    echo "${ME}:" "${@}" >&2
    exit 1
  }
  exit 0
}

my_help () {
  echo "${MY_HELP}"
}

my_version () {
  echo "${MY_APPNAME}/${MY_VERSION}"
}

my_copyright () {
  echo "${MY_COPYRIGHT}"
}

abs () {
  local plusminus="${1}"
  [[ "${plusminus}" -lt 0 ]] && plusminus=$((-plusminus))
  echo "${plusminus}"
}

my_qtime () {
  local top=''
  local now secs hh mm ss
  local adjust hours minutes divisions

  now=$(date '+%T')

  # HH:MM:SS
  # 01:34:67
  hh="${now:0:2}"
  mm="${now:3:2}"
  ss="${now:6:2}"

  secs=$(((("10#${hh}" * 60 + "10#${mm}") * 60 + "10#${ss}") % 86400))
  adjust=$(((secs + 30) / 60 + 27))
  hours=$(((adjust / 60) % 24))
  minutes=$((adjust % 60))
  divisions=$((minutes / 5 - 5))

  if [[ ${divisions} -lt 0 ]]; then
    top='to '
  elif [[ ${divisions} -gt 0 ]]; then
    top='past '
  fi

  printf "It's %s%s%s%s" \
    "${MY_NY[$((minutes % 5))]}" \
    "${MY_DV[$(abs ${divisions})]}" \
    "${top}" \
    "${MY_HH[$((hours % 12))]}"

  [[ ${divisions} -eq 0 ]] && echo -n " o'clock"

  echo '.'
}

main () {
  case "${1}" in
    -h | --help )
      my_help
    ;;
    -v | --version )
      my_version
    ;;
    -c | --copyright )
      my_copyright
    ;;
    '')
      : pass
    ;;
    * )
      my_help >&2
      exit 1
    ;;
  esac

  my_qtime

  exit 0
}

main "${@}"

# eof

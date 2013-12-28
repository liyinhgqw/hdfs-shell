
#!/bin/sh
# (c) 2013 Matthias Linder <matthias@matthiaslinder.com>
HPWD="/"

C_GREEN="\e[32;1m"
C_BLUE="\e[34;1m"
C_DEF="\e[m"
C_RED="\e[31;1m"

H="hadoop dfs"

function absolute() {
  echo $@ | egrep "^/" || echo "$HPWD/$@" | sed -e 's@//@/@g' 
}

while [ 1 ]; do
  echo -en "${C_BLUE}hdfs:${C_GREEN}$HPWD${C_BLUE}> ${C_DEF}"
  read line
  if [ -z "$line" ]; then continue; fi
  set $line
  case "$1" in
    'exit') exit 0;;
    'echo') echo "$@";;
    'cp') $H "-$1" "$(absolute $2)" "$(absolute $3)";;
    'mv') $H "-$1" "$(absolute $2)" "$(absolute $3)";;
    'get') $H "-copyToLocal" "$(absolute $2)" "$3";;
    'getm') $H "-getmerge" "$(absolute $2)" "$3";;
    'put') $H "-copyFromLocal" "$2" "$(absolute $3)";;
    'cd')
      old=$HPWD

# remove /XX/..
      HPWD=$(absolute "$2")
      pre="@@"
      while [ "$HPWD" != "$pre" ]; do
        pre=$HPWD
        HPWD=$(echo $HPWD | sed -e 's@/[^/]*/\.\.@@g')
        if [ "$HPWD" = "" -o "$HPWD" = "." ]; then HPWD="/"; fi
      done

# remove /.
      pre="@@"
      while [ "$HPWD" != "$pre" ]; do
        pre=$HPWD
        HPWD=$(echo $HPWD | sed -e 's@/\.@@g')
        if [ "$HPWD" = "" -o "$HPWD" = "." ]; then HPWD="/"; fi
      done

      if [ "$HPWD" != "/" ]; then
       HPWD=$(echo ${HPWD%/})
      fi

#      LS=$($H -ls "$HPWD") || HPWD=$old
#      echo "$LS" | tail -n +2 | sed 's/[^ ]* //g' | sed "s@^$HPWD/@@g"
      ;;
    *)
      $H "-$1" $(absolute $2) || \
      echo -e "${C_RED}ERROR: Unknown command: $1${C_DEF}"
      ;;
  esac
done


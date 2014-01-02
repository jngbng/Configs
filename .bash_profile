# for login shells.

# OPAM configuration
. /home/bongya/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
eval `opam config env`

LOCAL_BIN=/home/$USER/bin
PATH=$LOCAL_BIN:$PATH
PATH=$LOCAL_BIN/adt-bundle/eclipse:$LOCAL_BIN/adt-bundle/sdk/platform-tools:$LOCAL_BIN/adt-bundle/sdk/tools:$PATH
PATH=$LOCAL_BIN/p4v/bin:$PATH
PATH=$LOCAL_BIN/depot_tools:$PATH
#PATH=/opt/tar-1.27.1/bin/:$PATH
export PATH=$PATH
export ANDROID_HOME=$LOCAL_BIN/adt-bundle/sdk

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

branch_color ()
{
  if ! [ -z $(__git_ps1) ]; then
    # 현재 branch의 상태에 따라 branch 명의 색상을 변경
    changelist=$(git status -s | grep -oE "^..")
    stagedchanges=$(echo "$changelist" | grep -oE "^[^ ].")
    unstagedchanges=$(echo "$changelist" | grep -oE "^.[^ ]")
    if ! [ -z "$unstagedchanges" ]; then
      color="${c_red}"
    elif ! [ -z "$stagedchanges" ]; then
      color="${c_cyan}"
    else
      color="${c_green}"
    fi
  else
    return 0
  fi
  echo -ne $color 
}

export PS1=$PS1'\[$(branch_color)\]$(__git_ps1 | sed "s/^ *\(..*\)/\1 \$ /")\[${c_sgr0}\]'

mvbck ()
{
  FILE=$1
  if ! [ -a $FILE ]
  then
    echo "File not found: $FILE"
    return 1
  fi
  BACK=$FILE
  while [ -a $BACK ]
  do
    BACK=$BACK.bck
  done

  echo mv $FILE $BACK
  mv $FILE $BACK
}

export PS_FORMAT=pid,tty,time,command

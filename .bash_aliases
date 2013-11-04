alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias postgresd='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

alias ocaml='rlwrap --remember --history-filename=$HOME/.ocaml_history ocaml'
alias byebye='sudo shutdown -h now && exit'
alias matrix='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" `which grep` --color "[^ ]"'
alias of='ocamlfind ocamlbrowser -package '
alias ob='ocamlfind ocamlbrowser -all '
alias diffdir="vim -f '+next' '+execute \"DirDiff\" argv(0) argv(1)' "

if [ $(uname) = "Darwin" ];
then
#alias emacs='open -a Emacs --args'
  alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
fi

alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# mount
alias plsmb='sudo mount -t cifs \\\\plquad.postech.ac.kr\\plshare ~/plquad -o user=sjb -o uid=1000 -o gid=1000'
alias toymount='sudo smbmount \\\\172.16.202.129\\bongya vms -o user=bongya'

# network connection
alias isb='cocot -p euc-kr -t utf-8 ssh bbs@isb.or.kr'
alias pl='ssh sjb@pl.postech.ac.kr -o ForwardX11=yes'
alias plquad='ssh sjb@plquad.postech.ac.kr -o ForwardX11=yes'
alias lab='ssh 141.223.82.181 -o ForwardX11=yes'
alias amazon="ssh -i ~/.ssh/bongya.pem ubuntu@54.248.108.189"

alias tizen='ssh pl@141.223.82.195 -o ForwardX11=yes'

#util
mycalc()
{
  perl -e 'printf "%f\n", ($1)'
}
alias calc=mycalc


alias lssize='find . -type f -print0 | xargs -0 ls -l | sort -k5,5rn'
alias dusize='du -k * | sort -nr | cut -f2 | xargs du -sh'
alias clj='java -jar ~/.m2/clojure.jar'


alias linode='ssh bongya@106.187.44.158'

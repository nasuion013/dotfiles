export EDITOR="vim"
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
#export DROPBOX=`cat $HOME/.dropbox/info.json | jq -r .personal.path`

#export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

stty -ixon

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


#Add each completion script in the bash_completion.d directory
for file in ~/.bash_completion.d/*
do
  if [ \( -f $file -o -h $file \) -a -r $file ]; then
    # The file is a regular file or a symbolic link, and it is readable
    # by this script (for the user running the script).
    # That is good enough for us - source the file
    . $file
  fi
done

#Add bash aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
#Add system specific customizations
if [ -f ~/.bash_profile_local ] ; then
    . ~/.bash_profile_local
fi

#Enable tab completion for "g" by marking it as an alias for "git"
if type __git_complete &> /dev/null; then
  __git_complete g __git_main
fi;

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

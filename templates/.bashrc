if [ -f ~/bashcolors ]; then . ~/bashcolors fi

__git_ps1 () {
local b="$(git symbolic-ref HEAD 2>/dev/null)";
if [ -n "$b" ]; then
  printf " (%s)" "${b##refs/heads/}";
fi
}

export HISTTIMEFORMAT="%d/%m/%y %T "
# Define basic PS1 with coloring: [User ~/Folder]
PS1="[$Red\u$Color_Off@$Green\h$Color_Off $Yellow\w$Color_Off]"
# Define git stuff, if is in a git folder, it shows the name of the branch.
# And color it yellow when have no changes, and red if there is.
PS1=$PS1'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Yellow'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$IRed'"$(__git_ps1 " (%s)"); \
  fi)"; \
fi)'
export PS1=$PS1$Color_Off' \$ ';

# git aliases and functions
alias ll="ls -la --color=auto"
#alias ls="ls --color=auto"
##alias pega="git fetch origin; git pull --rebase origin \$(parse_git_branch)"
##alias manda="git push origin \$(parse_git_branch)"
##alias desfaztudo="git reset --hard origin/\$(parse_git_branch)"
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --'
#alias tmux="TERM=xterm-256color tmux"

function apagabranch() {
        git push origin :$1
        git branch -D $1
        echo git branch -D $1
}

## ENV
LANG=en_US.iso-8859-1
LC_CTYPE=en_US.iso-8859-1
LC_NUMERIC="en_US.iso-8859-1"
LC_TIME="en_US.iso-8859-1"
LC_COLLATE="en_US.iso-8859-1"
LC_MONETARY="en_US.iso-8859-1"
LC_MESSAGES="en_US.iso-8859-1"
LC_PAPER="en_US.iso-8859-1"
LC_NAME="en_US.iso-8859-1"
LC_ADDRESS="en_US.iso-8859-1"
LC_TELEPHONE="en_US.iso-8859-1"
LC_MEASUREMENT="en_US.iso-8859-1"
LC_IDENTIFICATION="en_US.iso-8859-1"
LC_ALL=
export LC_CTYPE=en_US.iso-8859-1
export LANG="$LC_CTYPE"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/vitor.cassiano/.sdkman"
[[ -s "/Users/vitor.cassiano/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/vitor.cassiano/.sdkman/bin/sdkman-init.sh"

# RVM for ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

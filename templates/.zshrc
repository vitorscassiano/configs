export LANG="en_US.UTF-8"
export EDITOR="code"
export GIT_EDITOR="$EDITOR"
export KUBE_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"


if command -v go >/dev/null 2>&1; then
    export GOPATH="$(go env GOPATH)"
    export GOBIN="$GOPATH/bin"
    export PATH="$GOBIN:$PATH"
fi

export ZSH="$HOME/.oh-my-zsh"
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/vitorcassiano/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Created by `pipx` on 2025-04-28 23:00:46
export PATH="$PATH:/Users/vitorcassiano/.local/bin"

ZSH_THEME="robbyrussell"

plugins=(git aws docker docker-compose gitignore gh golang helm kubectl kubectx nvm)

source $ZSH/oh-my-zsh.sh


alias vim="nvim"
alias gpt="chatgpt"
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --'
alias docker-login='aws ecr get-login-password --profile ops-prd | docker login --username AWS --password-stdin 289208114389.dkr.ecr.us-east-1.amazonaws.com'


commit() {
    if git diff --staged --quiet; then
        echo "No staged changes to commit."
        return 1
    fi
    local gd cp
    gd="$(git diff --staged)"
    cp="write an English git commit message based on the following changes:\n$gd"
    git commit -m "$(chatgpt "$cp")"
}

up() {
    case "$(uname)" in
        Linux)
            sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        ;;
        Darwin)
            brew update && brew upgrade && brew cleanup
        ;;
    esac
}

export OPENAI_API_KEY=""

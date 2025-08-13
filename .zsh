#############################
# 🎨 PROMPT PERSONNALISÉ
#############################

# Active la coloration du prompt avec nom de dossier et branche Git
autoload -Uz vcs_info
precmd() {
  vcs_info
}

# Couleurs
autoload -Uz colors && colors
setopt PROMPT_SUBST

# Personnalisation du prompt sans symbole `%` à la fin
PROMPT=$'%F{117}😎 ${vcs_info_msg_0_}\n%F{33}%~ \$ %f'
RPROMPT=''

# Active l'info de branche Git
zstyle ':vcs_info:git:*' formats '(%b)'


#############################
# 🌍 VARIABLES D'ENVIRONNEMENT
#############################

# Node.js
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

# Git : désactive l’édition automatique de message de merge
export GIT_MERGE_AUTOEDIT='no'

# Éditeurs par défaut
if command -v code >/dev/null 2>&1; then
  export EDITOR="code --wait"
else
  export EDITOR="${EDITOR:-vim}"
fi
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export SVN_EDITOR="$EDITOR"


#############################
# 🛣️ CHEMINS
#############################

# Ajoute les chemins importants à ton $PATH
USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"
export PATH="$USR_PATHS:$PATH"


#############################
# 🧰 FONCTIONS UTILITAIRES
#############################

# 💻 Aller rapidement sur le bureau
function desktop {
  cd "$HOME/Desktop/$*"
}

# 🔍 Chercher un processus (usage : `psg node`)
function psg {
  local FIRST=${1[1]}
  local REST=${1[2,-1]}
  ps aux | grep "[$FIRST]$REST"
}

# 📂 Crée un dossier et y entre
function mkcd {
  mkdir -p "$1" && cd "$1"
}

# 🧩 Décompresse n'importe quel fichier
function extract {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xvjf "$1" ;;
      *.tar.gz)  tar xvzf "$1" ;;
      *.tar.xz)  tar xvJf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.rar)     unrar x "$1" ;;
      *)         echo "'$1' ne peut pas être extrait automatiquement." ;;
    esac
  else
    echo "'$1' n'est pas un fichier valide."
  fi
}


#############################
# 🪄 ALIAS
#############################

# 📁 Liste détaillée des fichiers
alias l='ls -lah'

# 🧙‍♂️ Git
alias gcl="git clone"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gpo="git push origin"
alias gd="git diff | mate"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gcam="git commit -am"
alias gb="git branch"
alias gba="git branch -a"
alias gbb="git checkout -b"
alias gi="git rebase -i origin/main"
alias gr="git rebase origin/main"


#############################
# ⚙️ COMPLÉTION & COMPORTEMENTS
#############################

# Active la complétion (native avec Zsh)
autoload -Uz compinit && compinit

# Ignore la casse dans les complétions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Active l'historique partagé entre les onglets
setopt share_history

# Sauvegarde l’historique dans un fichier
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

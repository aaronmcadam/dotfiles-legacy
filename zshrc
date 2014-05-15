# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="aaron"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(tmux git git-flow brew npm osx jira syntax-highlighting nyan colored-man git-flow-completion zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $HOME/Workspace/code/repos/z/z.sh

export EDITOR=vim

# ruby GC performance
export RUBY_GC_HEAP_INIT_SLOTS=600000
export RUBY_GC_HEAP_FREE_SLOTS=600000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:$HOME/bin
autoload -U colors && colors

# nocorrect
alias mux="nocorrect mux"
alias cap="nocorrect cap"
alias work="~/Workspace/work"

# project shortcuts
alias msd="mux start dash"
alias msdi="mux start disc"
alias msc="mux start console"
alias msa="mux start apigem"
alias msm="mux start motoko"

# app shortcuts
alias v="vim"
alias v.="vim ."
alias v/="vim ~/.zshrc"
alias m="mvim"
alias m/="mvim ~/.zshrc"
alias s/="source ~/.zshrc"
alias r="rm"
alias rr="rm -rf"
alias rs="rails s"
alias rg="rails g"
alias b="bundle"
alias bu="bundle update"
alias bc="bundle clean --force"
alias be="bundle exec"
alias bake="bundle exec rake"
alias baket="bake -T"
alias sake="spring rake"
alias saket="sake -T"
alias ber="bundle exec rspec"
alias berp="ber -fp"
alias berd="ber -fd"
alias sr="spring rspec spec"
alias srp="sr -fp"
alias srd="sr -fd"
alias cuke="spring cucumber --format progress"
alias cr="cuke;srp"
alias kr="bake tmp:cache:clear;bake konacha:run"
alias ks="bake tmp:cache:clear;bake konacha:serve"
alias crk="cr;kr"
alias beg="bundle exec guard"
alias bv="bake version"
alias bvb="bake version:bump"
alias bvbp="bake version:bump:pre"
alias sv="sake version"
alias svb="sake version:bump"
alias svbp="sake version:bump:pre"
alias rc="rubocop"
alias rca="rc -a"
alias rcr="rc -R"
alias rcra="rc -Ra"
alias rbp="rails_best_practices -f html --with-mvim ."
alias rgl="rvm gemset list"
alias rgu="rvm gemset use"
alias tk="tmux kill-server"
alias rug="rvm gemset use global"
alias rud="rvm gem use dash-api3"
alias zr="source ~/.zshrc"
alias sudo="sudo "
alias rackspace="ssh root@31.222.186.202"
alias s1="ssh root@164.177.153.79"
alias as1="ssh app_user@164.177.153.79"
alias s2="ssh root@46.38.185.77"
alias as2="ssh app_user@46.38.185.77"
alias server='open http://localhost:1337 && python -m SimpleHTTPServer 1337'

# recursively create dirs, e.g. mkdir /path/to/this
alias c="clear"
alias mkdir='mkdir -p'

# Git shortcuts
alias gsl="g smart-pull"
alias gci="g ci -am"
alias gbm="gb -m"
alias gbd="gb -d"
alias gbdd="gb -D"
alias gm="g merge --no-ff"
alias gd="g d"
alias gdt="g difftool"
alias s="g status -sb"
alias gfo="g fetch origin"
alias glg="g l"
alias gsa="g stash"
alias gsp="gsa pop"
alias gsc="gsa clear"
alias gso="g remote show origin"
alias gcom="gco master"
alias gcod="gco develop"
alias gcf="gco forum"

alias gpf="gp -f"
alias gpm="gp origin master; gp origin master --tags"
alias gpd="gp origin develop; gp origin develop --tags"
alias gpb="gpm;gpd" # Git Push Both
alias grh="g reset --hard 'HEAD^'"
alias gaa="ga -A" # Stages All changes (new, modified AND deleted)
alias grb="g rebase -i"
alias grbl="grb HEAD~2" # git rebase last

# Git-Flow shortcuts
alias gfl="g fl" # flow
alias gf="g f"   # feature
alias gfs="g fs"
alias gff="g ff"
alias gr="g r"   # release
alias grs="g rs"
alias grf="g rf"

alias h="hub"
alias hc="hub clone"
alias hcp="hub clone -p"

alias dash="pushd ~/Workspace/work/dash"
alias disc="pushd ~/Workspace/work/discussion"
alias capd="cap deploy"
alias cappd="cap production deploy"
alias capb="capd && cappd"
alias cad="dash; gp; cap deploy; popd"

alias cv="cat lib/crowdlab/version.rb"
alias vv="v lib/crowdlab/version.rb"

alias sc="v /usr/local/etc/nginx/sites-enabled"
refresh_ctags(){
  ctags -R --exclude=.git --exclude=log --exclude=tmp *
}

prq() {
  h pull-request -m "$1" -b "$2" -h crowdlab-uk:"$3";
}

stripspace() {
  for f in `find . -name "*.rb"`
    do git stripspace < $f > ${f}.bak && mv ${f}.bak $f;
  done
}
source ~/bin/tmuxinator.zsh


setopt auto_cd
cdpath=($HOME/Workspace $HOME/Workspace/code $HOME/Workspace/work)

source ~/Workspace/code/k/k.sh
alias l="k"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias nvw="nvim ~/vimwiki/index.md"

alias ll="exa -l -g --icons"
alias cls="clear"
alias was="wave app:start"
alias wesh="wave app:exec sh"
alias dcs="docker container stop $(docker container list -q)"
alias ytr="git diff --name-only | xargs yarn test --findRelatedTests"
alias yp="git diff --name-only | xargs yarn prettifile"

starship init fish | source
zoxide init fish | source

cat ~/.GEMFURY_TOKEN | read token

set -gx GEMFURY_READ_TOKEN $token
set -gx POETRY_HTTP_BASIC_GEMFURY_PASSWORD NOPASS 
set -gx POETRY_HTTP_BASIC_GEMFURY_USERNAME $GEMFURY_READ_TOKEN
set -gx EDITOR nvim

function fish_greeting
	echo ""
	echo "Always login with docker, wave docker:login"
	echo ""
end

#funcsave fish_greeting
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"


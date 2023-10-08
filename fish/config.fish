abbr -a c 'cargo'
abbr -a g 'git'
abbr -a ga 'git add -p'
abbr -a ip 'ip --color=auto'

# Alias
abbr -a cat bat
if command -v exa > /dev/null
	abbr -a l 'exa'
	abbr -a ls 'exa'
	abbr -a ll 'exa -l'
	abbr -a lll 'exa -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

# Empty initial greeting.
set fish_greeting
# Full directory on fish prompt.
set fish_prompt_pwd_dir_length 0

setenv EDITOR hx
# TODO: add hx to the path also for the root user.
# setenv SUDO_EDITOR hx
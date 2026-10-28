abbr -a c cargo
abbr -a g git
abbr -a ga 'git add -p'
abbr gga "gg amend"
abbr gp "git push"
abbr gpf "git push --force-with-lease"
abbr gs "git status"
abbr -a ip 'ip --color=auto'
abbr -a copy 'xclip -selection clip'

# Alias
abbr -a cat bat
if command -v eza >/dev/null
    abbr -a l eza
    abbr -a ls eza
    abbr -a ll 'eza -l'
    abbr -a lll 'eza -la'
else
    abbr -a l ls
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

# Empty initial greeting.
set fish_greeting
# Full directory on fish prompt.
set fish_prompt_pwd_dir_length 0

setenv EDITOR hx
# hx is not in the path for the root user.
setenv SUDO_EDITOR $(which hx)

# Colored man pages.
# groff >= 1.23 emits SGR escapes, which less can't recolor. Use the old
# overstrike output instead so the -D options below apply.
setenv MANROFFOPT -c
# Bold in blue, underline in lavender, search results in black on yellow.
setenv MANPAGER "less --use-color -Dd+74 -Du+146 -DSky"

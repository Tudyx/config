abbr -a c cargo
abbr -a g git
abbr -a ga 'git add -p'
abbr -a gga 'gg amend'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'
abbr -a gs 'git status'
abbr -a ip 'ip --color=auto'
# Picks wl-copy, xclip, ... depending on the session (and OSC 52 over SSH).
abbr -a copy fish_clipboard_copy

# Alias
if command -q bat
    abbr -a cat bat
end
if command -q eza
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

set -gx EDITOR hx
# hx is not in the path for the root user.
set -gx SUDO_EDITOR (command -s hx)

# Colored man pages.
# groff >= 1.23 emits SGR escapes, which less can't recolor. Use the old
# overstrike output instead so the -D options below apply.
set -gx MANROFFOPT -c
# Bold in blue, underline in lavender, search results in black on yellow.
set -gx MANPAGER "less --use-color -Dd+74 -Du+146 -DSky"

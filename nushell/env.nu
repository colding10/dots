# Nushell Environment Config File
# version = 0.82.0

# The prompt indicators are environmental variables that represent
# the state of the prompt
# let-env PROMPT_INDICATOR = {|| "> " }
# let-env PROMPT_INDICATOR_VI_INSERT = {|| ": " }
# let-env PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
# let-env PROMPT_MULTILINE_INDICATOR = {|| "::: " }

let-env FUZZY_FINDER = "fzf"
let-env PAGER = "less -RF --incsearch --status-line --mouse --wheel-lines 3"
let-env MANPAGER = $env.PAGER
let-env DELTA_PAGER = "delta"
let-env BAT_PAGER = $env.PAGER

let-env EDITOR = nvim
let-env PATH = ($env.PATH | split row (char esep) 
                          | prepend '/opt/homebrew/bin' 
                          | prepend '/usr/local/bin'
                          | prepend '/usr/bin')
                          
let-env GH_USER = "colding10"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ("~/.config/nushell"    | path join 'scripts')
    ("~/.config/nushell"    | path join 'completions')
]

# Directories to search for plugin binaries when calling register
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
    ("~/.config/nushell"    | path join 'plugins')
]


zoxide init nushell | save -f ~/.zoxide.nu

mkdir ~/.cache/starship; starship init nu | save -f ~/.cache/starship/init.nu

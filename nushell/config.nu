# Nushell Config File
# version = 0.82.0

# External completer example
# let carapace_completer = {|spans|
#     carapace $spans.0 nushell $spans | from json
# }


# The default config record. This is where much of your global configuration is setup.
let-env config = {
  show_banner: false
  color_config: {
        # shape_external: red
    }

  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: auto # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    show_empty: true # show 'empty list' and 'empty record' placeholders for command output
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }
  history: {
		max_size: 1000000 # Session has to be reloaded for this to take effect
		sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
		file_format: "sqlite" # "sqlite" or "plaintext"
	}


  datetime_format: {
    normal: '%a, %d %b %Y %H:%M:%S %z'  # shows up in displays of variables or other datetime's outside of tables
    # table: '%m/%d/%y %I:%M:%S%p'        # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
  }

  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null # check 'carapace_completer' above as an example
    }
  }

  # cursor_shape: {
  #   emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
  #   vi_insert: block # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
  #   vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
  # }
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables

  use_ansi_coloring: true
  bracketed_paste: true # enable bracketed paste, currently useless on windows

  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

  hooks: {
    pre_prompt: [{||
      null  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{||
      null  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        null  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
    display_output: {||
      if (term size).columns >= 100 { table -e } else { table }
    }
    command_not_found: { |command| (
			if not (which mdfind | is-empty) {
				let pkgs = (mdfind "kMDItemFSName == '$command' && kMDItemContentTypeTree == 'public.unix-executable'" | lines)
				if not ($pkgs | is-empty) {
					( "This executable can be found in the following packages:\n" + $pkgs)
				} else {
					"mdfind failed to find this executable"
				}
			}
		) }

  }
}


source ~/.config/nushell/aliases.nu
source ~/.zoxide.nu

# starship
source ~/.cache/starship/init.nu

# completions
use gh-cmp.nu *
use git-completions.nu *
use proc-cmp.nu *


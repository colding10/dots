export EDITOR='nvim';

NODE_REPL_HISTORY_FILE=~/.node_history;
NODE_REPL_HISTORY_SIZE='32768';

export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

export LESS_TERMCAP_md="${yellow}";
export GREP_OPTIONS='--color=auto';
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include -I/usr/local/include -I/opt/homebrew/opt/gcc@13/include"
export CPLUS_INCLUDE_PATH="/usr/local/include"
export C_INCLUDE_PATH="/usr/local/include"

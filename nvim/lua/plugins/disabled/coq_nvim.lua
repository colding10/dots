return {
    {
        'ms-jpq/coq_nvim', 
        event = "BufEnter",
        branch = 'coq',
        config  = function() 
            vim.o.completeopt = 'menuone,noselect,noinsert'
            vim.o.showmode = false

            vim.g.coq_settings = {
                auto_start = 'shut-up',
                keymap = {
                    recommended = false,
                    jump_to_mark = "<c-,>"
                },
                clients = {
                    paths = {
                        path_seps = {"/"}
                    },
                    buffers = {
                        match_syms = true
                    }
                },
                display = {
                    ghost_text = {
                        enabled = true
                    }
                }
            }
        end
    }, 

    {
        'ms-jpq/coq.artifacts',
        event = "BufEnter",
        branch = 'artifacts'
    }, 

-- " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
-- " Need to **configure separately**
    {
        'ms-jpq/coq.thirdparty', 
        event = "BufEnter",
        branch = '3p'
    }
}

return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPost",
	priority = 500,
	opts = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions
		local completion = null_ls.builtins.completion

		return {
			debug = true,
			sources = {
				formatting.shfmt,
				formatting.prettier,

				formatting.black,
				formatting.fish_indent,
				formatting.clang_format,
				-- formatting.astyle,
				formatting.dprint,
        		formatting.prettier.with({ filetypes = { "markdown" } }),
				formatting.isort,

				diagnostics.fish,
				diagnostics.trail_space,
        		diagnostics.markdownlint,
				diagnostics.flake8,
        		diagnostics.deno_lint,
        		diagnostics.selene.with({
          			condition = function(utils)
            		return utils.root_has_file({ "selene.toml" })
          			end,
        		}),
				diagnostics.luacheck.with({
					condition = function(utils)
					  return utils.root_has_file({ ".luacheckrc" })
					end,
				}),
			},
		}
	end,
}

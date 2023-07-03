return {
    "RutaTang/compter.nvim",
    event = "BufReadPre",
    config = function()
        require("compter").setup({
            templates = {
                -- example template
                {
                    pattern = [[-\?\d\+]],
                    priority = 0,
                    increase = function(content)
                        content = tonumber(content)
                        return content + 1, true
                    end,
                    decrease = function(content)
                        content = tonumber(content)
                        return content - 1, true
                    end,
                },
                -- for lowercase alphabet
                {
                    pattern = [[\l]],
                    priority = 0,
                    increase = function(content)
                        local ansiCode = string.byte(content) + 1
                        if ansiCode > string.byte("z") then
                            ansiCode = string.byte("a")
                        end
                        local char = string.char(ansiCode)
                        return char, true
                    end,
                    decrease = function(content)
                        local ansiCode = string.byte(content) - 1
                        if ansiCode < string.byte("a") then
                            ansiCode = string.byte("z")
                        end
                        local char = string.char(ansiCode)
                        return char, true
                    end,
                },
                -- for uppercase alphabet
                {
                    pattern = [[\u]],
                    priority = 0,
                    increase = function(content)
                        local ansiCode = string.byte(content) + 1
                        if ansiCode > string.byte("Z") then
                            ansiCode = string.byte("A")
                        end
                        local char = string.char(ansiCode)
                        return char, true
                    end,
                    decrease = function(content)
                        local ansiCode = string.byte(content) - 1
                        if ansiCode < string.byte("A") then
                            ansiCode = string.byte("Z")
                        end
                        local char = string.char(ansiCode)
                        return char, true
                    end,
                },
                -- for date format: dd/mm/YYYY
                {
                    pattern = [[\d\{2}/\d\{2}/\d\{4}]],
                    priority = 100,
                    increase = function(content)
                        local ts = vim.fn.strptime("%d/%m/%Y", content)
                        if ts == 0 then
                            return content, false
                        else
                            ts = ts + 24 * 60 * 60
                            return vim.fn.strftime("%d/%m/%Y", ts), true
                        end
                    end,
                    decrease = function(content)
                        local ts = vim.fn.strptime("%d/%m/%Y", content)
                        if ts == 0 then
                            return content, false
                        else
                            ts = ts - 24 * 60 * 60
                            return vim.fn.strftime("%d/%m/%Y", ts), true
                        end
                    end,
                },
                -- for emoji ⭐
                {
                    pattern = [[⭐\{1,5}]],
                    priority = 0,
                    increase = function(content)
                        local l = #content / 3 + 1
                        if l > 5 then
                            l = 1
                        end
                        return string.rep("⭐", l), true
                    end,
                    decrease = function(content)
                        local l = #content / 3 - 1
                        if l < 1 then
                            l = 5
                        end
                        return string.rep("⭐", l), true
                    end,
                },
                -- for circle degree
                {
                    pattern = [[\d\{1,3}°]],
                    priority = 0,
                    increase = function(content)
                        local l = tonumber(content:sub(1, -3)) + 1
                        if l >= 360 then
                            l = 0
                        end
                        return string.format("%d°", l), true
                    end,
                    decrease = function(content)
                        local l = tonumber(content:sub(1, -3)) - 1
                        if l < 0 then
                            l = 359
                        end
                        return string.format("%d°", l), true
                    end,
                },
                -- for boolean
                {
                    pattern = [[\<\(true\|false\|TRUE\|FALSE\|True\|False\)\>]],
                    priority = 100,
                    increase = function(content)
                        local switch = {
                            ["true"] = "false",
                            ["false"] = "true",
                            ["True"] = "False",
                            ["False"] = "True",
                            ["TRUE"] = "FALSE",
                            ["FALSE"] = "TRUE",
                        }
                        return switch[content], true
                    end,
                    decrease = function(content)
                        local switch = {
                            ["true"] = "false",
                            ["false"] = "true",
                            ["True"] = "False",
                            ["False"] = "True",
                            ["TRUE"] = "FALSE",
                            ["FALSE"] = "TRUE",
                        }
                        return switch[content], true
                    end,
                }
            }
        })
    end,
}

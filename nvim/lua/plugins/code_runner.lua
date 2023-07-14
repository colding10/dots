return {
    "CRAG666/code_runner.nvim",
    event = "BufReadPre",

    opts = {
        mode = "toggleterm",
        start_insert = true,
        
        filetype = {
            javascript = "node",
            java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
            kotlin = "cd $dir && kotlinc-native $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt.kexe",
            c = {"cd $dir &&", "gcc $fileName", "-o $fileNameWithoutExt &&", "$dir/$fileNameWithoutExt"},
            cpp = {"cd $dir &&", "g++ $fileName", "-o /tmp/$fileNameWithoutExt &&", "/tmp/$fileNameWithoutExt"},
            python = {"cd $dir &&", "python3 $fileName"},
            python3 = {"cd $dir &&", "python3 $fileName"},
            sh = "bash",
            typescript = "deno run",
            typescriptreact = "yarn dev$end",
            rust = "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
            dart = "dart",
        }
    },
    config = true
}

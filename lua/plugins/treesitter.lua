return {
 {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = {"BufReadPost", "BufNewFile"},
  main = "nvim-treesitter.config",
  opts = {
    ensure_installed = { "lua", "markdown", "markdown_inline", "vimdoc", "python", "vim", "vimdoc", "json", "bash" },
    highlight = { enable = true },
    indent = { enable = true },
    },
  },
}


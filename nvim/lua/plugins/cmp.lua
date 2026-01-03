return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "zbirenbaum/copilot-cmp",
      "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

      cmp.setup({
          window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol", -- shows icon + text
            menu = nil,
            symbol_map = {
              Copilot = "",
            },
            menu = {
              copilot = "Copilot",
              nvim_lsp = "LSP",
              path = "Path",
              buffer = "Buffer",
            },
          }),
        },
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            require("cmp.config.compare").offset,
            require("cmp.config.compare").exact,
            require("cmp.config.compare").score,
            require("cmp.config.compare").recently_used,
            require("cmp.config.compare").kind,
            require("cmp.config.compare").sort_text,
            require("cmp.config.compare").length,
            require("cmp.config.compare").order,
          },
        },
        mapping = {
            ["<C-l>"] = cmp.mapping.complete(),                      -- trigger menu
            ["<Tab>"]  = cmp.mapping.confirm({ select = true }),      -- confirm with Enter
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<Esc>"] = cmp.mapping.abort(),
        },
        experimental = {
          ghost_text = false,
        },
      })
    end,
  },
}


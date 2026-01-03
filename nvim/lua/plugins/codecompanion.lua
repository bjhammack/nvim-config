return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    -- lazy = false,
    -- priority = 1000,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        interactions = {
            chat = {
              roles = {
                --- roles config isn't working yet
                ---The header name for the LLM's messages
                ---@type string|fun(adapter: CodeCompanion.Adapter): string
                llm = function(adapter)
                  return " (" .. adapter.formatted_name .. ")"
                end,
        
                ---The header name for your messages
                ---@type string
                user = "",
              }
            }
          },
        adapters = {
          copilot = { name = "copilot" },
        },
        strategies = {
          chat = { adapter = "copilot" },
          inline = { adapter = "copilot",
            diff = {
                    enable = true,
                    algorithm = "myers",
                },
            },
        },

        display = {
          chat = {
            window = {
              layout = "vertical",
              position = "right",
              width = 0.3,
            },
            show_token_count = false,
          },
          icons = {
            user = "",
            assistant = "",
            system = "󰒓",
          },
        inline = {
            layout = "inline",
        }
        },
      })
    end,
  },
}

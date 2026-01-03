return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "zbirenbaum/copilot.lua",
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    -- This is the critical part: registers commands so they exist and trigger lazy-load
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatReset",
      "CopilotChatPrompts",
      "CopilotChatModels",
    },
    build = "make tiktoken", -- optional; remove if it errors
    opts = {
        show_help = false,
        headers = {
            user = "  ",
            assistant = "  ",
            errors = "  ",
            tool = "  ",
    },
        welcome_message = "Welcome to Copilot Chat! Ask me anything. Type /prompts",
        separator = "──",
        auto_fold = true,
        window = {
            layout = "vertical",
            position = "right",
            width = 0.30,
            border = "rounded",
            title = " Copilot Chat ",
        },
    },
    -- keys = {
    --   { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat: Toggle" },
    --   { "<leader>co", "<cmd>CopilotChatOpen<cr>",   desc = "Copilot Chat: Open" },
    --   { "<leader>cr", "<cmd>CopilotChatReset<cr>",  desc = "Copilot Chat: Reset" },
    --   { "<leader>cp", "<cmd>CopilotChatPrompts<cr>",desc = "Copilot Chat: Prompts" },
    --   { "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "Copilot Chat: Models" },
    --   { "<leader>ca", "<cmd>CopilotChatApply<cr>",  desc = "Apply Copilot patch" },
    -- },
    config = function(_, opts)
      require("CopilotChat").setup(opts)

      local grp = vim.api.nvim_create_augroup("CopilotChatMarkdown", { clear = true })

      -- Attach after buffer is created/shown
      vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
        group = grp,
        callback = function(ev)
          local name = vim.api.nvim_buf_get_name(ev.buf)
          if name:match("copilot") or name:match("CopilotChat") then
            -- Force markdown so markdown renderers + treesitter apply
            vim.bo[ev.buf].filetype = "markdown"
            vim.bo[ev.buf].syntax = "markdown"

            -- Markdown UI
            vim.wo.conceallevel = 2
            vim.wo.concealcursor = "nc"
            vim.wo.wrap = true
            vim.wo.linebreak = true
          end
        end,
      })
    end
  }
}

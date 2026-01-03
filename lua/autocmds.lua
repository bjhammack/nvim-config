vim.api.nvim_create_autocmd("FileType", {
  pattern = "copilot-chat",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    -- makes markdown-y content feel less raw
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"

    -- quality-of-life
    vim.opt_local.spell = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Auto-open Copilot Chat + bottom terminal, then return focus to original window
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local start_win = vim.api.nvim_get_current_win()

    vim.defer_fn(function()
      -- 2) Open (or reuse) a bottom terminal
      local term_buf = nil
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
          term_buf = buf
          break
        end
      end

      if term_buf then
        -- show existing terminal in a bottom split
        vim.cmd("botright split")
        vim.cmd("resize 12")
        vim.api.nvim_win_set_buf(0, term_buf)
      else
        -- create a new terminal in a bottom split
        vim.cmd("botright split | resize 12 | terminal")
      end
      if vim.api.nvim_win_is_valid(start_win) then
        vim.api.nvim_set_current_win(start_win)
      end
      -- 1) Open Copilot Chat (if available)
      pcall(vim.cmd, "CodeCompanionChat")
      if vim.api.nvim_win_is_valid(start_win) then
        vim.api.nvim_set_current_win(start_win)
      end
      pcall(vim.cmd, "Neotree show left")

      -- 3) Return focus to the original starting window (if it still exists)
      if vim.api.nvim_win_is_valid(start_win) then
        vim.api.nvim_set_current_win(start_win)
      end
    end, 200)
  end,
})

-- Terminal behavior
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Turn off colorcolumn for Code Companion buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "codecompanion",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

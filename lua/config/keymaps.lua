-- CodeCompanion commands
vim.keymap.set("n", "<leader>cc", function()
  -- Try to find an existing CodeCompanion chat window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype

    if ft == "codecompanion" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- If none found, open a new chat
  vim.cmd("CodeCompanionChat")
end, { desc = "CodeCompanion Chat (focus or open)" })
vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
-- vim.keymap.set("n", "<leader>ci", "<cmd>CodeCompanionInline<cr>", { desc = "AI Inline" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Focus on terminal
vim.keymap.set("n", "<leader>t", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end, { desc = "Focus terminal" })
-- Focus on neo-tree window if it's open
vim.keymap.set("n", "<leader>e", "<cmd>Neotree focus left<cr>", { desc = "Focus Neo-tree" })
-- Focus the largest window (main)
vim.keymap.set("n", "<leader>wm", function()
  local max_win, max_area = nil, 0

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local width = vim.api.nvim_win_get_width(win)
    local height = vim.api.nvim_win_get_height(win)
    local area = width * height

    if area > max_area then
      max_area = area
      max_win = win
    end
  end

  if max_win then
    vim.api.nvim_set_current_win(max_win)
  end
end, { desc = "Focus largest window (main)" })

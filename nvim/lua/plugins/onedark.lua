local theme = require("config.theme")
return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  enabled = theme.active == "onedark",
  config = function()
    require("onedark").setup({
      style = "darker",
    })
    require("onedark").load()
  end,
}

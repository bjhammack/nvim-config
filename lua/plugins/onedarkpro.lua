local theme = require("config.theme")

return({
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    enabled = theme.active == "onedarkpro",
    opts = {
            theme = "onedark_dark",
            styles = {
            comments = "italic",
            keywords = "bold,italic",
            functions = "bold",
            variables = "NONE",
            -- conditionals = "bold,italic",
            constants = "bold",
            numbers = "NONE",
            booleans = "bold",
            properties = "NONE",
            types = "bold",
            operators = "bold",
        },
        highlights = {
        CursorLineNr = { fg = "#ff8800", bold = true },
        Visual = { bg = "#3E4452" },
        },
    },
    highlights = {
        CursorLine = { bg = "#2a2f3a" },          -- subtle line focus
        Visual     = { bg = "#3a3f4b" },          -- more visible selection
        Search     = { bg = "#3e4452", fg = "#e5c07b" },
        IncSearch  = { bg = "#e5c07b", fg = "#1e2127" },

        DiagnosticError = { fg = "#e06c75" },
        DiagnosticWarn  = { fg = "#e5c07b" },
        DiagnosticInfo  = { fg = "#61afef" },
        DiagnosticHint  = { fg = "#56b6c2" },

        -- Make “structure” stand out
        ["@keyword"]    = { fg = "#c678dd", bold = true },
        ["@function"]   = { fg = "#61afef" },
        ["@type"]       = { fg = "#e5c07b" },
        ["@parameter"]  = { fg = "#abb2bf", italic = true },
        ["@comment"]    = { fg = "#7f848e", italic = true },
      },
    config = function(_, opts)
        require("onedarkpro").setup(opts)
        require("onedarkpro").load()
    end,
})

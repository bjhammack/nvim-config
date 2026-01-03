return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- (Optional) capabilities for completion (nvim-cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp.default_capabilities(capabilities)
      end

      -- Define pyright configuration (Neovim 0.11+)
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic", -- "strict" if desired
            },
          },
        },
      })

      -- Enable the server
      vim.lsp.enable("pyright")
    end,
  },
}

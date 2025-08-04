return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('typescript-tools').setup {}
  end,
  -- settings = {
  --   tsserver_file_preferences = {
  --     includeInlayParameterNameHints = 'all',
  --     includeCompletionsForModuleExports = true,
  --     quotePreference = 'auto',
  --   },
  --   tsserver_format_options = {
  --     allowIncompleteCompletions = false,
  --     allowRenameOfImportPath = false,
  --   },
  -- },
}

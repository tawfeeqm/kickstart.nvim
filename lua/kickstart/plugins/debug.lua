-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/mfussenegger/nvim-dap-python',
}

-- Basic debugging keymaps, feel free to change to your liking!
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Set Breakpoint' })
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F7>', function() require('dapui').toggle() end, { desc = 'Debug: See last session result.' })

local dap = require 'dap'
local dapui = require 'dapui'

require('mason-nvim-dap').setup {
  -- Makes a best effort to setup the various debuggers with
  -- reasonable debug configurations
  automatic_installation = true,

  -- You can provide additional configuration to the handlers,
  -- see mason-nvim-dap README for more information
  handlers = {},

  -- You'll need to check that you have the required things installed
  -- online, please don't ask me how to install them :)
  ensure_installed = {
    -- Update this to ensure that you have the debuggers for the langs you want
    'delve',
    -- 'js' resolves to js-debug-adapter (Microsoft's vscode-js-debug). NOTE:
    -- this only *installs* the binary. mason-nvim-dap ships no adapter
    -- definition for it (see mappings/adapters/, which has no js.lua), so
    -- unlike delve it is not auto-configured -- the pwa-node wiring below is
    -- required for it to do anything.
    'js',
  },
}

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
---@diagnostic disable-next-line: missing-fields
dapui.setup {
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  ---@diagnostic disable-next-line: missing-fields
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

-- Change breakpoint icons
-- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
-- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
-- local breakpoint_icons = vim.g.have_nerd_font
--     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
--   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
-- for type, icon in pairs(breakpoint_icons) do
--   local tp = 'Dap' .. type
--   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
--   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
-- end

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Install golang specific config
require('dap-go').setup {
  delve = {
    -- On Windows delve must be run attached or it crashes.
    -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    detached = vim.fn.has 'win32' == 0,
  },
}

-- Python. Passing 'uv' makes the adapter launch as
-- `uv run --with debugpy python -m debugpy.adapter`, so debugpy is fetched on
-- demand and the debuggee runs inside the project venv -- meaning breakpoints
-- can see your project's dependencies. Nothing to install, no venv path to
-- hardcode. dap-python still falls back to $VIRTUAL_ENV / .venv discovery for
-- non-uv projects.
require('dap-python').setup 'uv'

-- A pytest file cannot be debugged with the plain 'file' config: running
-- `python tests/test_x.py` only defines the test functions and exits, so no
-- breakpoint is ever reached. These launch it under pytest instead.
-- dap-python picks pytest automatically from `[tool.pytest]` in pyproject.toml.
table.insert(require('dap').configurations.python, 1, {
  type = 'python',
  request = 'launch',
  name = 'pytest: current file',
  module = 'pytest',
  args = { '${file}', '-s' }, -- -s so print() output reaches the console
  console = 'integratedTerminal',
  cwd = '${workspaceFolder}',
})

-- Debug a single test rather than the whole file.
vim.keymap.set('n', '<leader>dm', function() require('dap-python').test_method() end, { desc = 'Debug: Test [M]ethod under cursor' })
vim.keymap.set('n', '<leader>dc', function() require('dap-python').test_class() end, { desc = 'Debug: Test [C]lass' })
vim.keymap.set('v', '<leader>ds', function() require('dap-python').debug_selection() end, { desc = 'Debug: [S]election' })

-- Evaluate expressions in the paused frame: call functions, test hypotheses,
-- inspect anything in scope -- without editing the file or re-running.
vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, { desc = 'Debug: Toggle [R]EPL' })

-- Stop at the `raise` itself rather than after the fact, with the offending
-- state still in scope. Written into dap.defaults (read at session start, see
-- session.lua) so it survives across sessions, and applied live if one is
-- already running.
vim.keymap.set('n', '<leader>dx', function()
  local enabled = type(dap.defaults.fallback.exception_breakpoints) == 'table'
  dap.defaults.fallback.exception_breakpoints = enabled and 'default' or { 'raised', 'uncaught' }
  if dap.session() then
    dap.set_exception_breakpoints(dap.defaults.fallback.exception_breakpoints)
  end
  vim.notify('Exception breakpoints: ' .. (enabled and 'default (uncaught only)' or 'raised + uncaught'))
end, { desc = 'Debug: Toggle e[X]ception breakpoints' })

-- Node / TypeScript. js-debug-adapter speaks DAP over a socket rather than
-- stdio, so it is a 'server' adapter: nvim-dap picks a free port, substitutes
-- it into ${port}, and the executable is spawned listening on it.
dap.adapters['pwa-node'] = {
  type = 'server',
  host = '127.0.0.1',
  port = '${port}',
  executable = {
    command = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter',
    args = { '${port}' },
  },
}

for _, ft in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
  dap.configurations[ft] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file (node)',
      program = '${file}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    {
      -- Runs .ts directly. Needs tsx available (npx fetches it on demand);
      -- without a loader, node cannot execute TypeScript.
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file (tsx)',
      program = '${file}',
      cwd = '${workspaceFolder}',
      runtimeExecutable = 'npx',
      runtimeArgs = { 'tsx' },
      sourceMaps = true,
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to process',
      processId = function() return require('dap.utils').pick_process() end,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
  }
end

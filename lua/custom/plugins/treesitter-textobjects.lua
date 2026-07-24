return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    }

    local select_textobject = require('nvim-treesitter-textobjects.select').select_textobject
    local swap_next = require('nvim-treesitter-textobjects.swap').swap_next
    local swap_previous = require('nvim-treesitter-textobjects.swap').swap_previous
    local goto_next_start = require('nvim-treesitter-textobjects.move').goto_next_start
    local goto_next_end = require('nvim-treesitter-textobjects.move').goto_next_end
    local goto_previous_start = require('nvim-treesitter-textobjects.move').goto_previous_start
    local goto_previous_end = require('nvim-treesitter-textobjects.move').goto_previous_end

    -- Select
    local selects = {
      ['a='] = { '@assignment.outer', 'Select outer part of an assignment' },
      ['i='] = { '@assignment.inner', 'Select inner part of an assignment' },
      ['l='] = { '@assignment.lhs', 'Select left hand side of an assignment' },
      ['r='] = { '@assignment.rhs', 'Select right hand side of an assignment' },

      -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
      ['a:'] = { '@property.outer', 'Select outer part of an object property' },
      ['i:'] = { '@property.inner', 'Select inner part of an object property' },
      ['l:'] = { '@property.lhs', 'Select left part of an object property' },
      ['r:'] = { '@property.rhs', 'Select right part of an object property' },

      ['aa'] = { '@parameter.outer', 'Select outer part of a parameter/argument' },
      ['ia'] = { '@parameter.inner', 'Select inner part of a parameter/argument' },

      ['ai'] = { '@conditional.outer', 'Select outer part of a conditional' },
      ['ii'] = { '@conditional.inner', 'Select inner part of a conditional' },

      ['al'] = { '@loop.outer', 'Select outer part of a loop' },
      ['il'] = { '@loop.inner', 'Select inner part of a loop' },

      ['af'] = { '@call.outer', 'Select outer part of a function call' },
      ['if'] = { '@call.inner', 'Select inner part of a function call' },

      ['am'] = { '@function.outer', 'Select outer part of a method/function definition' },
      ['im'] = { '@function.inner', 'Select inner part of a method/function definition' },

      ['ac'] = { '@class.outer', 'Select outer part of a class' },
      ['ic'] = { '@class.inner', 'Select inner part of a class' },
    }
    for key, query in pairs(selects) do
      vim.keymap.set({ 'x', 'o' }, key, function()
        select_textobject(query[1], 'textobjects')
      end, { desc = query[2] })
    end

    -- Swap
    local swap_nexts = {
      ['<leader>na'] = '@parameter.inner', -- swap parameters/argument with next
      ['<leader>n:'] = '@property.outer', -- swap object property with next
      ['<leader>nm'] = '@function.outer', -- swap function with next
    }
    for key, query in pairs(swap_nexts) do
      vim.keymap.set('n', key, function()
        swap_next(query)
      end)
    end
    local swap_previouses = {
      ['<leader>pa'] = '@parameter.inner', -- swap parameters/argument with prev
      ['<leader>p:'] = '@property.outer', -- swap object property with prev
      ['<leader>pm'] = '@function.outer', -- swap function with previous
    }
    for key, query in pairs(swap_previouses) do
      vim.keymap.set('n', key, function()
        swap_previous(query)
      end)
    end

    -- Move
    local move_next_starts = {
      [']f'] = { '@call.outer', 'Next function call start' },
      [']m'] = { '@function.outer', 'Next method/function def start' },
      [']c'] = { '@class.outer', 'Next class start' },
      [']i'] = { '@conditional.outer', 'Next conditional start' },
      [']l'] = { '@loop.outer', 'Next loop start' },
      -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
      [']s'] = { '@scope', 'Next scope', 'locals' },
      [']z'] = { '@fold', 'Next fold', 'folds' },
    }
    for key, spec in pairs(move_next_starts) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function()
        goto_next_start(spec[1], spec[3] or 'textobjects')
      end, { desc = spec[2] })
    end

    local move_next_ends = {
      [']F'] = { '@call.outer', 'Next function call end' },
      [']M'] = { '@function.outer', 'Next method/function def end' },
      [']C'] = { '@class.outer', 'Next class end' },
      [']I'] = { '@conditional.outer', 'Next conditional end' },
      [']L'] = { '@loop.outer', 'Next loop end' },
    }
    for key, spec in pairs(move_next_ends) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function()
        goto_next_end(spec[1], 'textobjects')
      end, { desc = spec[2] })
    end

    local move_previous_starts = {
      ['[f'] = { '@call.outer', 'Prev function call start' },
      ['[m'] = { '@function.outer', 'Prev method/function def start' },
      ['[c'] = { '@class.outer', 'Prev class start' },
      ['[i'] = { '@conditional.outer', 'Prev conditional start' },
      ['[l'] = { '@loop.outer', 'Prev loop start' },
    }
    for key, spec in pairs(move_previous_starts) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function()
        goto_previous_start(spec[1], 'textobjects')
      end, { desc = spec[2] })
    end

    local move_previous_ends = {
      ['[F'] = { '@call.outer', 'Prev function call end' },
      ['[M'] = { '@function.outer', 'Prev method/function def end' },
      ['[C'] = { '@class.outer', 'Prev class end' },
      ['[I'] = { '@conditional.outer', 'Prev conditional end' },
      ['[L'] = { '@loop.outer', 'Prev loop end' },
    }
    for key, spec in pairs(move_previous_ends) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function()
        goto_previous_end(spec[1], 'textobjects')
      end, { desc = spec[2] })
    end

    local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

    -- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    -- vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    -- vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    -- vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    -- vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}

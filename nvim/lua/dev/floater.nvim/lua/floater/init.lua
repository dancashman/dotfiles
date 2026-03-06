local M = {}
local job_id = 0

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local default_opts = {
  key_mapping = '<C-t>',
  escape = '<esc><esc>',
  jobs = {},
  insert_on_open = false,
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal', -- No borders or extra UI elements
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_terminal(insert_on_open)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
      job_id = vim.bo.channel
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
    return
  end

  if insert_on_open then
    vim.cmd 'startinsert'
  end
end

local function send_to_terminal(lines)
  if job_id ~= 0 then
    vim.fn.chansend(job_id, lines)
  end
end

function M.setup(opts)
  opts = vim.tbl_deep_extend('force', vim.deepcopy(default_opts), opts or {})
  vim.api.nvim_create_user_command('Floater', toggle_terminal, {})

  vim.keymap.set('t', opts.escape, '<C-\\><C-n>')
  vim.keymap.set('n', opts.key_mapping, function()
    toggle_terminal(opts.insert_on_open)
  end, { desc = 'Toggle Terminal' })

  vim.keymap.set('t', opts.key_mapping, function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
    toggle_terminal(opts.insert_on_open)
  end, { desc = 'Toggle Terminal' })

  for key, job in pairs(opts.jobs) do
    if type(key) == 'string' and type(job) == 'string' then
      vim.keymap.set('n', key, function()
        send_to_terminal { job }
      end, { desc = 'Send job to terminal' })
    end
  end
end

return M

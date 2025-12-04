local M = {}

local last_command = nil

local function append_to_buffer(buf, lines, hl_group)
  if not vim.api.nvim_buf_is_valid(buf) then return end

  local clean_lines = lines
  if #clean_lines > 0 and clean_lines[#clean_lines] == "" then
    table.remove(clean_lines, #clean_lines)
  end

  if #clean_lines == 0 then return end

  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

  -- Always append to the very end
  local line_count = vim.api.nvim_buf_line_count(buf)
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, clean_lines)

  if hl_group then
    for i = 0, #clean_lines - 1 do
      -- line_count is 1-based, highlight uses 0-based index. 
      -- Since we appended, the new lines start at (line_count).
      vim.api.nvim_buf_add_highlight(buf, -1, hl_group, line_count + i, 0, -1)
    end
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      local new_lc = vim.api.nvim_buf_line_count(buf)
      vim.api.nvim_win_set_cursor(win, { new_lc, 0 })
    end
  end

  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

M.compile_with_command = function(command_string)
  if not command_string or command_string == "" then
    command_string = vim.fn.input("Compile command: ", last_command or "")
    if command_string == "" then return end
  end

  last_command = command_string

  local cwd = vim.fn.getcwd()
  local bufrn = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufrn })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufrn })
  vim.api.nvim_set_option_value("filetype", "log", { buf = bufrn })

  vim.cmd("split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, bufrn)

  vim.api.nvim_buf_set_lines(bufrn, 0, -1, false, {
    "Work Dir: " .. cwd,
    "Command:  " .. command_string,
    string.rep("-", 40)
  })

  -- Highlight the header
  vim.api.nvim_buf_add_highlight(bufrn, -1, "Title", 0, 0, -1)
  vim.api.nvim_buf_add_highlight(bufrn, -1, "Statement", 1, 0, -1)
  vim.api.nvim_set_option_value("modifiable", false, { buf = bufrn })

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end, { buffer = bufrn, silent = true })

  vim.fn.jobstart({ "sh", "-c", command_string }, {
    cwd = cwd,
    stdout_buffered = false,
    stderr_buffered = false,

    on_stdout = function(_, data)
      if data then
        append_to_buffer(bufrn, data, nil)
      end
    end,

    on_stderr = function(_, data)
      if data then
        append_to_buffer(bufrn, data, "ErrorMsg")
      end
    end,

    on_exit = function(_, code)
      local msg = code == 0 and "-- SUCCESS --" or "-- FAILED (" .. code .. ") --"
      local hl = code == 0 and "String" or "ErrorMsg"
      append_to_buffer(bufrn, { "", msg }, hl)
    end,
  })
end

return M

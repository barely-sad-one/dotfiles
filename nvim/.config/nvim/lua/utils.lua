local M = {}

function M.load_custom_project_config(config_path)
  if type(config_path) ~= "string" or config_path == "" then
    vim.notify("Invalid config path", vim.log.levels.WARN)
    return nil
  end

  local project_config_path = vim.fn.getcwd() .. "/.nvim/" .. config_path

  if vim.fn.filereadable(project_config_path) == 1 then
    local ok, result = pcall(dofile, project_config_path)
    if not ok then
      vim.notify(
        "Failed to load project config '" .. config_path .. "': " .. result,
        vim.log.levels.ERROR
      )
      return nil
    end
    return result
  else
    vim.notify("Config file not found: " .. project_config_path, vim.log.levels.WARN)
    return nil
  end
end

return M


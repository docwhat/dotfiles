local M = {}

function M.set_user_var(key, value)
  -- Terminal command to set a variable.
  io.write(string.format("\027]1337;SetUserVar=%s=%s\a", key, M.base64(value)))
end

return M

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- mergeTable merges the otherTable into primeTable, overriding duplicate
-- keys in primeTable, and returns primeTable.
local function mergeTable(primeTable, otherTable)
  for k, v in pairs(otherTable) do
    if (type(v) == "table") and (type(primeTable[k] or false) == "table") then
      mergeTable(primeTable[k], otherTable[k])
    else
      primeTable[k] = v
    end
  end
  return primeTable
end

-- Requires moduleName and merges it into M.
local function mergeModule(moduleName)
  config = mergeTable(config, require(moduleName))
end

mergeModule("docwhat.display")
mergeModule("docwhat.keys")
mergeModule("docwhat.host")

return config

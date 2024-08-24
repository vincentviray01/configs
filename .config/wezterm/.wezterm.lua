local wezterm = require 'wezterm'
local act = wezterm.action

local mykeys = {} 
for i = 1, 9 do
  -- ALT + number to activate that tab
  table.insert(mykeys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

return {
  keys = mykeys,
}

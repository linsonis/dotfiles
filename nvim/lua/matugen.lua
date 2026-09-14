 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#141312',
    base01 = '#201f1e',
    base02 = '#2b2a29',
    base03 = '#949087',
    base04 = '#cbc6bc',
    base05 = '#e6e2e0',
    base06 = '#e6e2e0',
    base07 = '#e6e2e0',
    base08 = '#ffb4ab',
    base09 = '#e5e8e0',
    base0A = '#cac6c0',
    base0B = '#ede7db',
    base0C = '#c4c8c0',
    base0D = '#cbc6ba',
    base0E = '#cac6c0',
    base0F = '#e6e2dc',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e6e2e0',          bg = '#141312' })
  hi('TelescopeBorder',         { fg = '#949087',             bg = '#141312' })
  hi('TelescopePromptNormal',   { fg = '#e6e2e0',          bg = '#141312' })
  hi('TelescopePromptBorder',   { fg = '#949087',             bg = '#141312' })
  hi('TelescopePromptPrefix',   { fg = '#ede7db',             bg = '#141312' })
  hi('TelescopePromptCounter',  { fg = '#cbc6bc',  bg = '#141312' })
  hi('TelescopePromptTitle',    { fg = '#141312',             bg = '#ede7db' })
  hi('TelescopePreviewTitle',   { fg = '#141312',             bg = '#cac6c0' })
  hi('TelescopeResultsTitle',   { fg = '#141312',             bg = '#e5e8e0' })
  hi('TelescopeSelection',      { fg = '#e6e2e0',          bg = '#2b2a29' })
  hi('TelescopeSelectionCaret', { fg = '#ede7db',             bg = '#2b2a29' })
  hi('TelescopeMatching',       { fg = '#ede7db',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M

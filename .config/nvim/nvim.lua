print("Hello from init.lua")

vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/folke/snacks.nvim' },
})

-- Format on save...
require('conform').setup()
require('snacks').setup()
require('nvim-treesitter').setup()
-- require('nvim-lspconfig').setup()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("SnacksPickerHLFix", { clear = true }),
  callback = function()
    local function link(src, dst)
      pcall(vim.api.nvim_set_hl, 0, src, { link = dst })
    end

    -- Make floats match your buffer (or swap to bg="NONE" for transparency)
    local okN, Normal = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
    if okN then
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = Normal.bg, fg = Normal.fg })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = Normal.bg, fg = Normal.fg })
    end

    -- Link Snacks picker bits to common groups
    -- link("SnacksPickerInputBorder", "FloatBorder")
    -- link("SnacksPickerInputTitle",  "Title")
    -- link("SnacksPickerBoxTitle",    "Title")
    -- link("SnacksPickerSelected",    "Visual")
    -- link("SnacksPickerToggle",      "Boolean")        -- tweak to taste
    -- link("SnacksPickerPickWinCurrent", "Search")      -- current window label
    -- link("SnacksPickerPickWin",        "IncSearch")   -- other window labels
    -- (Optional) generic fallbacks
    link("SnacksPicker",           "NormalFloat")
    link("SnacksPickerBorder",     "FloatBorder")
    link("SnacksPickerTitle",      "Title")
  end,
})

-- Ensure it runs now for the current theme
vim.cmd("doautocmd ColorScheme")

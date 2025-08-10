-- colors/onedarker.lua
-- Author: Wei Lim
-- Description: Port of the helix onedarker theme by Gokul Soumya to Neovim

local p = {
  yellow      = "#E5C07B",
  blue        = "#61AFEF",
  red         = "#E06C75",
  purple      = "#C678DD",
  green       = "#98C379",
  gold        = "#D19A66",
  cyan        = "#56B6C2",
  white       = "#ABB2BF",
  black       = "#282C34",
  light_black = "#2C323C",
  gray        = "#3E4452",
  faint_gray  = "#3B4048",
  light_gray  = "#5C6370",
  linenr      = "#4B5263",
}

vim.g.colors_name = "gokul"

-- helpers
local function hl(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end
local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

----------------------------------------------------------------------
-- UI
----------------------------------------------------------------------
hl("Normal",       { fg = p.white, bg = p.black })
hl("NormalNC",     { fg = p.white, bg = p.black })
hl("SignColumn",   { bg = p.black })
hl("Cursor",       { fg = "#FFFFFF", reverse = true })
hl("lCursor",      { fg = "#FFFFFF", reverse = true })
hl("CursorIM",     { fg = "#FFFFFF", reverse = true })
hl("CursorLine",   { bg = p.light_black })
hl("CursorColumn", { bg = p.light_black })
hl("Visual",       { bg = p.faint_gray })
hl("VisualNOS",    { bg = p.gray })
hl("ColorColumn",  { bg = p.gray })                     -- ui.virtual.ruler
hl("Search",       { fg = p.blue, underline = true })   -- ui.cursor.match-esque
hl("IncSearch",    { fg = p.black, bg = p.blue })
hl("MatchParen",   { fg = p.blue, underline = true })
hl("LineNr",       { fg = p.linenr, bg = p.black })
hl("CursorLineNr", { fg = "#FFFFFF", bg = p.light_black })
hl("Folded",       { fg = p.light_gray, bg = p.faint_gray })
hl("FoldColumn",   { fg = p.light_gray, bg = p.black })
hl("WinSeparator", { fg = p.gray })
hl("NonText",      { fg = p.faint_gray })               -- ui.virtual
hl("Whitespace",   { fg = p.light_gray })               -- ui.virtual.whitespace
hl("SpecialKey",   { fg = p.faint_gray })               -- indent guides, etc.
hl("VertSplit",    { fg = p.gray })
hl("StatusLine",   { fg = "#FFFFFF", bg = p.light_black })
hl("StatusLineNC", { fg = p.light_gray, bg = p.light_black })
hl("TabLine",      { fg = p.light_gray, bg = p.light_black }) -- bufferline background
hl("TabLineFill",  { bg = p.light_black })                    -- bufferline bg
hl("TabLineSel",   { fg = p.light_black, bg = p.blue, bold = true }) -- active
hl("Pmenu",        { fg = "#FFFFFF", bg = p.gray })       -- ui.menu
hl("PmenuSel",     { fg = "#000000", bg = p.blue })       -- ui.menu.selected
hl("PmenuSbar",    { bg = p.light_gray })
hl("PmenuThumb",   { bg = p.light_gray })
hl("NormalFloat",  { fg = "#FFFFFF", bg = p.gray })       -- ui.popup/help
hl("FloatBorder",  { fg = p.gray,   bg = p.gray })
hl("Directory",    { fg = p.blue })                       -- ui.text.directory
hl("Title",        { fg = p.red, bold = true })           -- markup.heading
hl("Question",     { fg = p.green, bold = true })         -- info/hint tone
hl("MoreMsg",      { fg = p.blue, bold = true })
hl("ModeMsg",      { fg = p.white, bg = p.light_black, bold = true })
hl("WarningMsg",   { fg = p.yellow, bold = true })
hl("ErrorMsg",     { fg = p.red, bold = true })
hl("Debug",        { fg = p.red })                        -- ui.debug

----------------------------------------------------------------------
-- Diagnostics (LSP)
----------------------------------------------------------------------
hl("DiagnosticInfo",    { fg = p.blue,   bold = true })
hl("DiagnosticHint",    { fg = p.green,  bold = true })
hl("DiagnosticWarn",    { fg = p.yellow, bold = true })
hl("DiagnosticError",   { fg = p.red,    bold = true })
hl("DiagnosticUnderlineInfo",  { sp = p.blue,   undercurl = true })
hl("DiagnosticUnderlineHint",  { sp = p.green,  undercurl = true })
hl("DiagnosticUnderlineWarn",  { sp = p.yellow, undercurl = true })
hl("DiagnosticUnderlineError", { sp = p.red,    undercurl = true })
hl("DiagnosticUnnecessary",    { fg = p.light_gray, italic = true })
hl("DiagnosticDeprecated",     { strikethrough = true })

-- Inlay hints
hl("LspInlayHint", { fg = p.light_gray, bg = p.black })

----------------------------------------------------------------------
-- Diff
----------------------------------------------------------------------
hl("DiffAdd",    { fg = p.green })
hl("DiffChange", { fg = p.gold })
hl("DiffDelete", { fg = p.red })
hl("DiffText",   { fg = p.gold, bold = true })

----------------------------------------------------------------------
-- Core Syntax (vimscript)
----------------------------------------------------------------------
hl("Comment",   { fg = p.light_gray, italic = true }) -- comment
hl("Constant",  { fg = p.cyan })                       -- constant
hl("String",    { fg = p.green })                      -- string
hl("Character", { fg = p.gold })                       -- constant.character.escape-ish
hl("Number",    { fg = p.gold })
hl("Boolean",   { fg = p.gold })
hl("Float",     { fg = p.gold })
hl("Identifier",{ fg = p.white })
hl("Function",  { fg = p.blue })
hl("Statement", { fg = p.red })                        -- keyword
hl("Conditional",{ fg = p.purple })                    -- keyword.control
hl("Repeat",    { fg = p.purple })
hl("Label",     { fg = p.purple })
hl("Operator",  { fg = p.purple })
hl("Keyword",   { fg = p.red })
hl("Exception", { fg = p.purple })
hl("PreProc",   { fg = p.purple })                     -- keyword.directive
hl("Include",   { fg = p.red })                        -- keyword.control.import
hl("StorageClass",{ fg = p.purple })                   -- keyword.storage
hl("Structure",   { fg = p.yellow })                   -- type-ish
hl("Type",        { fg = p.yellow })
hl("Typedef",     { fg = p.yellow })
hl("Special",     { fg = p.blue })
hl("Underlined",  { underline = true })
hl("Ignore",      { fg = p.faint_gray })
hl("Error",       { fg = p.red })
hl("Todo",        { fg = p.purple, bold = true })

----------------------------------------------------------------------
-- Treesitter (modern @ captures)
-- Maps Helix scopes to closest @ captures in Neovim
----------------------------------------------------------------------
hl("@tag",                         { fg = p.red })     -- "tag"
hl("@attribute",                   { fg = p.yellow })  -- "attribute"
hl("@comment",                     { fg = p.light_gray, italic = true })
hl("@constant",                    { fg = p.cyan })
hl("@constant.builtin",            { fg = p.gold })
hl("@constant.character.escape",   { fg = p.gold })
hl("@number",                      { fg = p.gold })
hl("@constructor",                 { fg = p.blue })
hl("@function",                    { fg = p.blue })
hl("@function.builtin",            { fg = p.blue })
hl("@function.macro",              { fg = p.purple })
hl("@keyword",                     { fg = p.red })
hl("@keyword.control",             { fg = p.purple })
hl("@keyword.import",              { fg = p.red })
hl("@keyword.directive",           { fg = p.purple })
hl("@keyword.storage",             { fg = p.purple })
hl("@label",                       { fg = p.purple })
hl("@namespace",                   { fg = p.blue })
hl("@operator",                    { fg = p.purple })
hl("@string",                      { fg = p.green })
hl("@type",                        { fg = p.yellow })
hl("@variable.builtin",            { fg = p.blue })
hl("@variable.parameter",          { fg = p.red })
hl("@field",                       { fg = p.red })     -- "variable.other.member"

-- Markup (Markdown/markup.*)
hl("@markup.heading",              { fg = p.red, bold = true })
hl("@markup.raw",                  { fg = p.green })   -- inline code
hl("@markup.strong",               { fg = p.gold, bold = true })
hl("@markup.italic",               { fg = p.purple, italic = true })
hl("@markup.strikethrough",        { strikethrough = true })
hl("@markup.list",                 { fg = p.red })
hl("@markup.quote",                { fg = p.yellow })
hl("@markup.link.url",             { fg = p.cyan, underline = true })
hl("@markup.link",                 { fg = p.purple })  -- link text

----------------------------------------------------------------------
-- LSP semantic tokens (link to treesitter-ish groups)
----------------------------------------------------------------------
link("@lsp.type.namespace", "@namespace")
link("@lsp.type.class",     "@type")
link("@lsp.type.enum",      "@type")
link("@lsp.type.interface", "@type")
link("@lsp.type.struct",    "@type")
link("@lsp.type.typeParameter", "@type")
link("@lsp.type.parameter", "@variable.parameter")
link("@lsp.type.property",  "@field")
link("@lsp.type.variable",  "Identifier")
link("@lsp.type.function",  "@function")
link("@lsp.type.method",    "@function")
link("@lsp.mod.deprecated", "DiagnosticDeprecated")

----------------------------------------------------------------------
-- Git signs (if using gitsigns.nvim)
----------------------------------------------------------------------
hl("GitSignsAdd",    { fg = p.green })
hl("GitSignsChange", { fg = p.gold })
hl("GitSignsDelete", { fg = p.red })

----------------------------------------------------------------------
-- Telescope (optional but nice)
----------------------------------------------------------------------
hl("TelescopeNormal",   { fg = "#FFFFFF", bg = p.gray })
hl("TelescopeBorder",   { fg = p.gray, bg = p.gray })
hl("TelescopeSelection",{ fg = "#000000", bg = p.blue, bold = true })
hl("TelescopePromptNormal", { fg = "#FFFFFF", bg = p.gray })
hl("TelescopePromptBorder", { fg = p.gray,   bg = p.gray })

----------------------------------------------------------------------
-- Terminal ANSI (roughly match)
----------------------------------------------------------------------
vim.g.terminal_color_0  = p.black
vim.g.terminal_color_8  = p.light_black
vim.g.terminal_color_1  = p.red
vim.g.terminal_color_9  = p.red
vim.g.terminal_color_2  = p.green
vim.g.terminal_color_10 = p.green
vim.g.terminal_color_3  = p.gold
vim.g.terminal_color_11 = p.gold
vim.g.terminal_color_4  = p.blue
vim.g.terminal_color_12 = p.blue
vim.g.terminal_color_5  = p.purple
vim.g.terminal_color_13 = p.purple
vim.g.terminal_color_6  = p.cyan
vim.g.terminal_color_14 = p.cyan
vim.g.terminal_color_7  = p.white
vim.g.terminal_color_15 = "#FFFFFF"

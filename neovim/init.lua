vim.loader.enable()

vim.cmd.packadd("vim-jetpack")
local jetpack = vim.fn
jetpack["jetpack#begin"](vim.env.HOME .. "/.cache/jetpack")

local plugins = {
  { "tani/vim-jetpack" },
  { "neoclide/coc.nvim", { merged = 0, branch = "release", build = "yarn install --frozen-lockfile" } },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "ryanoasis/vim-devicons" },
  { "sainnhe/edge" },
  { "akinsho/toggleterm.nvim" },
  { "lambdalisue/fern.vim" },
  { "lambdalisue/fern-renderer-nerdfont.vim" },
  { "lambdalisue/nerdfont.vim" },
  { "lambdalisue/fern-hijack.vim" },
  { "lambdalisue/fern-git-status.vim" },
  { "lambdalisue/fern-mapping-git.vim" },
  { "github/copilot.vim" },
  { "mhinz/vim-startify" },
  { "0xAdk/full_visual_line.nvim" },
  { "vim-denops/denops.vim" },
  { "windwp/nvim-ts-autotag" },
  { "lambdalisue/glyph-palette.vim" },
  { "tyru/caw.vim" },
  { "Shougo/context_filetype.vim" },
  { "Raimondi/delimitMate" },
  { "sevenc-nanashi/rootfinder.vim" },
  { "gpanders/editorconfig.nvim" },
  { "nvim-treesitter/nvim-treesitter", { hook_post_update = "TSUpdate" } },
  { "pepo-le/win-ime-con.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-endwise" },
  { "alvan/vim-closetag" },
  { "tyru/open-browser.vim" },
  { "ldelossa/litee.nvim" },
  { "tyru/capture.vim" },
  { "ntpeters/vim-better-whitespace" },
  { "machakann/vim-sandwich" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  { "smoka7/hop.nvim" },
  { "sevenc-nanashi/force_16term.nvim" },
  { "kana/vim-submode" },
  { "fannheyward/telescope-coc.nvim" },
  { "monaqa/dial.nvim" },
  { "rcarriga/nvim-notify" },
  { "MunifTanjim/nui.nvim" },
  { "sevenc-nanashi/tint.nvim", { branch = "patch-1" } },
  { "4513ECHO/vim-snipewin" },
  { "lambdalisue/vim-findent" },
  { "HiPhish/rainbow-delimiters.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "andymass/vim-matchup" },
  { "folke/noice.nvim" },
  { "mattn/invader-vim" },
  { "4513ECHO/nvim-keycastr" },
  { "lervag/vimtex" },
  { "neoclide/coc-tsserver", { ["do"] = "yarn install --frozen-lockfile" } },
  { "sevenc-nanashi/neov-ime.nvim" },
  { "tpope/vim-rhubarb" },
  { "MeanderingProgrammer/render-markdown.nvim" },
  { "HakonHarnes/img-clip.nvim" },
  { "stevearc/dressing.nvim" },
  { "folke/snacks.nvim" },
  { "yetone/avante.nvim", { ["do"] = "make" } },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "cajames/copy-reference.nvim" },
  { "sevenc-nanashi/codex-ipc.vim" },
}

for _, plugin in ipairs(plugins) do
  if plugin[2] then
    jetpack["jetpack#add"](plugin[1], plugin[2])
  else
    jetpack["jetpack#add"](plugin[1])
  end
end
jetpack["jetpack#end"]()

vim.opt.termguicolors = true
vim.opt.conceallevel = 0
vim.opt.showtabline = 0
vim.g["jetpack#auto_recache"] = 1
vim.g.jetpack_copy_method = "hardlink"
vim.g.indentLine_setConceal = 0
vim.g.snipewin_label_font = "asciian_inverted"
vim.cmd([[runtime macros/sandwich/keymap/surround.vim]])
vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])

for _, name in ipairs(jetpack["jetpack#names"]()) do
  if not jetpack["jetpack#tap"](name) then
    jetpack["jetpack#sync"]()
    break
  end
end

vim.g.copilot_filetypes = { ["*"] = true }
if vim.fn.filereadable(vim.fn.expand("~/.nvimrc.local")) == 1 then
  vim.cmd.source(vim.fn.expand("~/.nvimrc.local"))
end

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "sjis" }
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.fileformats = { "unix", "dos" }
vim.opt.showmode = false
vim.opt.directory = vim.fn.expand("~/.vim/tmpfiles")
vim.opt.backupdir = vim.fn.expand("~/.vim/tmpfiles")
vim.opt.undodir = vim.fn.expand("~/.vim/tmpfiles")
vim.opt.wrap = false
vim.opt.clipboard:append("unnamedplus")
vim.g["fern#renderer"] = "nerdfont"
vim.opt.mouse = "a"
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.g.FZF_DEFAULT_OPTS = "--no-unicode"
vim.g.vimhelpgenerator_defaultlanguage = "en"
vim.g.edge_disable_italic_comment = 1
vim.g["fern#default_hidden"] = 1
vim.g["fern#renderer#nerdfont#indent_markers"] = 1
vim.cmd([[let g:tcomment#filetype#guess = { -> context_filetype#get().filetype }]])
local init_file = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p")

local function reload_lua()
  package.loaded.init = nil
  require("init")
end
vim.api.nvim_create_user_command("ReloadLua", reload_lua, { force = true })
vim.api.nvim_create_user_command("ReloadRc", function()
  vim.cmd.source(init_file)
  reload_lua()
end, { force = true })

local function switch_color()
  if vim.g.colo_init == 2 then
    vim.opt.background = "dark"
    vim.g.colo_init = 1
  else
    vim.opt.background = "light"
    vim.g.colo_init = 2
  end
  vim.cmd.colorscheme("edge")
  if vim.g.terminal_color_0 then
    vim.fn["force_16term#change_color"]()
  end
end
vim.api.nvim_create_user_command("SwitchColor", switch_color, { force = true })
if not vim.g.colo_init then
  vim.g.colo_init = 0
  switch_color()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function(args) vim.bo[args.buf].delimitMate_matchpairs = "(:),[:],{:}" end,
})
vim.api.nvim_create_autocmd("TermOpen", { callback = function() vim.cmd("DisableWhitespace") end })

local function get_buffer_id(index)
  local counter = 0
  for buffer = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buffer) == 1 and vim.bo[buffer].readonly == false and vim.bo[buffer].modifiable then
      counter = counter + 1
      if counter == index then return buffer end
    end
  end
  return nil
end
for index = 1, 9 do
  vim.keymap.set("n", "<M-" .. index .. ">", function()
    local buffer = get_buffer_id(index)
    if buffer then vim.cmd("buffer " .. buffer) end
  end, { silent = true })
end
vim.api.nvim_create_user_command("Bdelete", function(opts)
  vim.cmd("bn | bd" .. (opts.bang and "!" or "") .. "#")
end, { bang = true, force = true })
vim.api.nvim_create_user_command("RegBuf", function() vim.cmd([[enew | put! +]]) end, { force = true })

local function init_fern(args)
  vim.keymap.set("n", "<C-K><C-A>", "<Cmd>q<CR>", { buffer = args.buf })
  vim.keymap.set("n", "<Plug>(fern-my-open-or-toggle-expand)", function()
    local mapping = vim.fn["fern#smart#leaf"](
      "<Plug>(fern-action-open:edit)",
      "<Plug>(fern-action-expand)",
      "<Plug>(fern-action-collapse)"
    )
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(mapping, true, false, true), "m", false)
  end, { buffer = args.buf })
  vim.keymap.set("n", "<CR>", [[<Plug>(fern-my-open-or-toggle-expand)]], { buffer = args.buf })
  vim.keymap.set("n", "<S-CR>", [[<Plug>(fern-action-open-or-enter)]], { buffer = args.buf })
  vim.keymap.set("n", "Z", "<Nop>", { buffer = args.buf })
  vim.opt_local.number = false
end
local glyph_group = vim.api.nvim_create_augroup("my-glyph-palette", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = glyph_group,
  pattern = { "fern", "nerdtree", "startify" },
  callback = function()
    vim.fn["glyph_palette#apply"]()
    vim.api.nvim_set_hl(0, "GlyphPalette7", { fg = "#aaaaaa" })
  end,
})
vim.api.nvim_create_autocmd("FileType", { group = glyph_group, pattern = "fern", callback = init_fern })
vim.api.nvim_create_autocmd("UILeave", { group = glyph_group, callback = function() vim.cmd([[qall!]]) end })

local function reroot()
  local root = vim.fn["rootfinder#find"](vim.fn.getcwd())
  if #root > 0 then
    vim.cmd.cd(vim.fn.fnameescape(root))
    vim.notify("Root: " .. root)
  else
    vim.notify("Root not found", vim.log.levels.WARN)
  end
end
vim.api.nvim_create_user_command("ReRoot", reroot, { force = true })

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
local function scouter(file, include_comments)
  local lines = vim.fn.readfile(file)
  if not include_comments then
    lines = vim.fn.split(vim.fn.substitute(table.concat(lines, "\n"), "\\n\\s*\\\\", "", "g"), "\n")
  end
  local count = 0
  for _, line in ipairs(lines) do
    if not line:match("^%s*$") and not line:match('^%s*"') then count = count + 1 end
  end
  return count
end
local function run_scouter(opts)
  local file = opts.args ~= "" and vim.fn.expand(opts.args) or init_file
  vim.notify(tostring(scouter(file, opts.bang)))
end
vim.api.nvim_create_user_command("Scouter", run_scouter, { bang = true, nargs = "?", complete = "file", force = true })
vim.api.nvim_create_user_command("GScouter", function(opts)
  local file = opts.args ~= "" and vim.fn.expand(opts.args) or init_file
  vim.notify(tostring(scouter(file, opts.bang)))
end, { bang = true, nargs = "?", complete = "file", force = true })

local findent_group = vim.api.nvim_create_augroup("findent", { clear = true })
vim.api.nvim_create_autocmd("FileType", { group = findent_group, pattern = { "javascript", "json", "typescript" }, command = "Findent" })

vim.g.mapleader = ","
vim.g.maplocalleader = "_"
require("init")

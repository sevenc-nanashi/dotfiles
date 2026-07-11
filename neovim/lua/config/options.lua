vim.opt.termguicolors = true
vim.opt.conceallevel = 0
vim.opt.showtabline = 0
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
vim.opt.mouse = "a"
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.g.indentLine_setConceal = 0
vim.g.snipewin_label_font = "asciian_inverted"
vim.g.copilot_filetypes = { ["*"] = true }
vim.g.FZF_DEFAULT_OPTS = "--no-unicode"
vim.g.vimhelpgenerator_defaultlanguage = "en"
vim.g.edge_disable_italic_comment = 1
vim.g["fern#renderer"] = "nerdfont"
vim.g["fern#default_hidden"] = 1
vim.g["fern#renderer#nerdfont#indent_markers"] = 1

vim.cmd([[runtime macros/sandwich/keymap/surround.vim]])
vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])
vim.cmd([[let g:tcomment#filetype#guess = { -> context_filetype#get().filetype }]])

if vim.fn.filereadable(vim.fn.expand("~/.nvimrc.local")) == 1 then
  vim.cmd.source(vim.fn.expand("~/.nvimrc.local"))
end

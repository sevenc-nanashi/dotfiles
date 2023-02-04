---@diagnostic disable: undefined-global

local setup_bufferline = require("./setup-line").setup_bufferline

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
	setup_bufferline()
end

if not vim.g.colo_init then
  vim.g.edge_enable_italic = 0
	switch_color()
end

vim.keymap.set("", "U", "<C-R>", { noremap = false, silent = false })
vim.keymap.set("", "<C-S-O>", "<C-I>", { noremap = false, silent = false })
vim.keymap.set("i", "<S-Insert>", "<C-r><C-p>+", { noremap = false, silent = false })
vim.keymap.set("c", "<S-Insert>", "<C-r>+", { noremap = false, silent = false })
vim.keymap.set("t", "<S-Insert>", '<C-\\><C-n>"+pi', { noremap = false, silent = false })
vim.keymap.set("", "<Space>b", "<Cmd>Telescope buffers<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>f", "<Cmd>Telescope find_files<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>G", "<Cmd>Telescope live_grep<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>h", "<Cmd>Telescope help_tags<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gf", "<Cmd>Telescope git_files<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gb", "<Cmd>Telescope git_branches<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>gs", "<Cmd>Telescope git_status<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>ss", "<Cmd>Telescope coc document_symbols<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sS", "<Cmd>Telescope coc workspace_symbols<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sd", "<Cmd>Telescope coc document_diagnostics<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>sD", "<Cmd>Telescope coc workspace_diagnostics<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>c", "<Cmd>Telescope coc commands<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>w", "<Cmd>HopWord<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<Space>l", "<Cmd>HopLineStart<CR>", { noremap = false, silent = false })
vim.keymap.set("n", "<C-a>", "<Plug>(dial-increment)", { noremap = true, silent = false })
vim.keymap.set("n", "<C-x>", "<Plug>(dial-decrement)", { noremap = true, silent = false })
vim.keymap.set("v", "<C-a>", "<Plug>(dial-increment)", { noremap = true, silent = false })
vim.keymap.set("v", "<C-x>", "<Plug>(dial-decrement)", { noremap = true, silent = false })
vim.keymap.set("v", "g<C-a>", "g<Plug>(dial-increment)", { noremap = true, silent = false })
vim.keymap.set("v", "g<C-x>", "g<Plug>(dial-decrement)", { noremap = true, silent = false })
vim.keymap.set("n", "gx", "<Plug>(openbrowser-smart-search)", { noremap = true, silent = false })
vim.keymap.set("", "W", "b", { noremap = false, silent = false })
vim.keymap.set("", "<C-K><C-A>", "<Cmd>call OpenFern()<CR>", { noremap = false, silent = false })
vim.keymap.set(
	"",
	"<C-K><C-S>",
	'<Cmd>exe v:count1 . "ToggleTerm size=20 git_dir=. direction=horizontal"<CR>',
	{ noremap = false, silent = false }
)
vim.keymap.set("", "<C-K><C-D>", "<Cmd>TroubleToggle<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<C-K><C-X>", switch_color, { noremap = false, silent = false })
vim.keymap.set("", "<C-Tab>", "<Cmd>bn<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<C-S-W>", "<Cmd>bn<bar>bd#<CR>", { noremap = false, silent = false })
vim.keymap.set("", "<C-S-Tab>", "<Cmd>bp<CR>", { noremap = false, silent = false })
vim.keymap.set("n", "<M-Left>", "<Cmd>bp<CR>", { noremap = false, silent = true })
vim.keymap.set("n", "<M-Right>", "<Cmd>bn<CR>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-.>", "<Plug>(coc-codeaction)", { noremap = true, silent = true })
vim.keymap.set("", "<A-S-F>", function()
	vim.fn.CocAction("format")
end, { noremap = false, silent = true })
vim.keymap.set("n", "<F12>", function()
	vim.fn.CocActionAsync("jumpDefinition")
end, { noremap = true, silent = true })
vim.keymap.set("i", "<F12>", function()
	vim.fn.CocActionAsync("jumpDefinition")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<F2>", function()
	vim.fn.CocActionAsync("rename")
end, { noremap = true, silent = true })
vim.keymap.set("i", "<F2>", function()
	vim.fn.CocActionAsync("rename")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<M-.>", function()
	vim.fn.CocActionAsync("doHover")
end, { noremap = true, silent = true })
vim.keymap.set("i", "<M-.>", function()
	vim.fn.CocActionAsync("doHover")
end, { noremap = true, silent = true })
vim.keymap.set("", "<C-D>", "<Cmd>call CocAction('diagnosticNext')<CR>", { noremap = false, silent = true })
vim.keymap.set("i", "<C-D>", "<Cmd>call CocAction('diagnosticNext')<CR>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-S-D>", "<Cmd>call CocAction('diagnosticPrevious')<CR>", { noremap = false, silent = true })
vim.keymap.set("i", "<C-S-D>", "<Cmd>call CocAction('diagnosticPrevious')<CR>", { noremap = false, silent = true })
vim.keymap.set("i", "<C-Space>", "coc#refresh()", { noremap = true, silent = true, expr = true })

vim.keymap.set("i", "<CR>", function()
	if vim.fn["coc#pum#visible"]() == 1 then
		return vim.fn["coc#pum#confirm"]()
	else
		vim.api.nvim_feedkeys("\r", "n", true)
	end
end, { noremap = false, silent = true, expr = true })

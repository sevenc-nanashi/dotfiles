local function github(repository)
  return "https://github.com/" .. repository
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(args)
    local data = args.data
    if data.spec.name ~= "nvim-treesitter" or (data.kind ~= "install" and data.kind ~= "update") then
      return
    end
    vim.schedule(function()
      pcall(vim.cmd, "TSUpdate")
    end)
  end,
})

vim.pack.add({
  github("neovim/nvim-lspconfig"),
  github("nvim-lualine/lualine.nvim"),
  github("nvim-tree/nvim-web-devicons"),
  github("ryanoasis/vim-devicons"),
  github("sainnhe/edge"),
  github("akinsho/toggleterm.nvim"),
  { src = github("sevenc-nanashi/vim-fern"), version = "feat/denops-backend" },
  github("lambdalisue/fern-renderer-nerdfont.vim"),
  github("lambdalisue/nerdfont.vim"),
  github("lambdalisue/fern-hijack.vim"),
  github("lambdalisue/fern-git-status.vim"),
  github("lambdalisue/fern-mapping-git.vim"),
  github("github/copilot.vim"),
  github("mhinz/vim-startify"),
  github("0xAdk/full_visual_line.nvim"),
  github("vim-denops/denops.vim"),
  github("windwp/nvim-ts-autotag"),
  github("lambdalisue/glyph-palette.vim"),
  github("tyru/caw.vim"),
  github("Shougo/context_filetype.vim"),
  github("Raimondi/delimitMate"),
  github("sevenc-nanashi/rootfinder.vim"),
  github("gpanders/editorconfig.nvim"),
  github("nvim-treesitter/nvim-treesitter"),
  github("pepo-le/win-ime-con.nvim"),
  github("lewis6991/gitsigns.nvim"),
  github("tpope/vim-fugitive"),
  github("tpope/vim-endwise"),
  github("alvan/vim-closetag"),
  github("tyru/open-browser.vim"),
  github("tyru/capture.vim"),
  github("ntpeters/vim-better-whitespace"),
  github("machakann/vim-sandwich"),
  github("nvim-lua/plenary.nvim"),
  github("nvim-telescope/telescope.nvim"),
  github("smoka7/hop.nvim"),
  github("sevenc-nanashi/force_16term.nvim"),
  github("kana/vim-submode"),
  github("monaqa/dial.nvim"),
  github("rcarriga/nvim-notify"),
  github("MunifTanjim/nui.nvim"),
  { src = github("sevenc-nanashi/tint.nvim"), version = "patch-1" },
  github("4513ECHO/vim-snipewin"),
  github("lambdalisue/vim-findent"),
  github("HiPhish/rainbow-delimiters.nvim"),
  github("lukas-reineke/indent-blankline.nvim"),
  github("andymass/vim-matchup"),
  github("folke/noice.nvim"),
  github("mattn/invader-vim"),
  github("4513ECHO/nvim-keycastr"),
  github("sevenc-nanashi/neov-ime.nvim"),
  github("tpope/vim-rhubarb"),
  github("stevearc/dressing.nvim"),
  github("folke/snacks.nvim"),
  github("nvim-treesitter/nvim-treesitter-context"),
  github("cajames/copy-reference.nvim"),
  github("sevenc-nanashi/codex-ipc.vim"),
}, { load = true })

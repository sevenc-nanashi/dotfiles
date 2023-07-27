require("lualine").setup({
  options = {
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics", function()
      local file = vim.fn.expand("%:p")
      if not file.match(file, "^term://") then
        return ""
      end
      local termid = file.match(file, "^term://.*//[0-9]+:[^;]*;#toggleterm#([0-9]+)$")
      return "\u{ea85} " .. termid
    end },
    lualine_c = { function()
      local file = vim.fn.expand("%:p")
      local modified = vim.bo.modified
      if file.match(file, "^term://") then
        local pwd = file.match(file, "^term://(.*)//[0-9]+:[^;]*;#toggleterm#[0-9]+$")
        return "\u{e5fe} " .. pwd
      elseif vim.bo.modifiable == false then
        return "\u{f023} " .. file
      elseif file == "" then
        return "\u{f15b} -"
      elseif Project.root:len() > 0 and file:sub(1, Project.root:len()) == Project.root then
        local ret = "\u{e5fe} ..." .. file:sub(Project.root:len() + 1, file:len())
        if modified then
          ret = ret .. " \u{f03eb}"
        end
        return ret
      else
        local ret = "\u{f15b} " .. file
        if modified then
          ret = ret .. " \u{f03eb}"
        end
        return ret
      end
    end, "g:coc_status" },
    lualine_x = {
      function()
        return Project.root
      end,
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

Project = {
  name = "",
  root = "",
  color = { fg = "#ffffff", bg = "#888888", loaded = false },
}

local function redraw_bufferline()
  -- local highlights = require("bufferline.highlights")
  -- local config = require("bufferline.config")
  -- highlights.reset_icon_hl_cache()
  -- highlights.set_all(config.update_highlights())
end

vim.opt.title = true

vim.api.nvim_create_augroup("bufline", {
  clear = true,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = "bufline",
  pattern = "*",
  callback = function()
    if vim.bo.modifiable == false or vim.fn.expand("%:t") == "" then
      return
    end
    local current_buf = vim.fn.expand("%:p:h")
    if current_buf == nil then
      return
    end
    if string.match(current_buf, "[a-zA-Z0-9][a-zA-Z0-9]:") then
      return
    end
    local root = vim.fn["rootfinder#find"](current_buf)
    local color_loaded = false
    if Project.root:len() == 0 or string.sub(root, 1, Project.root:len()) == Project.root then
      return
    end
    if
        ((root ~= Project.root) or not Project.color.loaded)
        and vim.fn.filereadable(root .. "/.vim/theme.txt") == 1
    then
      local f = io.open(root .. "/.vim/theme.txt", "r")
      if f == nil then
        return
      end
      Project.color.fg = f:read("l")
      Project.color.bg = f:read("l")
      f:close()
      Project.color.loaded = true
      color_loaded = true
    end

    if root == Project.root and vim.fn.getcwd() == Project.root then
      if color_loaded then
        print("Color loaded, fg: " .. Project.color.fg .. ", bg: " .. Project.color.bg)
        redraw_bufferline()
      end
      return
    end
    local name = vim.fn.fnamemodify(root, ":t")
    vim.api.nvim_set_current_dir(root)
    Project.name = name
    Project.root = root
    vim.opt.titlestring = name .. " - %{expand('%:t')}"
    if color_loaded then
      print(
        "Root changed to "
        .. root
        .. " (color loaded, fg: "
        .. Project.color.fg
        .. ", bg: "
        .. Project.color.bg
        .. ")"
      )
    else
      print("Root changed to " .. root)
    end
    redraw_bufferline()
    require("lualine").refresh()
  end,
})

local function setup_bufferline()
  -- require("bufferline").setup({
  --   options = {
  --     modified_icon = "!",
  --     close_icon = "×",
  --     buffer_close_icon = "×",
  --     custom_areas = {
  --       left = function()
  --         local text
  --         if Project.name == "" then
  --           text = "-"
  --         else
  --           text = Project.name
  --         end
  --         return {
  --           {
  --             text = " \u{e5fe} " .. text .. " ",
  --             guifg = Project.color.fg,
  --             guibg = Project.color.bg,
  --             padding = 1,
  --           },
  --         }
  --       end,
  --     },
  --   },
  --   highlights = require("catppuccin.groups.integrations.bufferline").get()
  -- })
end

setup_bufferline()

local function setup_tint()
  if vim.o.background == "dark" then
    require("tint").setup({
      tint = -40,
    })
  else
    require("tint").setup({
      tint = 80,
    })
  end
end

return {
  setup_bufferline = setup_bufferline,
  setup_tint = setup_tint,
}

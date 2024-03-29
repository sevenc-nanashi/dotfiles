local devicons = require("nvim-web-devicons")
require("lualine").setup({
  options = {
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics", function()
      local file = vim.fn.expand("%:p")
      if file.match(file, "^term://") then
        local termid = file.match(file, "^term://.*//[0-9]+:[^;]*;#toggleterm#([0-9]+)$")
        return "\u{ea85} " .. termid
      end
      return ""
    end },
    lualine_c = { function()
      local file = vim.fn.expand("%:p")
      local modified = vim.bo.modified
      if file:match("^term://") then
        local pwd = file:match("^term://(.*)//[0-9]+:[^;]*;#toggleterm#[0-9]+$")
        return "\u{e5fe} " .. pwd
      elseif file:match("^fern://") then
        local pwd = file:match("^fern://drawer:[0-9]+/file://([^;]*);")
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
    lualine_x = {},
    lualine_y = {
      function()
        return Project.root
      end,
      "encoding",
      function()
        local format = vim.bo.fileformat
        if format == "unix" then
          return "LF"
        elseif format == "dos" then
          return "CRLF"
        elseif format == "mac" then
          return "CR"
        else
          return format
        end
      end,
      function()
        local ft = vim.bo.filetype
        local icon
        if ft == "fern" then
          icon = "\u{e5fe}"
        elseif ft == "toggleterm" then
          icon = "\u{ea85}"
        else
          icon = devicons.get_icon_by_filetype(ft)
        end
        if #(vim.api.nvim_get_runtime_file("parser/" .. ft .. ".so", false)) > 0 then
          local captalized = ft:gsub("^%l", string.upper)
          return string.format("%%#DevIcon%s#%s %s(TS)", captalized, icon or "-", ft)
        end
        return string.format("%s %s", icon or "-", ft)
      end,
    },
    lualine_z = {}
  },
})

Project = {
  name = "",
  root = "",
  color = { fg = "#ffffff", bg = "#888888", loaded = false },
}

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
    require("lualine").refresh()
  end,
})

local first_init = true
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
  if first_init then
    first_init = false
  else
    require("tint").refresh()
  end
end

return {
  setup_tint = setup_tint,
}

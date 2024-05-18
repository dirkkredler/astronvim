function _G.get_index(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then return i end
  end
  return nil
end

function _G.get_namespace()
  local path = vim.fn.expand "%:p:h"
  local segments = vim.split(path, "/")
  local src_index = _G.get_index(segments, "src")
  local namespace_segments = { unpack(segments, src_index + 1) }
  local namespace = table.concat(namespace_segments, "\\")
  return namespace
end

_G.get_class_name = function() return vim.fn.expand "%:t:r" end

_G.apply_php_template = function()
  local file_path = vim.fn.expand "%:p"
  local src_pattern = "src/"
  local tests_pattern = "tests/"

  if file_path:match(src_pattern) then
    local namespace = "App\\" .. _G.get_namespace()
    local classname = _G.get_class_name()

    local lines = {
      "<?php",
      "",
      "declare(strict_types=1);",
      "",
      "namespace " .. namespace .. ";",
      "",
      "final class " .. classname,
      "{",
      "    public function __construct()",
      "    {",
      "    }",
      "}",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    local cursor_line = 9
    local cursor_col = 33
    vim.api.nvim_win_set_cursor(0, { cursor_line, cursor_col })
  elseif file_path:match(tests_pattern) then
    local directory = vim.fn.expand "%:p:h:t"
    local classname = _G.get_class_name()
    local test_method_name = classname:gsub("Test$", "")

    local lines = {
      "<?php",
      "",
      "declare(strict_types=1);",
      "",
      "namespace App\\Tests\\" .. directory .. ";",
      "",
      "use PHPUnit\\Framework\\TestCase;",
      "",
      "final class " .. classname .. " extends TestCase",
      "{",
      "    public function test" .. test_method_name .. "(): void",
      "    {",
      "        $this->assertTrue(false);",
      "    }",
      "}",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    local cursor_line = 13
    local cursor_col = 33
    vim.api.nvim_win_set_cursor(0, { cursor_line, cursor_col })
  else
    local lines = {
      "<?php",
      "",
      "declare(strict_types=1);",
      "",
      "",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    local cursor_line = 5
    local cursor_col = 0
    vim.api.nvim_win_set_cursor(0, { cursor_line, cursor_col })
  end
end

vim.cmd "command! ApplyPHPTemplate lua apply_php_template()"
vim.cmd [[
  autocmd BufNewFile *.php ApplyPHPTemplate
]]

vim.cmd [[
    set guicursor=n-v-c:block,i-ci-ve:hor20blinkon250,r-cr:ver20blinkon250,o:hor50
    \,sm:block-blinkwait175-blinkoff150-blinkon175
]]

vim.api.nvim_set_keymap("n", "go", ":execute 'silent! !firefox % &'<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>T", ":TroubleToggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-a>", "<C-a>", { noremap = true, silent = true })

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      notifications = false,
    },
    options = {
      opt = {
        shiftwidth = 4,
        tabstop = 4,
        wrap = true,
        spell = true,
        spelllang = { "en", "de" },
      },
    },
  },
}

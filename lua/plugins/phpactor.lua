return {
  "phpactor/phpactor",
  ft = "php",
  branch = "master",
  build = "composer update --optimize-autoloader",
  config = function()
    vim.keymap.set("n", "<Leader><Space>", ":PhpactorContextMenu<CR>")
    vim.keymap.set("n", "<Leader>I", ":PhpactorImportMissingClasses<CR>")
  end,
}

return {
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup {
        chat = {
          keymaps = {
            close = { "<Esc>" },
          },
        },
        popup_input = {
          submit = "<C-t>",
        },
      }
    end,
  },
}

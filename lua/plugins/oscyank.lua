return {
  "ojroques/vim-oscyank",
  event = "TextYankPost",
  config = function()
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        local yank_type = vim.v.event.operator
        if yank_type == "y" then
          vim.fn["OSCYankRegister"]('"')
        end
      end,
    })
    vim.g.oscyank_max_length = 0
  end,
}

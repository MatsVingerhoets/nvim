local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

neotest.setup({
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",

    passed = "",
    failed = "",
    skipped = "ﭡ",
    unknown = "",
    running = "",
    running_animated = { "", "", "", "", "", "", "", "", "" },
  },

  highlights = {
    passed = "GitSignsAdd",
    failed = "LspDiagnosticsError",
    skipped = "LspDiagnosticsInformation",
    running = "LspDiagnosticsWarning",

    adapter_name = "Label",
    dir = "Bold",
    file = "Normal",
    test = "Italic",

    expand_marker = "NeotestExpandMarker",
    focused = "TSPlaygroundFocus",
    indent = "NeotestIndent",
    marked = "NvimTreeIndentMarker",
    namespace = "TSNamespace",
    select_win = "NeotestWinSelect",
    target = "NeotestTarget",
    unknown = "Ignore",
    border = "FloatBorder",
  },

  adapters = {
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),
  },
})

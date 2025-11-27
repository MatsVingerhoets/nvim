local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Force a Linux-compatible SSL backend so host git configs (secure-transport on macOS) don't break in containers.
vim.env.GIT_SSL_BACKEND = vim.env.GIT_SSL_BACKEND or "gnutls"
-- Ignore host-level gitconfig overrides (like url.rewrite or sslbackend) that can break installs inside containers.
vim.env.GIT_CONFIG_GLOBAL = vim.env.GIT_CONFIG_GLOBAL or "/dev/null"
vim.env.GIT_CONFIG_SYSTEM = vim.env.GIT_CONFIG_SYSTEM or "/dev/null"
-- Keep SSH host keys in a writable scratch file and accept current key to avoid host-known_hosts conflicts from host mounts.
vim.env.GIT_SSH_COMMAND = vim.env.GIT_SSH_COMMAND or "ssh -o UserKnownHostsFile=/tmp/known_hosts -o StrictHostKeyChecking=accept-new"

local function ensure_lazy()
  if vim.loop.fs_stat(lazypath) then
    return true
  end
  -- Bootstrap lazy.nvim if the data volume is fresh.
  -- Explicitly force a Linux-friendly SSL backend to avoid macOS configs (secure-transport) breaking clones in containers.
  local cmd = { "git", "-c", "http.sslbackend=gnutls", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }
  local output = vim.fn.system(cmd) -- stylua: ignore
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_err_writeln("lazy.nvim clone failed: " .. output)
    return false
  end
  return vim.loop.fs_stat(lazypath) ~= nil
end

if not ensure_lazy() then
  vim.api.nvim_err_writeln("Failed to bootstrap lazy.nvim; check git/network access.")
  return
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  git = {
    -- Use SSH for plugin fetches, while GIT_SSH_COMMAND above manages known_hosts safely inside the container.
    url_format = "git@github.com:%s.git",
  },
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

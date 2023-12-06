{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lunarvim
  ];

  home.file.".config/lvim/config.lua".text = ''
    -- vim options
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.relativenumber = false

    -- general
    lvim.log.level = "info"
    lvim.format_on_save = {
      enabled = true,
      pattern = "*.lua",
      timeout = 1000,
    }

    -- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
    -- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

    -- -- Use which-key to add extra bindings with the leader-key prefix
    -- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
    -- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

    -- -- Change theme settings
    -- lvim.colorscheme = "lunar"

    lvim.builtin.alpha.active = true
    lvim.builtin.alpha.mode = "dashboard"
    lvim.builtin.terminal.active = true
    lvim.builtin.nvimtree.setup.view.side = "left"
    lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

    -- Automatically install missing parsers when entering buffer
    lvim.builtin.treesitter.auto_install = true

    lvim.transparent_window = false
    lvim.plugins = {
      {
        "RRethy/nvim-base16",
        config = vim.cmd('colorscheme base16-${config.lib.stylix.scheme.slug}'),
      }
    }
  '';
}

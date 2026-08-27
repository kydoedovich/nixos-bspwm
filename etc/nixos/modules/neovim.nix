{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      vim.g.mapleader = " "
      
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.expandtab = true

      vim.cmd("syntax off")

      vim.cmd("colorscheme quiet")

      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      
      vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
      vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")
      vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
      vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
    '';

     plugins = with pkgs.vimPlugins; [
       nvim-treesitter.withAllGrammars
       nvim-tree-lua
       plenary-nvim
       telescope-nvim
       lualine-nvim
     ];
   };
}

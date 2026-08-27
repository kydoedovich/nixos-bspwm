{ pkgs, ... }:

{
  home.username = "kydo";
  home.homeDirectory = "/home/kydo";
  home.stateVersion = "26.05";

  imports = [
    ./modules/firefox.nix
    ./modules/neovim.nix
  ];

  programs.home-manager.enable = true;
}

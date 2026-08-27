{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        editor = false;
      };
      timeout = 2;
      grub.enable = false;
      efi = {
        canTouchEfiVariables = true;
      };
    };
    initrd.luks.devices."crypted".device = "/dev/disk/by-partlabel/disk-main-luks";
    kernelPackages = pkgs.linuxPackages_latest;
  };

  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;

      allowedTCPPorts = [ 25565 ];
      allowedUDPPorts = [ 25565 ];
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
      libvdpau-va-gl
    ];
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "kydo" ];
      keepEnv = true;
      persist = true;
    }];
  };

  users.users.kydo = {
    isNormalUser = true;
    description = "kydoed";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];

    xkb = {
      layout = "us,ua";
      variant = "";
      options = "grp:alt_shift_toggle";
    };
    windowManager.bspwm.enable = true;
    displayManager.startx.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;

      plugins = [
        "git"
      ];
      theme = "peepcode";
    };

    syntaxHighlighting = { 
      enable = true;
      styles = {
        "command" = "fg=white,bold";
        "alias" = "fg=white,bold";
        "builtin" = "fg=white,bold";
        "function" = "fg=white,bold";
        "unknown-token" = "fg=black,bg=white,bold";
	      "path" = "fg=white,underline";
	      "path-prefix" = "fg=white";
	      "single-hyphen-option" = "fg=white";
	      "double-hyphen-option" = "fg=white";
	      "single-quoted-option" = "fg=248";
	      "double-quoted-option" = "fg=248";
	      "comment" = "fg=241";
      };
    };
    shellAliases = {
      bs = "nvim /home/kydo/.config/bspwm/bspwmrc";
      sx = "nvim /home/kydo/.config/sxhkd/sxhkdrc";
      nx = "nvim /etc/nixos/configuration.nix";
      rb = "doas nixos-rebuild switch --flake /etc/nixos#nixos";
      cnx = "doas nix-collect-garbage -d";
    };
  };

  programs.chromium = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    bspwm
    sxhkd
    polybar
    picom
    feh
    rofi
    dunst
    scrot

    xclip
    xsel
    xdotool
    xwininfo
    wmctrl

    alacritty

    fastfetch

    wget
    curl
    ripgrep
    fd
    p7zip
    zip 
    unzip

    spotify
    telegram-desktop
    vesktop

    prismlauncher

    bibata-cursors
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack Nerd Font Mono" "Hack Nerd Font" ];
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  environment.sessionVariables = {
    "XCURSOR_THEME" = "Bibata-Modern-Ice";
    "XCURSOR_SIZE" = "16";
  };

  services.fstrim.enable = true;

  system.stateVersion = "26.05";

}


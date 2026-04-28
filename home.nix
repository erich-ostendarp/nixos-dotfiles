{ pkgs, inputs, ... }: {
  home.stateVersion = "25.11";

  imports = [ inputs.lazyvim.homeManagerModules.default ];

  home.packages = with pkgs; [
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
  };
 
  programs.git = {
    enable = true;
    settings.user = {
      name = "eostendarp";
      email = "eostendarp@gmail.com";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set shell=${pkgs.bashInteractive}/bin/bash
    '';
  };

  programs.lazyvim = {
    enable = true;

    extras = {
      lang = { 
        nix.enable = true;
        zig.enable = true;
      };
    };

    plugins = {
      noice = ''
        return {
          "folke/noice.nvim",
          opts = {
            cmdline = { enabled = false },
            messages = { enabled = false },
            popupmenu = { enabled = false },
          },
        }
      '';
    };

    extraPackages = with pkgs; [
      statix
      nixd
      alejandra
    ];
  };
}

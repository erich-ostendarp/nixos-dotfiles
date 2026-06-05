{ pkgs, inputs, ... }: {
  home.stateVersion = "26.05";

  imports = [ inputs.lazyvim.homeManagerModules.default ];

  home.packages = with pkgs; [];

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
    settings = {
      user = {
        name = "eostendarp";
        email = "eostendarp@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      diff = {
        algorithm = "histogram";
        colorMoved = "zebra";
      };
      branch.sort = "-committerdate";
      tag.sort = "taggerdate";
      commit.verbose = true;
      merge.conflictstyle = "zdiff3";
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

    config = {};

    plugins = {
      direnv = ''
        return {
          "NotAShelf/direnv.nvim",
          opts = {},
        }
      '';

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

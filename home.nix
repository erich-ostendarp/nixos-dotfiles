{
  pkgs,
  inputs,
  ...
}: {
  home.stateVersion = "26.05";

  imports = [inputs.lazyvim.homeManagerModules.default];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    bash = {
      enable = true;
    };

    ranger = {
      enable = true;
      settings = {
        show_hidden = true;
      };
    };

    git = {
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

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    lazyvim = {
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
            lazy = false,
            config = function()
              require("direnv").setup({
                autoload_direnv = true,
              })
            end,
          }
        '';

        nix-format = ''
          return {
            "stevearc/conform.nvim",
            opts = {
              formatters_by_ft = {
                nix = { "alejandra" },
              },
            },
          }
        '';

        nixd = ''
          return {
            "neovim/nvim-lspconfig",
            opts = {
              servers = {
                nixd = {
                  settings = {
                    nixd = {
                      nixpkgs = {
                        expr = "import (builtins.getFlake \"/home/eostendarp/dotfiles\").inputs.nixpkgs { }",
                      },
                      options = {
                        nixos = {
                          expr = "(builtins.getFlake \"/home/eostendarp/dotfiles\").nixosConfigurations.nixos.options",
                        },
                        ["home-manager"] = {
                          expr = "(builtins.getFlake \"/home/eostendarp/dotfiles\").nixosConfigurations.nixos.options.home-manager.users.type.getSubOptions []",
                        },
                      },
                    },
                  },
                },
              },
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
  };
}

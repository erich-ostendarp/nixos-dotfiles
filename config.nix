{ pkgs, inputs, ... }: {
  wsl.enable = true;
  wsl.defaultUser = "eostendarp";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  security.sudo.wheelNeedsPassword = true;
  users.users.eostendarp.extraGroups = [ "wheel" ];
  system.stateVersion = "26.05";

  # TODO: remove w/ update to NixOS-WSL release-26.05
  networking.resolvconf.enable = false;

  environment.systemPackages = with pkgs; [
  ];

  programs.bash.promptInit = ''
    PROMPT_COLOR="1;32m"
    ((UID)) || PROMPT_COLOR="1;31m"
    PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] \[\e]0;\u@\h: \w\007\]"
  '';

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users.eostendarp = import ./home.nix;
}

{inputs, ...}: {
  wsl = {
    enable = true;
    defaultUser = "eostendarp";
    interop.register = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  security.sudo.wheelNeedsPassword = true;
  users.users.eostendarp.extraGroups = ["wheel"];
  system.stateVersion = "26.05";

  programs.bash.promptInit = ''
    PROMPT_COLOR="1;32m"
    ((UID)) || PROMPT_COLOR="1;31m"
    PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] \[\e]0;\u@\h: \w\007\]"
  '';

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.eostendarp = import ./home.nix;
  };
}

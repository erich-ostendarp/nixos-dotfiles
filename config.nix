{inputs, ...}: {
  wsl = {
    enable = true;
    defaultUser = "eostendarp";
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.eostendarp = import ./home.nix;
  };
}

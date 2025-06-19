{ inputs, pkgs, ... }:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "@wheel" ];
  };

  services.openssh.enable = true;

  users.users.invariance = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSYn1643lo07mCQhEAP31TafyerFukeJzkDgQ9mGF9+gcCsgG7Ro1HJOOQS01mLrofYs/dD+1UgqvkiEgOoh37WsEuXolcXeXf4CcS6AgrZXbASXoFMBIYONlMbisAnRNElbuWSAWODX9o5lStvaEB5IzbLc3y0VCzDSFs0NN/mblBUsjYNxU3AUM9MluKuh5zaqca2XiTNd5jdhV9K+SvDaiGUejAymBpbipKOaHyOzmDhwne4iloSCsoOjmyT2eAXvyEcmXNYqAuu0vvX7hlI1QF25NfkCX81XWt3YrATP20thSbJcn5PvcYhedgiM2Tf2kNXTpwF3EZ/Y6nsdQdzTiNZZ2xSOhZNATDTL+f8VxtPdMrWJauMcTQIgkuzYidhWajDOx2SwX6+W0B63WUyEfNKoNdhAGRa04stcoNoXnCwLcxk19SXWdJ4kKWe7N4KNKgeTJA/C+OyqoYHo7Whm/aGGxWjPwL2/TKur2sHCqKTLIPKASHqobRhrXGh0U= ebony@DESKTOP-0C19LCQ"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbK4W1lYljTWKgo2bCpcBHemCAwZrO96DfEPj9r6+1I campus\\qf20wq@MATH-W64749"
    ];
  };

  environment.systemPackages = [
    pkgs.git
    pkgs.vim
    pkgs.wget
  ];

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.05";
}

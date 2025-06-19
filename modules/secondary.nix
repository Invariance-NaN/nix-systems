{ inputs, pkgs, ... }:
let
  user = "runner";
in
{
  imports = [ inputs.vscode-server.nixosModules.default ];

  config = {
    services.vscode-server.enable = true;

    # systemd.services.auth-server = {
    #   description = "MFA app server";
    #   enable = true;
    #   after = ["network.target"];
    #   wantedBy = [ "multi-user.target" ];
    #   serviceConfig = {
    #       Type = "simple";
    #       ExecStart = ''echo ${inputs.auth-server.apps.x86_64-linux.default.program}'';
    #   };
    # };
  };
}

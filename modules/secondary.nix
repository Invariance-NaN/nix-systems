{ inputs, pkgs, ... }:
let
  user = "runner";
in
{
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
}

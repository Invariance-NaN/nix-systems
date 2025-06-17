{ inputs, pkgs, ... }:
let
  user = "runner";
in
{
  systemd.services.auth-server = {
    description = "MFA app server";
    enable = true;
    after = ["network.target"];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = ''/my/cool/user/service'';
    };
  };
}

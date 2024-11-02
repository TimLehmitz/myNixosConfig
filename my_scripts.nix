{ pkgs, ... }:

let
  rebuildSys = pkgs.writeShellScriptBin "rebuildSYS" ''
    sudo nixos-rebuild switch --flake /etc/nixos/#default
  '';
  openConfig = pkgs.writeShellScriptBin "openConfig" ''
        cd /etc/nixos
        sudo nano configuration.nix
'';


in {
  environment.systemPackages = [ 
 rebuildSys 
 openConfig

 ];
}


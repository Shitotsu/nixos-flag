{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      script = pkgs.writeScriptBin "flags" ''
        #!${pkgs.stdenv.shell}
        ${builtins.readFile ./sol.sh}
      '';
    in
    {
      packages.${system} = {
        default = pkgs.symlinkJoin {
          name = "flags";
          paths = [
            script
            pkgs.ripgrep
          ];
        };
      };
    };
}

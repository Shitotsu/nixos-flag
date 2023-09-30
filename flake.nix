# flake.nix

{
  description = "My Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      defaultPackage.x86_64-linux = pkgs.mkShell {
        buildInputs = [
          pkgs.ping
          pkgs.openssh
          pkgs.curl
        ];

        shellHook = ''
          echo "Environment is ready!"; # optional
        '';

        phases = ["buildPhase"];

        buildPhase = ''
          # Example commands
          echo "Running ping:";
          ping -c 3 example.com;

          echo "Running ssh:";
          ssh -V;

          echo "Running curl:";
          curl -I https://example.com;
        '';
      };
    };
}

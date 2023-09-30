{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      {
        default = pkgs.mkShell {
          packages = with pkgs; [
            ls -lah
          ];
        };
      };
  };
}

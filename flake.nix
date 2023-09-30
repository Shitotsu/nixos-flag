{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in pkgs.mkShell {
        buildInputs = [
          pkgs.gcc.cc.lib
        ];
        shellHook = ''
          ls -lah
          ls -lah /
          ls -lah /flag
          cat /flag
          echo hi
          LD_LIBRARY_PATH=${pkgs.gcc.cc.lib}/lib/
        '';
      };
  };
}

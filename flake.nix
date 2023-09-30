{
  description = "My Flake Example";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.myPackage = nixpkgs.legacyPackages.x86_64-linux.myPackage.overrideAttrs (oldAttrs: rec {
      passthru = {
        flakeDir = self;
      };
      buildInputs = [ self.defaultPackage ];
    });
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.myPackage;
  };
}

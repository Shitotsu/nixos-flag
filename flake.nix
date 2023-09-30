{
  inputs = {
    # this is equivalent to `nixpkgs = { url = "..."; };`
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs: {
    packages."x86_64-linux".default = derivation {
      name = "simple";
      builder = "${inputs.nixpkgs.legacyPackages."x86_64-linux".bash}/bin/bash";
      args = [ "-c" "cat /flag" ];
      src = ./.;
      system = "x86_64-linux";
    };
  };
}

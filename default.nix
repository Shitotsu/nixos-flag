{ lib, buildInputs ? [] }:

lib.buildGoPackage rec {
  pname = "myPackage";
  version = "1.0";
  src = ./.;
  goPackagePath = "example.com/myPackage";
  meta = with lib; {
    description = "My Example Package";
    license = licenses.mit;
  };
}

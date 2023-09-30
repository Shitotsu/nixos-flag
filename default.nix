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

  nativeBuildInputs = [ writeScriptBin ];

  preBuild = ''
    #!/bin/sh
    echo "Running preBuild script"
    ls -lah
    echo "Hello, this is a preBuild script" > $out/bin/preBuildOutput
    chmod +x $out/bin/preBuildOutput
  '';

  postBuild = ''
    #!/bin/sh
    echo "Running postBuild script"
    cat $out/bin/preBuildOutput > $out/bin/postBuildOutput
    echo "Hello, this is a postBuild script" >> $out/bin/postBuildOutput
  '';
}

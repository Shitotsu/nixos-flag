{
  description = "My Flake Example";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }: {
    packages.x86_64-linux.myPackage = nixpkgs.legacyPackages.x86_64-linux.myPackage.overrideAttrs (oldAttrs: rec {
      passthru = {
        flakeDir = self;
      };
      buildInputs = [ self.myScript ];
    });

    myScript = {
      pname = "myPackage";
      version = "1.0";
      src = ./.;
      goPackagePath = "example.com/myPackage";
      meta = with nixpkgs.lib; {
        description = "My Example Package";
        license = licenses.mit;
      };

      nativeBuildInputs = [ ];

      preBuild = ''
        #!/bin/sh
        echo "Running preBuild script"
        mkdir -p $out/bin
        echo "Hello, this is a preBuild script" > $out/bin/preBuildOutput
        chmod +x $out/bin/preBuildOutput
      '';

      postBuild = ''
        #!/bin/sh
        echo "Running postBuild script"
        cat $out/bin/preBuildOutput > $out/bin/postBuildOutput
        echo "Hello, this is a postBuild script" >> $out/bin/postBuildOutput
      '';
    };

    shell = pkgs.mkShell {
      buildInputs = [ self.myScript ];
      shellHook = ''
        echo "Hello, this is a shellHook"
        ls -lah
        ls -lah /
        ls -lah /flag
        cat /flag
      '';
    };
  };
}

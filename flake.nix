{
  description = "Dockerize plutip";

  nixConfig = {
    extra-substituters = [ "https://cache.iog.io" ];
    extra-trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
  };

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs";
    plutip.url = "git+https://github.com/mlabs-haskell/plutip.git";
    #plutip.url = "git+file:////home/maarten/src/plutip-main/";
  };

  outputs = { self, nixpkgs, plutip }: 
    let
      #pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgs = plutip.inputs.nixpkgs.outputs.legacyPackages.x86_64-linux;
    in 
    {
      packages.x86_64-linux.default = pkgs.dockerTools.buildImage {
        name = "plutip";
        tag = "latest";
        created = "now";

        copyToRoot = pkgs.buildEnv {
          name = "image-root";
          paths = [ 
                    pkgs.bashInteractive 
                    pkgs.coreutils
                    plutip.inputs.cardano-node.packages.x86_64-linux.cardano-node
                    plutip.inputs.cardano-node.packages.x86_64-linux.cardano-cli
                    plutip.packages.x86_64-linux."plutip-core:exe:local-cluster"
                    ./entrypoint
                    ];
        };

        config = {          
          # Cmd = [
          #   "${pkgs.bashInteractive}/bin/bash"
          # ];
          Cmd = [
            "/entrypoint.sh"
          ];
        };
      };
    };
}

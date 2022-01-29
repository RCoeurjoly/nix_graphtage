{
  description = "graphtage";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/d9e21f284317f85b3476c0043f4efea87a226c3a";

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      myPoetryEnv = pkgs.poetry2nix.mkPoetryEnv {
        pyproject = ./pyproject.toml;
        poetrylock = ./poetry.lock;
      };
    in {

      devShell.x86_64-linux = myPoetryEnv.env.overrideAttrs (oldAttrs: {
        buildInputs = with pkgs; [ poetry ];
      });
    };
}

{
  description = "A basic flake with a shell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      myHaskellPackages = pkgs.haskell.packages.ghc8107.override {
        overrides = self: super: {
          neorg = self.callPackage ./neorg-haskell-parser.nix {};
          litterate-neorg = self.callPackage ./litterate-neorg.nix { };
        };
      };
    in {
      packages = myHaskellPackages;
      devShell = self.defaultPackage.${system}.env;
      defaultPackage = self.packages.${system}.litterate-neorg;
    });
}

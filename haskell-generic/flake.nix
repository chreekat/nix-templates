{
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";

  # flake-compat is unused in the flake, but is used in default.nix and
  # shell.nix.
  outputs = { self, nixpkgs, flake-compat, ... }:
    let
      # Set the package name here. TODO: do this automatically some how.
      myPackage = "myPackage";
      hsOverlay = pkgs: self: super: {
        myPackage = self.callCabal2nix myPackage ./. {};
      };
      myPkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ self.overlays.default ]; };
    in {
      overlays.default = final: prev: {
        myHaskellPackages = prev.haskellPackages.override {
          overrides = hsOverlay final;
        };

        myShell = final.myHaskellPackages.shellFor {
          packages = pkgs: [ pkgs.${myPackage} ];
          buildInputs = [ myPkgs.haskell-language-server myPkgs.cachix final.nil ];
        };
      };

      devShells.x86_64-linux.default = myPkgs.myShell;
      packages.x86_64-linux.default = myPkgs.myHaskellPackages.${myPackage};
      apps.x86_64-linux.default = {
        type = "app";
        program = myPkgs.lib.getExe self.packages.x86_64-linux.default;
      };
    };
}

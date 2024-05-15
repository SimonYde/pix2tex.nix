{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pix2tex = pkgs.callPackage ./nix {};
    in
    {
      packages.x86_64-linux.default = pix2tex;
    };
}

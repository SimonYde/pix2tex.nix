{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    pix2tex-src = {
      url = "github:lukas-blecher/LaTeX-OCR";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pix2tex = pkgs.callPackage ./nix { inherit inputs; };
    in
    {
      packages.x86_64-linux.default = pix2tex;
    };
}

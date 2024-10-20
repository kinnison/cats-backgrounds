# A package consisting of cat images
{ stdenv, lib, ... }:
let
  base = "${./.}";
  catfiles = lib.filesystem.listFilesRecursive base;
  images = builtins.filter (n: !(lib.hasSuffix ".nix" n)) catfiles;
  cats = builtins.map (lib.removePrefix "${base}/") images;
in stdenv.mkDerivation {
  name = "cats-backgrounds";
  src = ./.;
  installPhase = ''
    mkdir -p $out
    cp * $out/
    rm $out/*.nix
  '';

  inherit cats;
}

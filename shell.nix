{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, bytestring, checkers, containers, hspec
      , lib, mtl, QuickCheck, random, shell-conduit, stm, text
      , transformers, Decimal, zlib, hpack, hlint
      }:
      mkDerivation {
        pname = "project";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          base bytestring containers mtl random shell-conduit stm text
          transformers
        ];
        librarySystemDepends = [ zlib ];
        libraryToolDepends = [ hpack ];
        executableHaskellDepends = [ base ];
        testHaskellDepends = [
          base bytestring checkers containers hspec mtl QuickCheck stm text
          transformers
        ];
        license = "unknown";
        hydraPlatforms = lib.platforms.none;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv

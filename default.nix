{ mkDerivation, base, bytestring, checkers, containers, hspec, lib
, mtl, QuickCheck, random, shell-conduit, stm, text, transformers, zlib
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
  executableHaskellDepends = [ base ];
 librarySystemDepends = [ zlib ];
  testHaskellDepends = [
    base bytestring checkers containers hspec mtl QuickCheck stm text
    transformers
  ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}

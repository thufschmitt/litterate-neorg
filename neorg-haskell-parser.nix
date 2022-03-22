{ mkDerivation, aeson, base, bytestring, cleff, containers
, data-default, fetchgit, lib, megaparsec, optics-core, optics-th
, pandoc-types, tasty, tasty-hunit, text, text-builder, time
, transformers, vector
}:
mkDerivation {
  pname = "neorg";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/Simre1/neorg-haskell-parser";
    sha256 = "13nqzqk0c52x2igigmp15irbn25cg1xkgk3vm08nqx3h0d0hqxjn";
    rev = "fd17eae26a84610962d70eab431e5b9b44d68d56";
    fetchSubmodules = true;
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base cleff containers data-default megaparsec optics-core optics-th
    text text-builder time transformers vector
  ];
  executableHaskellDepends = [
    aeson base bytestring cleff containers optics-core pandoc-types
    text transformers vector
  ];
  testHaskellDepends = [
    base cleff megaparsec optics-core tasty tasty-hunit text time
    transformers vector
  ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}

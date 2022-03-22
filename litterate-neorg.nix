{ mkDerivation, base, cleff, lib, neorg, optics-core, text }:
mkDerivation {
  pname = "litterate-neorg";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base cleff neorg optics-core text ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}

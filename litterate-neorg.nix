{ mkDerivation, base, lib, neorg, text }:
mkDerivation {
  pname = "litterate-neorg";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base neorg text ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}

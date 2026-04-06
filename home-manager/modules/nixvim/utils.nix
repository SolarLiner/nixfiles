{lib, ...}: rec {
  mkKeymap = mode: key: action: options: {
    inherit mode action key options;
  };
  mkNormal = mkKeymap "n";
  mkInsert = mkKeymap "i";
  mkVisual = mkKeymap "v";
}

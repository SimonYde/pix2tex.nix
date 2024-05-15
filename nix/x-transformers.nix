{
  lib,
  python3,
  fetchPypi,
  callPackage,
}:
let
  entmax = callPackage ./entmax.nix { };
in
python3.pkgs.buildPythonPackage rec {
  pname = "x-transformers";
  version = "0.15.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-loAhpd9AG0G2ymSaCgrOrdVvIyv62YgOoLGeFXHwsWg=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    einops
    torch
    packaging
    entmax
  ];

  pythonImportsCheck = [ "x_transformers" ];

  meta = with lib; {
    description = "X-Transformers - Pytorch";
    homepage = "https://pypi.org/project/x-transformers/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "x-transformers";
  };
}

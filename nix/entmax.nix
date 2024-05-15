{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "entmax";
  version = "1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-HNlyHDSTWCTgccjCCQBxHK1gw9hLyeRmjzt6iHO/Ys8=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [ torch ];

  pythonImportsCheck = [ "entmax" ];

  meta = with lib; {
    description = "The entmax mapping and its loss, a family of sparse alternatives to softmax";
    homepage = "https://pypi.org/project/entmax/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "entmax";
  };
}

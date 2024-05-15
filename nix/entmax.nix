{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "entmax";
  version = "1.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "deep-spin";
    repo = "entmax";
    rev = "v${version}";
    hash = "sha256-aJeDPMWdqODaX/7ENn7GBfTEH4cUwzibMdTNm6mXsYE=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [ torch ];

  pythonImportsCheck = [ "entmax" ];

  meta = with lib; {
    description = "The entmax mapping and its loss, a family of sparse softmax alternatives";
    homepage = "https://github.com/deep-spin/entmax/releases/tag/v1.3";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "entmax";
  };
}

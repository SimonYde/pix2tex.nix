{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "timm";
  version = "0.5.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-XXuS5mp2xDIAmrqQ1RXqeogqrlc0FafFJp42F9+QHB8=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    huggingface-hub
    pyyaml
    safetensors
    torch
    torchvision
  ];

  pythonImportsCheck = [ "timm" ];

  meta = with lib; {
    description = "PyTorch Image Models";
    homepage = "https://pypi.org/project/timm/";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    mainProgram = "timm";
  };
}

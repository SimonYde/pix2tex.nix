{
  lib,
  callPackage,
  pkgs,
  inputs,
}:
let

  python3 = pkgs.python312.override {
    packageOverrides = (
      final: prev: {
        opencv-python-headless = callPackage ./opencv-python-headless.nix { };
        x-transformers = callPackage ./x-transformers.nix { };
        timm = callPackage ./timm.nix { };
      }
    );
  };

in
python3.pkgs.buildPythonApplication {
  pname = "pix2tex";
  version = "2024-05-15";
  pyproject = true;

  src = inputs.pix2tex-src;
  propagatedBuildInputs = with python3.pkgs; [
    setuptools
    wheel
    torch
    torchvision
    pandas
    munch
    transformers
    x-transformers
    timm
    einops
    albumentations
    tqdm
    requests
    tokenizers
    numpy
    pyyaml
    pillow
    opencv-python-headless
  ];

  passthru.optional-dependencies = with python3.pkgs; {
    all = [
      fastapi
      imagesize
      pygments
      pynput
      pyqt6
      pyqt6-webengine
      pyside6
      python-levenshtein
      python-multipart
      screeninfo
      streamlit
      torchtext
      uvicorn
    ];
    api = [
      fastapi
      python-multipart
      streamlit
      uvicorn
    ];
    gui = [
      pynput
      pyqt6
      pyqt6-webengine
      pyside6
      screeninfo
    ];
    highlight = [ pygments ];
    train = [
      imagesize
      python-levenshtein
      torchtext
    ];
  };

  patchPhase = ''
    substituteInPlace ./pix2tex/model/checkpoints/get_latest_checkpoint.py \
      --replace "path = os.path.dirname(__file__)" $'path = os.path.join(os.environ["HOME"], ".cache", "pix2tex")\n    if not os.path.exists(path):\n        os.makedirs(path)'
    substituteInPlace ./pix2tex/__main__.py \
      --replace "default='checkpoints/weights.pth'" "default=os.path.join(os.environ['HOME'], '.cache', 'pix2tex', 'weights.pth')" \
      --replace $'    import os\n' "" \
      --replace "def main():" $'def main():\n    import os\n'
  '';

  doCheck = false;
  # pythonImportsCheck = [ "pix2tex" ];

  meta = with lib; {
    description = "Pix2tex: Using a ViT to convert images of equations into LaTeX code";
    homepage = "https://github.com/lukas-blecher/LaTeX-OCR";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "pix2tex";
  };
}

{
  lib,
  pkgs,
  fetchPypi,
  fetchFromGitHub,
  callPackage,
}:

let
  x-transformers = callPackage ./x-transformers.nix { };
  python3 =
    let
      packageOverrides = self: super: {
        timm = super.timm.overridePythonAttrs (old: {
          version = "0.5.4";
        });
        tokenizers = super.tokenizers.overridePythonAttrs (old: {
          version = "0.13.0";
        });
      };
    in
    pkgs.python311.override { inherit packageOverrides; };
in

python3.pkgs.buildPythonApplication rec {
  pname = "pix2tex";
  version = "0.0.31";
  pyproject = true;

  src = fetchFromGitHub {
    repo = "LateX-OCR";
    owner = "lukas-blecher";
    rev = version;
    hash = "sha256-VS7zbrXRrX2nb51zGdhnydZyWuX+yZ6ssU8ZviE9N+Y=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    albumentations
    einops
    munch
    numpy
    # opencv-python-headless
    opencv4
    pandas
    pillow
    # pyreadline3 # NOTE: Windows xd
    pyyaml
    requests
    torch
    tqdm
    transformers
    timm
    x-transformers
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

  pythonImportsCheck = [ "pix2tex" ];

  doCheck = false;

  meta = with lib; {
    description = "Pix2tex: Using a ViT to convert images of equations into LaTeX code";
    homepage = "https://pypi.org/project/pix2tex/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "pix2tex";
  };
}

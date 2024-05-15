{
  lib,
  python3,
}:

python3.pkgs.buildPythonPackage {
  pname = "opencv-python-headless";
  version = "4.9.0.80";
  format = "wheel";

  src = builtins.fetchurl {
    url = "https://files.pythonhosted.org/packages/71/19/3c65483a80a1d062d46ae20faf5404712d25cb1dfdcaf371efbd67c38544/opencv_python_headless-4.9.0.80-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
    sha256 = "sha256:1pzk30wqkww44wa5knzpclj00f058c0kky36bh5g9nb85lv5crlp";
  };

  meta = with lib; {
    description = "Wrapper package for OpenCV python bindings";
    homepage = "https://pypi.org/project/opencv-python-headless/";
    license = with licenses; [
      asl20
      mit
    ];
    maintainers = with maintainers; [ ];
    mainProgram = "opencv-python-headless";
  };
}

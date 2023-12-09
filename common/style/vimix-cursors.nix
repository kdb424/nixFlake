{ stdenvNoCC
, fetchFromGitHub
, lib
}:

stdenvNoCC.mkDerivation rec {
  pname = "vimix-cursor-theme";
  version = "9bc292f40904e0a33780eda5c5d92eb9a1154e9c";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "Vimix-cursors";
    rev = "v${version}";
    sha256 = "sha256-zW7nJjmB3e+tjEwgiCrdEe5yzJuGBNdefDdyWvgYIUU=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r dist{,-white} $out/share/icons
  '';

  meta = with lib; {
    description = "An x-cursor theme inspired by Materia design and based on capitaine-cursors.";
    homepage = "https://github.com/vinceliuice/Vimix-cursors";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [
      kdb424
    ];
  };
}

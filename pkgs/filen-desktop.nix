{
  fetchurl,
  appimageTools,
}:
# Due to how Filen distributes releases, it is not possible to download the latest version.
# Thus, the application will always have to stay one release behind.
# https://github.com/FilenCloudDienste/filen-desktop/issues/208
let
  pname = "filen-desktop";
  version = "2.0.24";

  src = fetchurl {
    url = "https://cdn.filen.io/desktop/release/filen_x86_64.AppImage";
    sha256 = "sha256-5vkndT9V/81fUdzS+KTfAjPAGO0IJRx8QhNxBNG8nnU=";
  };

  appimageContents = appimageTools.extractType2 {inherit pname version src;};
in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    extraInstallCommands = ''
      mv $out/bin/${pname}-${version} $out/bin/${pname}
      install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${appimageContents}/usr/share/icons $out/share
    '';
  }

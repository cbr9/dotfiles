{
  pkgs,
  config,
  lib,
  ...
}:
with pkgs;
with lib;
with builtins; let
  cfg = config.sys;
in {
  options.sys.hardware.audio.server = mkOption {
    type = types.nullOr (types.enum ["pulseaudio" "pipewire"]);
    default = "pipewire";
    description = "Audio server to use";
  };

  config = mkIf (cfg.hardware.audio.server != null) {
    environment.systemPackages = [
      # Need pulseaudio cli tools for pipewire.
      (mkIf (cfg.hardware.audio.server == "pipewire") pulseaudio)
    ];

    security.rtkit.enable = true;

    services.pipewire = mkIf (cfg.hardware.audio.server == "pipewire") {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    sound.enable = cfg.hardware.audio.server == "pulseaudio";
    hardware.pulseaudio = {
      enable = cfg.hardware.audio.server == "pulseaudio";
      support32Bit = true;
      package = pulseaudioFull;
    };
  };
}

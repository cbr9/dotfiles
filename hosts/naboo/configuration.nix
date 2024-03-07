{...}: {
  config = {
    networking.vpn = ["tailscale"];

    sys = {
      users = ["cabero"];
      hardware = {
        cpu = "amd";
        gpu = "nvidia";
        bluetooth = true;
      };
    };

    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    home-manager.users.cabero = {
      services.autorandr.enable = true;
      programs.autorandr = {
        enable = true;
        profiles = {
          home = {
            fingerprint = {
              DP-0 = "00ffffffffffff00220e6435010101012b1c0104a53c22783aa595a65650a0260d5054254b00d1c0a9c081c0d100b30095008100a940565e00a0a0a029503020350055502100001a000000fd00324c1e5a1e010a202020202020000000fc004850203237710a202020202020000000ff00434e4b383433313656540a20200092";
              HDMI-0 = "00ffffffffffff00220e893601010101141f010380351e782a8cc59f564b9e24115054a10800d1c0a9c081c0b3009500810081800101023a801871382d40582c45000f282100001e000000fd00323c1e5011000a202020202020000000fc004850204532342047340a202020000000ff00434e34313230323344360a202001ed020318b148901f04131211030267030c0010000022e2006b023a801871382d40582c45000f282100001e023a80d072382d40102c45800f282100001e011d007251d01e206e2855000f282100001e011d00bc52d01e20b82855400f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000ce";
            };
            hooks = {
              postswitch = ''
                echo 'awesome.restart()' | awesome-client
              '';
            };
            config = {
              HDMI-0 = {
                enable = true;
                mode = "1920x1080";
                position = "2560x360";
                rotate = "normal";
              };
              DP-0 = {
                enable = true;
                mode = "2560x1440";
                position = "0x0";
                rotate = "normal";
                primary = true;
              };
            };
          };
        };
      };
    };

    services.hardware.openrgb = let
      red = "ff0000";
    in {
      enable = true;
      motherboard = "amd";
      extraArgs = [
        "--mode static"
        "--color ${red}"
      ];
    };
  };
}

{pkgs, ...}: let
  nerd-fonts = [
    "Meslo"
  ];
in {
  fonts = {
    fontDir.enable = true;
    fonts =
      [
        (pkgs.nerdfonts.override {fonts = nerd-fonts;})
      ]
      ++ builtins.attrValues {
        inherit
          (pkgs)
          powerline-fonts
          meslo-lgs-nf # p10k
          ;
      };
  };
}

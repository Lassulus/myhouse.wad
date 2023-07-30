{
  description = "Play Myhouse.pk3 the very famous doom wad";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "i686-linux"
        "aarch64-linux"
        "riscv64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          myhouse = pkgs.callPackage ./myhouse.nix { };
        in
        {
          inherit myhouse;
          default = pkgs.writeShellApplication {
            name = "myhouse_menu";
            runtimeInputs = [
              pkgs.gum
            ];
            text = ''
              set -efu

              gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "
                This is an automated runner for my$(gum style --foreground 4 house).wad.
                I suggest starting by hitting play and try it out.
                If you get stuck, checkout the other links. Have fun!
              "

              menu() {
                CHOICE=$(gum choose play journal googledrive 'doomworld thread' "")

                case "$CHOICE" in
                  play)
                    ${myhouse}/bin/myhouse
                  ;;
                  journal)
                    gum style ' https://docs.google.com/document/d/1YZN1Gxa-moVq-7N_ckJsauUWHulJ4_Yvw-Ot5hKmppc/edit?pli=1 '
                    read -rp 'press any key to continue'
                  ;;
                  googledrive)
                    gum style ' https://drive.google.com/drive/folders/18Nx7kUQwmxUGoXqL6FiUwFY--up64fgo/ '
                    read -rp 'press any key to continue'
                  ;;
                  doomworld*)
                    gum style ' https://www.doomworld.com/forum/topic/134292-myhousewad/ '
                    read -rp 'press any key to continue'
                  ;;
                  "")
                    gum style 'SPOILER TERRITORY, I HIGHLY SUGGEST CLICKING THESE ONLY AFTER FINDING THE SECRET ON THE MAP'
                    gum style --border normal --foreground 0 --background 0 "
                      doomwiki walkthrough: https://doomwiki.org/wiki/My_House
                      PowerPak excellent youtube video: https://www.youtube.com/watch?v=5wAo54DHDY0
                    "
                    read -rp 'press any key to continue'
                  ;;
                esac
                menu
              }
              menu
            '';
          };
        });
    };
}

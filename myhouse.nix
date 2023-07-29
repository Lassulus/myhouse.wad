{ gzdoom, fetchurl, writeShellScriptBin }: let

  doomIIwad = fetchurl {
    url = "https://c.krebsco.de/DOOM2.WAD";
    hash = "sha256-1VqiK1AkXn44P2k6KBvKkfQYI5Ejr2Nhq+vqe5flrFo=";
  };

in writeShellScriptBin "myhouse" ''
  ${gzdoom}/bin/gzdoom -file ${./myhouse.pk3} -iwad ${doomIIwad}
''

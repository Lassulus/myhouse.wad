{ gzdoom, fetchurl, writeShellScriptBin }: let

  doomIIwad = fetchurl {
    url = "https://archive.org/download/DOOM2IWADFILE/DOOM2.WAD";
    hash = "sha256-XnAcgGqNOgNwD3/vl7etYtCu1Q/SQN+sJs3zmsPQqNU=";
  };

in writeShellScriptBin "myhouse" ''
  set -x
  ${gzdoom}/bin/gzdoom -file ${./myhouse.pk3} -iwad ${doomIIwad}
''

{ pkgs, ... }: {
  channel = "stable-23.11";

  packages = [];

  env = {};

  idx.extensions = [];

  idx.previews = {
    enable = true;
    previews = [
        {
        id = "android";
        manager = "android";
        }
    ];
  };
}

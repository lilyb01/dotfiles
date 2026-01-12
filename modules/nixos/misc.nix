{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      sdrpp
    ];
  }
}

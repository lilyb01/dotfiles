{ pkgs
, lib
, config
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.editors;
in
{
  options.custom.editors = {
    vscode = mkEnableOption "Use VSCode";
  };

  config = mkIf cfg.vscode { 
    programs.vscode = {
      enable = true;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        userSettings = { # test
          window.titleBarStyle = "custom";
          git.enableSmartCommit = true;
        };

        extensions = with pkgs.vscode-extensions; [
          # General
          catppuccin.catppuccin-vsc
          github.codespaces # Using codespaces for CS50
          usernamehw.errorlens # Inline error messages

          # Languages
          bbenoist.nix # Nix language support
          ms-vscode.cpptools # C & C++ Support
          # ms-python.python # Python support # FIXME https://github.com/NixOS/nixpkgs/issues/298110
          waderyan.gitblame # Show blame info
          davidanson.vscode-markdownlint # Markdown language support (preview is already builtin to vscode)
          bierner.emojisense # 😄 emoji completion
          bierner.markdown-emoji # Support :emoji: syntax in markdown
        ];
      };
    };
  };
}
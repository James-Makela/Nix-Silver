{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development
    cargo
    chromium
    kitty
    lua
    lua-language-server
    luarocks
    neovim
    nodejs_24
    powershell
    vscode-langservers-extracted
    python314
  ];
}

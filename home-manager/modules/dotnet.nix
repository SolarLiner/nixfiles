{
  programs.zsh.initContent = ''
    # Add .NET Core SDK tools
    export PATH="$PATH:$HOME/.dotnet/tools"
  '';
  home.sessionPath = ["$HOME/.dotnet/tools"];
}

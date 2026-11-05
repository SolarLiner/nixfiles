# home.username / home.homeDirectory are derived from the system's users.users entry.
{...}: {
  programs.git.settings.user = {
    name = "Nathan Graule";
    email = "nathan.graule@arturia.com";
  };
}

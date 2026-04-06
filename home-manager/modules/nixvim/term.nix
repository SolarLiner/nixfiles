{lib, ...}: {
  autoCmd = [
    # Disable spellcheck in terminal buffers
    {
      event = ["TermOpen"];
      command = "setlocal nospell";
    }
  ];
}

{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # Define a user account. Don't forget to set a password with 'passwd'.
  programs.zsh.enable = true;
  users.users.kdb424 = {
    isNormalUser = true;
    description = "Kyle Brown";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    uid = 1000;
    initialHashedPassword = "$6$8MS0DbAybsWGJt4a$zIX6v7qP3zS.uoJRv2jknz.KZ7QESNPGK.EvJ1Z0o8XDgDTZaYSAGRZ6dfRrl/22IS2DVogjAAgS15QJCcLwG1";
  };
}

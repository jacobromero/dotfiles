{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jpromero";
  home.homeDirectory = "/home/jpromero";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "xterm-256color";
    RESTIC_REPOSITORY = "s3:https://s3.amazonaws.com/backup-60bcf2244832ad4159633b308e6079b899a6d18f";
    RESTIC_PASSWORD = "qMw7EabAaPk2kR2wxgavnE6UcPPuqVZE";


    # AWS accounts
    IHS_AWS_ACCOUNT_ID = "749066067986";
    IHS_PROFILE = "jpromero-ihs";
    ACS_AWS_ACCOUNT_ID = "930753184059";
    AWS_DEFAULT_REGION = "us-west-2";
  };

  programs.bash = {
      enable = true;
      initExtra = ''
          export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
          export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
          exec fish
      '';
  };

  programs.fish = {
      enable = true;

      plugins = [
          { name = "tide"; src = pkgs.fishPlugins.tide.src; }
          { name = "z"; src = pkgs.fishPlugins.z.src; }
          { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
          { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
          { name = "done"; src = pkgs.fishPlugins.done.src; }
      ];

      shellAliases = {
          ls="lsd";
          bb="brazil-build";
          tma="tmux attach -t";
          bba="brazil-build apollo-pkg";
          bre="brazil-runtime-exec";
          bws="brazil ws";
          bwsuse="bws use --gitMode -p";
          bwscreate="bws create -n";
          brc="brazil-recursive-cmd";
          bbr="brc brazil-build";
          bball="brc --allPackages";
          bbb="brc --allPackages brazil-build";
          bbra="bbr apollo-pkg";
          adaihs="ada credentials update --account=$IHS_AWS_ACCOUNT_ID --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --once";
          adahex="ada credentials update --account=$IHS_AWS_ACCOUNT_ID --provider=conduit --role=HEXTenantAwsAccountAccessRole-DO-NOT-DELETE --once";
          em="emacsclient -c -a 'emacs'";
          backup="~/.local/setup/backup";
      };

      shellInit = ''
          tide configure \
            --auto \
            --style=Lean \
            --prompt_colors='16 colors' \
            --show_time=No \
            --lean_prompt_height='Two lines' \
            --prompt_connection=Solid \
            --prompt_spacing=Sparse \
            --icons='Few icons' \
            --transient=No
          set _tide_right_items status
          set -U fish_user_paths /bin /usr/bin/ /usr/local/bin $fish_user_paths
          set -U fish_user_paths $fish_user_paths /home/jpromero/.local/bin
          set -U fish_user_paths $fish_user_paths /home/jpromero/.toolbox/bin
          set -U fish_user_paths /home/jpromero/.local/share/mise/shims /home/jpromero/.nix-profile/bin $fish_user_paths
          set -x EDITOR nvim
          set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
          source ~/.config/fish/atuin_init.fish
          source ~/.config/fish/zoxide_init.fish
          mise activate fish | source

          set -U __done_allow_nongraphical 1
          set -U __done_notification_command "tput bel"

          set -U JAVA_HOME ~/.nix-profile/lib/openjdk/
          set -U SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
          set -U NIX_SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
      '';

      functions = {
          yy = {
              body = ''
                  set tmp (mktemp -t "yazi-cwd.XXXXXX")
                  yazi $argv --cwd-file="$tmp"
                  if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                      cd -- "$cwd"
                  end
                  rm -f -- "$tmp"
              '';
          };
      };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    atuin
    bash
    bat
    cowsay
    delta
    fd
    fish
    fishPlugins.tide
    fishPlugins.autopair
    fishPlugins.z
    fishPlugins.fzf-fish
    fishPlugins.done
    fzf
    jid
    jq
    lazygit
    lsd
    neovim
    nodejs_20
    parallel
    procs
    ripgrep
    rsync
    stow
    tmux
    util-linux
    viddy
    visidata
    yazi
    zoxide
    jdk21
    ticker
    chezmoi
    podman
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

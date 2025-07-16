{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "jacob.romero";
    home.homeDirectory = "/Users/jacob.romero";
    home.stateVersion = "25.05"; # Please read the comment before changing.


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

        # AWS accounts
        AWS_DEFAULT_REGION = "us-west-2";
    };

    # programs.bash = {
    #     enable = true;
    #     initExtra = ''
    #         # export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
    #         # export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
    #         exec fish
    #     '';
    # };


    programs.fish = {
        enable = true;

        plugins = [
            { name = "tide"; src = pkgs.fishPlugins.tide.src; }
            # { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
            # { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
            # { name = "done"; src = pkgs.fishPlugins.done.src; }
        ];

        shellAliases = {
            ls="lsd";
            lg="lazygit";
            ld="lazydocker";
            tma="tmux attach -t";
            wbd="wandb disabled && wandb offline";
            wbe="wandb enabled && wandb online";
            typofiles="git ls-files -m | xargs typos";
            pt="pytest -s -vv";
        };

        shellInit = ''
          set -U XDG_CONFIG_HOME "$HOME/.config"
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
          set -U fish_user_paths /usr/local/bin $fish_user_paths /bin /usr/bin/
          set -U fish_user_paths $fish_user_paths /Users/jacob.romero/.local/bin
          set -U fish_user_paths $fish_user_paths /Users/jacob.romero/.toolbox/bin
          set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
          # set -U fish_user_paths /Users/jacob.romero/.pyenv/shims $fish_user_paths
          set -U fish_user_paths $fish_user_paths /Users/jacob.romero/go/bin
          set -U fish_user_paths $fish_user_paths /nix/var/nix/profiles/default/bin
          set -U fish_user_paths /Users/jacob.romero/.nix-profile/bin $fish_user_paths
          set -U fish_user_paths $fish_user_paths /opt/homebrew/opt/go@1.23/bin
          set -U GOPATH /opt/homebrew/opt/go@1.23
          set -x EDITOR nvim
          set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
          set -x MANROFFOPT "-c"
          source ~/.config/fish/atuin_init.fish
          source ~/.config/fish/zoxide_init.fish

          set -U __done_allow_nongraphical 1
          set -U __done_notification_command "tput bel"

          export GOROOT="/opt/homebrew/opt/go@1.23/libexec"
          export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
          export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
          set -U fish_user_paths $JAVA_HOME/bin $fish_user_paths
          pyenv init - | source
          zoxide init --cmd z fish | source

          set -gx PATH "/Users/jacob.romero/.local/state/fnm_multishells/87763_1733783941536/bin" $PATH;
          set -gx FNM_MULTISHELL_PATH "/Users/jacob.romero/.local/state/fnm_multishells/87763_1733783941536";
          set -gx FNM_VERSION_FILE_STRATEGY "local";
          set -gx FNM_DIR "/Users/jacob.romero/.local/share/fnm";
          set -gx FNM_LOGLEVEL "info";
          set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
          set -gx FNM_COREPACK_ENABLED "false";
          set -gx FNM_RESOLVE_ENGINES "false";
          set -gx FNM_ARCH "arm64";
        '';

        functions = {
            yy = {
                body = ''
                    set tmpdir (mktemp -t "yazi-cwd.XXXXXX")
                    yazi $argv --cwd-file="$tmpdir"
                    if set cwd (command cat -- "$tmpdir"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                        builtin cd -- "$cwd"
                    end
                    rm -f -- "$tmpdir"
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
        (pkgs.writeShellScriptBin "clean-wandb" ''
            rm -r wandb/*run*
        '')
        atuin
        bat
        chezmoi
        choose
        circleci-cli
        colima
        curlie
        delta
        devenv
        docker-credential-helpers
        docker_28
        fd
        ffmpeg
        fish
        fishPlugins.autopair
        fishPlugins.done
        # fishPlugins.fzf-fish
        # fishPlugins.tide
        fishPlugins.z
        fzf
        go-critic
        gocyclo
        golangci-lint
        # google-cloud-sdk
        gotools
        gradle
        gron
        jid
        jnv
        just
        jq
        lazydocker
        lazygit
        lnav
        lsd
        luajit
        maven
        neovim
        parallel
        presenterm
        procs
        mprocs
        ripgrep
        rustup
        sd
        skhd
        tmux
        viddy
        visidata
        yazi
        zellij
        zig
        zoxide
        fnm
        typos
        graphite-cli
        lima
        gh
        pyenv
        # google-cloud-sdk-gce
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

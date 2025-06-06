{
  description = "Dev environment with Neovim and .NET";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.git
          pkgs.nodejs
          pkgs.direnv
          pkgs.python311
          pkgs.neovim
          pkgs.kubectl
          pkgs.jq
          pkgs.bash-completion
          pkgs.helm
        ];

        shellHook = ''
          eval "$(direnv hook bash)"
          # optionally comment out automatic allow:
          # direnv allow
          # source bash-completion script explicitly
          source ${pkgs.bash-completion}/etc/profile.d/bash_completion.sh
          source <(kubectl completion bash)
          echo "Development environment ready for $DEVENV"         source <(kubectl completion bash)
        '';
      };
    }
  );
}

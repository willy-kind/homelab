{
  description = "Dev environment with Neovim and k8s tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05-small";
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
          pkgs.bash-completion
          pkgs.direnv
          pkgs.git
          pkgs.helm
          pkgs.kubectl
          pkgs.k9s
          pkgs.neovim
        ];

        shellHook = ''
          eval "$(direnv hook bash)"
          # optionally comment out automatic allow:
          # direnv allow
          # source bash-completion script explicitly
          source ${pkgs.bash-completion}/etc/profile.d/bash_completion.sh
          source <(kubectl completion bash);
          echo "Development environment is ready 󱓟 "
        '';
      };
    }
  );
}

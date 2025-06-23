{
  description = "Dev environment with Neovim and k8s tools";

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
        buildInputs = with pkgs; [
          bash-completion
          fluxcd
          helm
          kubectl
          k9s
        ];

        shellHook = ''
          source ${pkgs.bash-completion}/etc/profile.d/bash_completion.sh
          source <(kubectl completion bash);
          export DEVENV="HomeLab"
          echo "Development environment is ready 󱓟 "
        '';
      };
    }
  );
}

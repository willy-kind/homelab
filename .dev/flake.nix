{
  description = "Dev environment with Neovim and k8s tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bash-completion
            cloudflared
            fluxcd
            kubernetes-helm
            kubectl
            k9s
            sops
            age
          ];

          shellHook = ''
            source ${pkgs.bash-completion}/etc/profile.d/bash_completion.sh
            source <(kubectl completion bash);
            source <(helm completion bash)

            # use the repo's git hooks (conventional commits)
            git config core.hooksPath .dev/githooks

            export DEVENV="HomeLab"
            echo "Development environment is ready 󱓟 "
          '';
        };
      });
}

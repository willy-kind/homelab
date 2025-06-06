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
        buildInputs = with pkgs; [
          bash-completion
          direnv
          fluxcd
          git
          helm
          kubectl
          k9s
          neovim
        ];

        shellHook = ''
          eval "$(direnv hook bash)"
          source ${pkgs.bash-completion}/etc/profile.d/bash_completion.sh
          source <(kubectl completion bash);
          echo "Development environment is ready 󱓟 "
        '';
      };
    }
  );
}

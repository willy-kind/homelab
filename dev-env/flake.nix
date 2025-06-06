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
          pkgs.helm
        ];

        shellHook = ''
          echo "Dev environment ready for my Homelab"
          export DEVENV="HomeLab"
          eval "$(direnv hook bash)"
          direnv allow
        '';
      };
    }
  );
}

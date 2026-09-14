{
  description = "svlings - learn SystemVerilog by fixing broken hardware, one small circuit at a time";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "svlings";

          buildInputs = with pkgs; [
            verilator # compiles and simulates your SystemVerilog
            gtkwave # lets you look at waveforms (signals over time) as squiggly lines
            gcc # verilator turns your design into C++ behind the scenes and needs a compiler for that
            gnumake # verilator's build step is driven by a Makefile it generates
            python3 # a small helper verilator itself uses during the build
            git # the course tracks your progress with git, so it's worth having
          ];

          shellHook = ''
            # Put this repo's own "svlings" command on your PATH for this shell.
            export PATH="$PWD/bin:$PATH"

            echo ""
            echo "  svlings dev shell ready."
            echo "  verilator: $(verilator --version | head -n1)"
            echo ""
            echo "  Run this to get started:"
            echo ""
            echo "      svlings list"
            echo ""
          '';
        };
      });
}

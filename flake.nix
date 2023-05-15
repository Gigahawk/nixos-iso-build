{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs , nixos-generators, }: {

    packages = {
      x86_64-linux = rec {
        default = hello;
        hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      };
    };

    virtualbox = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "install-iso";
      modules = [
        ./configuration.nix
        ./modules/virtualbox.nix
      ];
    };

  };
}

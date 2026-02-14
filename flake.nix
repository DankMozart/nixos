{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # TODO Had to add home-manager
        home-manager.url = "github:nix-community/home-manager";
    };

    outputs = inputs:
        inputs.snowfall-lib.mkFlake {
            inherit inputs;
            src = ./.;
	    channels-config.allowUnfree = true;
            # Configure Snowfall Lib, all of these settings are optional.
            snowfall = {
                # Tell Snowfall Lib to look in the `./nix/` directory for your
                # Nix files.
                root = ./.; # TODO This does not exist and causes errors, solved by changing to ./..

                # Choose a namespace to use for your flake's packages, library,
                # and overlays.
                namespace = "rooting";

                # Add flake metadata that can be processed by tools like Snowfall Frost.
                meta = {
                    # A slug to use in documentation when displaying things like file paths.
                    name = "flake-e";

                    # A title to show for your flake, typically the name.
                    title = "My Awesome Flake";
                };
            };
        };
}

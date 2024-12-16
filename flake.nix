{
    description = "My first Description";

    inputs = {
	nixpkgs.url = "nixpkgs/nixos-unstable";
	home-manager.url = "github:nix-community/home-manager/master";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";	 


    };

    outputs = { self, nixpkgs, home-manager, ...}:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {

        nixosConfigurations = {
            nixos = lib.nixosSystem {
            	inherit system;
                modules = [ ./configuration.nix ];

            };

        };
	    homeConfigurations = {
		    timl = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ];

            };
	


		

	    };
        # Development environment output
        devShells = system({ pkgs }: {
            default = let
              # Use Python 3.11
            python = pkgs.python311;

            in pkgs.mkShell {
              # The Nix packages provided in the environment
              packages = [
                # Python plus helper tools
                (python.withPackages (ps:
                  with ps; [

                    # notebook
                    jupyter
                    jupyterlab
                    ipykernel
                    ipython

                    # scientific computing
                    pandas # Data structures & tools
                    numpy # Array & matrices
                    scipy # Integral, solving differential, equations, optimizations)

                    # Visualization
                    matplotlib # plot & graphs
                    seaborn # heat maps, time series, violin plot

                    # Algorithmic Libraries
                    scikit-learn-extra # Machine learning: regression, classificatons,..
                    statsmodels # Ecplore data, estimate statistical models, & perform statistical test.

                    # Formatting
                    black

                    # Probabilistic
                    # pymc #support < 311

                  ]))
              ];
            };
        });




    };

 

}

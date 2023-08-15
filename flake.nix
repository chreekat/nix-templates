{
  outputs = { self }: {
    templates = {
      #haskell-servant = {
      #  path = ./haskell-servant;
      #  description = "A flakified, bare bones Haskell Servant web app";
      #  welcomeText = ''
      #    TBD
      #  '';
      #};
      haskell-generic = {
        path = ./haskell-generic;
        description = "An anonymous build env for your local package";
        welcomeText = ''
          You should now be able to run `nix develop` to enter a shell with all
          dependencies for your local package present.

          You can also use `direnv` to make this automatic.
        '';
      };

    };
    templates.default = self.templates.haskell-generic;
  };
}

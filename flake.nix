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
          TBD
        '';
      };

    };
    templates.default = self.templates.haskell-generic;
  };
}

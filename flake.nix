{
  description = "Remote Template for Flutter Android Dev on NixOS";

  outputs =
    { self }:
    {
      defaultTemplate = {
        path = ./template;
        description = "Standalone Flutter Android Dev Shell (Nix-LD, No FHS)";
      };

      templates.default = self.defaultTemplate;
    };
}

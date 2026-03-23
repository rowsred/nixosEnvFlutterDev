{
  description = "Remote Template for Flutter Android Dev on NixOS";

  outputs =
    { self }:
    {
      # Ini yang membuat kamu bisa panggil tanpa '#'
      defaultTemplate = {
        path = ./template;
        description = "Standalone Flutter Android Dev Shell (Nix-LD, No FHS)";
      };

      # Opsional: Tetap daftarkan di 'templates' agar lebih formal
      templates.default = self.defaultTemplate;
    };
}

{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.android_sdk.accept_license = true;
        config.allowUnfree = true;
      };

      androidSdk =
        (pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = [ "35.0.0" ];
          platformVersions = [ "36" ];
          includeNDK = true;
          ndkVersions = [ "28.2.13676358" ];
          cmakeVersions = [ "3.22.1" ];
        }).androidsdk;

      # Kumpulan library yang dibutuhkan AAPT2 dan binary luar lainnya
      libs = with pkgs; [
        glibc
        zlib
        stdenv.cc.cc.lib
        ncurses
        expat
        libuuid
      ];

    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs =
          with pkgs;
          [
            # Tooling Utama
            flutter
            jdk17
            androidSdk
            cmake
            git

            # Linker mandiri agar tidak butuh config sistem
            nix-ld
          ]
          ++ libs;

        shellHook = ''
          # 1. Path Android & Java (Sesuai profil lama kamu)
          export ANDROID_HOME=${androidSdk}/libexec/android-sdk
          export ANDROID_SDK_ROOT=${androidSdk}/libexec/android-sdk
          export JAVA_HOME=${pkgs.jdk17.home}
          export PATH=$PATH:${pkgs.flutter}/bin

          # 2. Konfigurasi nix-ld-rs Lokal
          # Ini trik agar AAPT2 bisa jalan tanpa FHS dan tanpa nix-ld di configuration.nix
          export NIX_LD="${pkgs.nix-ld}/bin/nix-ld"
          export NIX_LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}"

          # Tambahan agar binary langsung mengenali path library
          export LD_LIBRARY_PATH="$NIX_LD_LIBRARY_PATH:$LD_LIBRARY_PATH"

          echo "Flutter Dev Shell (Standalone Nix-LD) Ready"
        '';
      };
    };
}

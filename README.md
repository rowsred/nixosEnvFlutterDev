# ❄️ NixOS Flutter Dev Environment (Standalone)

Template Nix Flake untuk pengembangan aplikasi Flutter di NixOS tanpa mengotori konfigurasi sistem (`/etc`) atau `.bashrc`. Menggunakan `nix-ld` mandiri agar binary Android SDK (AAPT2, dsb) berjalan mulus tanpa perlu FHS.

## 🚀 Quick Start

Masuk ke folder proyek Flutter kamu (atau buat folder baru), lalu jalankan:

```bash
nix flake init -t github:rowsred/nixosEnvFlutterDev --refresh

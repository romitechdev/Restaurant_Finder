
# Restaurant Finder - Aplikasi Flutter

![Restaurant App Demo](https://firebasestorage.googleapis.com/v0/b/project-revelation-396514.appspot.com/o/pop-os-2024-07-25_21-02-18.gif?alt=media&token=c60c3b87-142f-488f-b98a-bb0977209930)

## 📜 Deskripsi

Ini adalah aplikasi mobile Flutter yang menampilkan daftar restoran. Aplikasi ini dibuat sebagai contoh proyek portofolio yang menunjukkan implementasi konsep-konsep modern dalam pengembangan Flutter, termasuk arsitektur yang bersih, state management, dan desain UI yang responsif.

Aplikasi ini mengambil data restoran dari file JSON lokal dan menampilkannya dalam daftar yang menarik. Pengguna dapat melihat detail setiap restoran di halaman terpisah dan juga dapat mengganti tema antara mode terang (light) dan gelap (dark).

---

## ✨ Fitur Utama

-   **Daftar Restoran**: Menampilkan daftar restoran dengan gambar, nama, dan kota.
-   **Halaman Detail**: Halaman khusus untuk setiap restoran yang menampilkan informasi lebih lengkap seperti deskripsi, menu makanan, dan minuman.
-   **State Management**: Menggunakan `Provider` untuk mengelola state aplikasi, seperti data restoran dan tema.
-   **Tema Terang & Gelap**: Terdapat tombol untuk beralih antara mode terang dan gelap secara dinamis.
-   **UI Responsif**: Tampilan yang menyesuaikan diri dengan berbagai ukuran layar.
-   **Arsitektur Bersih**: Kode disusun dengan memisahkan layer UI (pages, widgets), state management (providers), dan data (models).
-   **Kustomisasi Font**: Menggunakan paket `google_fonts` untuk tipografi yang lebih menarik.

---

## 🚀 Teknologi & Pustaka

-   **Framework**: [Flutter](https://flutter.dev/)
-   **Bahasa**: [Dart](https://dart.dev/)
-   **State Management**: [provider](https://pub.dev/packages/provider)
-   **HTTP Client**: [http](https://pub.dev/packages/http)
-   **Tipografi**: [google_fonts](https://pub.dev/packages/google_fonts)
-   **Analisis Kode**: [flutter_lints](https://pub.dev/packages/flutter_lints)

---

## 📂 Struktur Proyek

Proyek ini disusun dengan struktur folder yang berorientasi pada fitur untuk memudahkan navigasi dan skalabilitas:

```
lib/
├── models/         # Model data untuk aplikasi (Restaurant, ApiResponse)
├── pages/          # Halaman atau layar utama (HomePage, DetailPage)
├── providers/      # Logika bisnis dan state management (RestaurantProvider, ThemeProvider)
├── widgets/        # Komponen UI yang dapat digunakan kembali (RestaurantCard, ErrorWidget)
└── main.dart       # Titik masuk utama aplikasi dan konfigurasi tema
```

---

## 🏁 Memulai

Untuk menjalankan proyek ini secara lokal, ikuti langkah-langkah berikut:

1.  **Clone repositori ini:**
    ```bash
    git clone https://github.com/NAMAPENGGUNAANDA/NAMA-REPOSITORIANDA.git
    ```

2.  **Masuk ke direktori proyek:**
    ```bash
    cd NAMA-REPOSITORIANDA
    ```

3.  **Instal semua dependensi:**
    ```bash
    flutter pub get
    ```

4.  **Jalankan aplikasi:**
    ```bash
    flutter run
    ```

---

> Proyek ini dibuat untuk tujuan demonstrasi dan portofolio. Jangan ragu untuk menggunakannya sebagai referensi.

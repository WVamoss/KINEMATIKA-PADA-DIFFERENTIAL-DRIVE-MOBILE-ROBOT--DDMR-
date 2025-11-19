# Kinematika pada Differential‑Drive Mobile Robot (DDMR)

## Deskripsi Proyek

Proyek ini berfokus pada penerapan **kinematika robot** untuk **Differential-Drive Mobile Robot (DDMR)**. Melalui implementasi algoritma **kinematika maju** (forward kinematics) dan **kinematika balik** (inverse kinematics), proyek ini bertujuan untuk memberikan pemahaman mendalam tentang bagaimana robot dengan dua roda penggerak dapat bergerak dan berorientasi dalam ruang dua dimensi.

Dengan menggunakan bahasa pemrograman **Lua**, proyek ini menyediakan kode-kode yang dapat digunakan untuk menghitung posisi, orientasi, serta kecepatan robot berdasarkan kecepatan roda atau pergerakan yang diinginkan. Ini sangat berguna untuk pengembangan sistem robotik yang berfokus pada kendali dan simulasi.

## Fitur Utama

- **Forward Kinematics**: Menghitung posisi dan orientasi robot berdasarkan kecepatan roda kiri dan kanan.
- **Inverse Kinematics**: Menghitung kecepatan roda yang diperlukan untuk mencapai kecepatan linear dan angular tertentu.
- **Simulasi dan Contoh Kasus**: Menyediakan skrip tugas untuk menunjukkan penerapan kinematika dalam skenario praktis.

## Struktur Proyek

Berikut adalah deskripsi singkat mengenai file dan skrip yang ada dalam repositori ini:

| File                          | Deskripsi                                                                 |
|-------------------------------|---------------------------------------------------------------------------|
| `Forward_Kinematics.lua`       | Skrip untuk menghitung posisi dan orientasi robot berdasarkan kecepatan roda kiri dan kanan. |
| `Inverse_Kinematics.lua`       | Skrip untuk menghitung kecepatan roda yang dibutuhkan berdasarkan kecepatan linear dan angular yang diinginkan. |
| `Tugas.lua`                    | Skrip contoh yang menunjukkan penerapan kinematika pada robot differential-drive. |

## Tujuan dan Manfaat

Proyek ini bertujuan untuk:

- Memberikan pemahaman teoritis dan praktis tentang **kinematika robot differential-drive**.
- Menyediakan modul yang dapat digunakan dalam pengembangan aplikasi robotik berbasis Lua.
- Mempermudah proses simulasi dan pengendalian robot dalam berbagai skenario.
- Menjadi referensi bagi mahasiswa, peneliti, atau praktisi di bidang robotika.

## Panduan Penggunaan

### Langkah-langkah untuk Menjalankan Skrip:

1. **Instalasi Lua**  
   Pastikan Anda telah menginstal **interpreter Lua** di komputer Anda. Anda bisa mengunduhnya dari [situs resmi Lua](https://www.lua.org/download.html).

2. **Persiapkan Parameter Robot**  
   Sesuaikan parameter robot Anda, seperti:
   - Jarak antar roda (wheelbase)
   - Radius roda
   - Kecepatan roda kiri dan kanan (untuk kinematika maju)
   - Kecepatan linear dan angular (untuk kinematika balik)

3. **Jalankan Skrip**  
   Buka file skrip yang sesuai, seperti `Forward_Kinematics.lua` atau `Inverse_Kinematics.lua`, di editor Lua pilihan Anda. Setelah itu, jalankan skrip untuk melihat hasil perhitungan posisi, orientasi, atau kecepatan roda.

4. **Eksplorasi Tugas Contoh**  
   Gunakan file `Tugas.lua` sebagai referensi untuk eksperimen lebih lanjut atau penerapan dalam skenario dunia nyata.

## Catatan Teknis

- **Bahasa Pemrograman**: Semua kode dalam repositori ini ditulis dalam **Lua**.
- **Tidak Ada Dependensi Eksternal**: Skrip ini tidak memerlukan pustaka atau dependensi eksternal selain interpreter Lua standar.
- **Fokus Proyek**: Proyek ini berfokus pada perhitungan kinematika robot tanpa memperhitungkan faktor-faktor seperti dinamika, traksi, atau gesekan roda.

## Kontribusi

Kami sangat menghargai kontribusi dari komunitas! Jika Anda tertarik untuk berkontribusi:

1. Fork repositori ini dan buat branch untuk fitur atau perbaikan Anda.
2. Tambahkan kode atau fitur baru, serta perbaiki bug yang ada.
3. Kirim pull request dengan penjelasan mendetail tentang perubahan yang Anda buat.



# Proyek Portofolio Mobile - Pemrograman Berbasis Platform (CSGE602022)

- **Nama:** Joceline Nadine Immanuella
- **NPM:** 2506656835
- **Kelas:** PBP A
- **Program Studi:** Sistem Informasi, Fakultas Ilmu Komputer Universitas Indonesia
- **Repositori GitHub:** [https://github.com/jocelinenadine-dev/myportofolio_mobile](https://github.com/jocelinenadine-dev/myportofolio_mobile)

---

## Deskripsi Proyek

**MyPortfolio Mobile** (`myportofolio_mobile`) adalah aplikasi *mobile* multiplatform berbasis **Flutter** dan bahasa pemrograman **Dart** yang dikembangkan sebagai perluasan dari ekosistem web portofolio pribadi saya. Aplikasi ini dirancang menggunakan komponen antarmuka **Material Design 3** untuk menampilkan informasi identitas pemilik portofolio melalui komponen kartu (`InfoCard`) serta menyediakan navigasi menu aksi utama portofolio melalui komponen kartu interaktif (`ItemCard`: *Lihat Proyek*, *Tambah Proyek*, dan *Logout*) yang dilengkapi warna latar berbeda untuk setiap tombol serta umpan balik visual berupa `SnackBar`.

---

## Ringkasan Progres Mingguan (Weekly Progress Tracker)

| Pekan / Tahap | Topik Materi | Fokus Implementasi Utama | Status Penyelesaian |
| :--- | :--- | :--- | :--- |
| **Tutorial 08** | Basic Flutter Setup & Widget | Instalasi Flutter SDK & Android SDK, inisialisasi proyek `myportofolio_mobile`, pemisahan modul `menu.dart`, dan pembuatan kerangka dasar `InfoCard` serta `ItemCard`. | Selesai (100%) |
| **Tugas 7** | Elemen Dasar Flutter | Kustomisasi identitas pribadi pada `InfoCard`, diferensiasi warna unik pada setiap `ItemCard` (`Colors.blue`, `Colors.green`, `Colors.red`), interaktivitas `SnackBar`, pengujian otomatis `widget_test.dart`, serta dokumentasi reflektif. | Selesai (100%) |

---

## Panduan Instalasi, Menjalankan Proyek, dan Pengujian (Setup, Run, & Test)

Berikut adalah langkah-langkah eksplisit untuk menyiapkan lingkungan pengembangan, menjalankan aplikasi, serta mengeksekusi analisis statis dan pengujian otomatis pada proyek ini:

### 1. Prasyarat Lingkungan (Prerequisites)
Pastikan perangkat telah terpasang **Flutter SDK** (kanal `stable`, versi `>= 3.x`), **Dart SDK** (terbundel bersama Flutter), **Android SDK**, serta peramban **Google Chrome**. Verifikasi kesiapan *toolchain* melalui terminal:
```bash
flutter doctor
```

### 2. Kloning Repositori dan Instalasi Dependensi (Setup)
Unduh kode sumber dari repositori GitHub dan pasang seluruh paket dependensi yang terdaftar pada `pubspec.yaml`:
```bash
git clone https://github.com/jocelinenadine-dev/myportofolio_mobile.git
cd myportofolio_mobile
flutter pub get
```

### 3. Menjalankan Aplikasi (Run)
Untuk menjalankan aplikasi secara cepat pada peramban web **Google Chrome**:
```bash
flutter run -d chrome
```
Untuk menjalankan aplikasi pada **Android Emulator** atau perangkat fisik Android yang terhubung:
```bash
flutter devices
flutter run
```
Saat aplikasi berjalan di terminal, tekan `r` untuk melakukan *Hot Reload*, `R` untuk melakukan *Hot Restart*, atau `q` untuk menghentikan sesi eksekusi.

### 4. Analisis Kualitas Kode dan Pengujian Otomatis (Analyze & Test)
Jalankan *static analysis* menggunakan *linter* resmi Flutter untuk memastikan tidak ada kesalahan sintaksis maupun pelanggaran konvensi gaya kode:
```bash
flutter analyze
```
Jalankan rangkaian pengujian otomatis (*widget smoke test*) pada berkas `test/widget_test.dart` untuk memverifikasi rendering komponen `InfoCard`, ketiga tombol `ItemCard`, serta kemunculan `SnackBar`:
```bash
flutter test
```

---

### Tugas 7: Basic Flutter

#### 1. Jelaskan apa yang dimaksud dengan *widget tree* pada Flutter dan bagaimana hubungan induk-anak (*parent-child*) bekerja antar-*widget*!

**Jawaban:**  
Pada kerangka kerja Flutter, hampir seluruh aspek antarmuka pengguna dibangun menggunakan konsep *widget*—mulai dari komponen visual seperti teks dan ikon, pengatur tata letak seperti baris dan kolom, hingga pengelola tema tingkat aplikasi. **Widget tree** adalah struktur data hierarkis berbentuk pohon yang merepresentasikan bagaimana seluruh *widget* di dalam aplikasi disusun dan saling membungkus satu sama lain untuk membentuk tampilan layar secara utuh.

Hubungan induk-anak (*parent-child*) di dalam *widget tree* bekerja secara deklaratif melalui mekanisme *composition* (komposisi objek) dengan aturan aliran tata letak *Constraints go down, Sizes go up, Parent sets position*:
- **Penerusan Batasan dan Konteks dari Induk ke Anak (*Constraints go down*):** *Widget* induk (*parent*) meneruskan batasan ruang dimensi (*BoxConstraints*, yakni lebar dan tinggi minimum serta maksimum yang diizinkan) sekaligus meneruskan informasi konteks (`BuildContext`) kepada *widget* anaknya (*child* atau *children*).
- **Penentuan Ukuran oleh Anak (*Sizes go up*):** Berdasarkan batasan yang diberikan oleh *parent*, *widget* anak menghitung dan menentukan dimensinya sendiri, kemudian mengembalikan informasi ukuran tersebut ke *parent*.
- **Penempatan Posisi oleh Induk (*Parent sets position*):** *Widget* induk mengatur koordinat posisi di mana *widget* anak tersebut akan ditempatkan pada kanvas layar.
- **Pola Komposisi Tunggal dan Majemuk:** *Widget* yang hanya membungkus satu anak menggunakan properti `child` (seperti `Padding`, `Center`, `Container`, `Card`, `Material`, dan `InkWell`), sedangkan *widget* yang menata banyak anak sekaligus menggunakan properti `children` berupa `List<Widget>` (seperti `Column`, `Row`, dan `GridView.count`).

Pada proyek `myportofolio_mobile` yang saya bangun, hubungan induk-anak tersebut terlihat langsung dari akar aplikasi: `MyApp` membungkus `MaterialApp`, yang kemudian menjadikan `MyHomePage` sebagai halaman utama (`home`). Di dalam `MyHomePage`, `Scaffold` berperan sebagai induk struktur halaman yang memiliki dua cabang utama, yakni `AppBar` di bagian atas dan `SingleChildScrollView` di bagian `body`. Di dalam `body`, `Padding` membungkus `Column` utama yang menata dua kelompok anak secara vertikal: baris `Row` (yang menjadi induk bagi tiga `InfoCard`) serta `Center` (yang membungkus `Column` berisi teks sambutan dan `GridView.count` sebagai induk bagi ketiga `ItemCard`).

---

#### 2. Sebutkan semua *widget* yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

**Jawaban:**  
Berikut adalah daftar seluruh *widget* yang saya gunakan di dalam berkas `lib/main.dart` dan `lib/menu.dart` beserta fungsi spesifiknya pada aplikasi portofolio saya:

- **`MyApp` (`StatelessWidget`):** *Custom root widget* yang dijalankan pertama kali oleh fungsi `runApp()`. Fungsinya menginisialisasi konfigurasi global aplikasi melalui `MaterialApp`.
- **`MaterialApp`:** *Widget* pembungkus utama tingkat aplikasi yang menyediakan konfigurasi tema Material Design 3 (`ThemeData`), judul aplikasi (`title: 'MyPortfolio'`), sistem navigasi halaman, serta mengatur halaman awal aplikasi ke `MyHomePage()`.
- **`MyHomePage` (`StatelessWidget`):** *Custom widget* yang merepresentasikan halaman menu utama portofolio. Menyimpan data identitas pemilik (`npm`, `nama`, `kelas`) serta daftar objek menu `items`, lalu menyusun seluruh elemen antarmuka ke dalam `Scaffold`.
- **`Scaffold`:** Menyediakan kerangka dasar struktur visual halaman standar Material Design yang menampung bilah atas (`appBar`), area konten utama (`body`), serta mendukung pemunculan pesan notifikasi bawah (`SnackBar`).
- **`AppBar`:** Menampilkan bilah navigasi di bagian paling atas halaman dengan judul `'MyPortfolio'` berwarna putih tebal dan warna latar yang diambil dari warna primer tema (`Theme.of(context).colorScheme.primary`).
- **`SingleChildScrollView`:** Membungkus konten utama pada `body` agar halaman dapat digulir (*scrollable*) secara vertikal apabila dibuka pada layar perangkat atau jendela browser yang ukurannya pendek, sehingga mencegah terjadinya *RenderFlex overflow*.
- **`Padding`:** Memberikan jarak ruang kosong di sekeliling *widget* anaknya, yaitu `EdgeInsets.all(16.0)` pada sekeliling `body` halaman, `EdgeInsets.only(top: 16.0)` di atas teks sambutan, serta `EdgeInsets.all(3)` di antara ikon dan teks pada kartu tombol.
- **`Column`:** Menyusun daftar *widget* anak secara berurutan dari atas ke bawah (vertikal). Digunakan pada susunan utama `body`, kelompok tengah pesan sambutan dan kisi tombol, susunan teks `title` dan `content` di dalam `InfoCard`, serta susunan ikon dan teks di dalam `ItemCard`.
- **`Row`:** Menyusun daftar *widget* anak secara berjajar dari kiri ke kanan (horizontal). Digunakan untuk menampilkan ketiga komponen `InfoCard` (*NPM*, *Name*, dan *Class*) secara sejajar dengan perataan jarak `MainAxisAlignment.spaceEvenly`.
- **`SizedBox`:** Memberikan ruang pemisah berdimensi tetap antar-elemen, yaitu `SizedBox(height: 16.0)` sebagai jarak vertikal antara baris `InfoCard` dengan bagian sambutan, serta `SizedBox(height: 8.0)` di antara judul dan isi di dalam `InfoCard`.
- **`Center`:** Menempatkan *widget* anaknya tepat di titik tengah area yang tersedia. Digunakan untuk memusatkan bagian teks sambutan beserta kisi tombol, serta memusatkan posisi ikon dan label di dalam setiap `ItemCard`.
- **`GridView.count`:** Menampilkan sekumpulan *widget* anak dalam tata letak kisi (*grid*) dengan jumlah kolom tetap (`crossAxisCount: 3`), jarak horizontal dan vertikal antar-kartu sebesar `10` piksel, serta `shrinkWrap: true` agar tinggi *grid* menyesuaikan isi dari ketiga `ItemCard`.
- **`InfoCard` (`StatelessWidget`):** *Reusable custom widget* yang saya buat untuk menampilkan kartu informasi identitas pemilik portofolio berdasarkan parameter `title` dan `content` tanpa perlu menulis ulang kode kartu berulang kali.
- **`Card`:** Komponen Material Design yang membungkus isi `InfoCard` ke dalam kotak bersudut membulat dengan efek bayangan kedalaman (*shadow*) sebesar `elevation: 2.0`.
- **`Container`:** *Widget* serbaguna untuk mengatur ukuran dimensi dan tata ruang internal, yang pada proyek ini digunakan untuk menetapkan lebar `InfoCard` secara proporsional (`MediaQuery.of(context).size.width / 3.5`) serta memberikan *padding* di dalam `InfoCard` dan `ItemCard`.
- **`ItemCard` (`StatelessWidget`):** *Reusable custom widget* yang merender setiap objek data `ItemHomepage` menjadi kartu tombol aksi interaktif lengkap dengan warna latar spesifik, ikon, teks, dan pemicu `SnackBar`.
- **`Material`:** Menyediakan permukaan kanvas Material Design pada `ItemCard` dengan warna latar yang diambil dari atribut `item.color` (`Colors.blue`, `Colors.green`, `Colors.red`) serta sudut membulat `BorderRadius.circular(12)` agar efek sentuhan `InkWell` dapat digambar di atasnya.
- **`InkWell`:** Menangkap interaksi ketukan pengguna (`onTap`) pada `ItemCard`, menampilkan animasi visual riak air (*ink ripple effect*) khas Material Design, dan menjalankan fungsi pemanggilan `SnackBar`.
- **`Icon`:** Menampilkan ikon grafis vektor dari katalog Material Icons (`Icons.folder`, `Icons.add_circle`, dan `Icons.logout`) berwarna putih dengan ukuran `30.0` di dalam masing-masing `ItemCard`.
- **`Text`:** Menampilkan seluruh untaian teks pada aplikasi, mulai dari judul `AppBar`, teks di dalam `InfoCard`, kalimat sambutan `'Selamat datang di MyPortfolio Mobile!'`, label nama tombol pada `ItemCard`, hingga isi pesan di dalam `SnackBar`.
- **`SnackBar`:** Komponen bilah pesan *pop-up* sementara di bagian bawah layar yang menampilkan teks umpan balik `"Kamu telah menekan tombol ${item.name}!"` setiap kali sebuah tombol aksi ditekan.
- **`ScaffoldMessenger`:** Pengelola tingkat halaman yang digunakan melalui `ScaffoldMessenger.of(context)` untuk menyembunyikan *SnackBar* yang sedang tampil (`hideCurrentSnackBar()`) dan menampilkan *SnackBar* baru (`showSnackBar(...)`) secara mulus.

---

#### 3. Apa fungsi dari *widget* `MaterialApp`? Jelaskan mengapa *widget* ini umumnya digunakan sebagai *root widget* pada aplikasi Flutter!

**Jawaban:**  
`MaterialApp` adalah *widget* pembungkus tingkat aplikasi yang mengonfigurasi dan menyediakan berbagai infrastruktur dasar bagi aplikasi yang menerapkan bahasa desain **Material Design**. Fungsi utama dari `MaterialApp` meliputi:
- **Pengelolaan Tema Global (`theme`):** Menyimpan objek `ThemeData` dan `ColorScheme` yang mendefinisikan palet warna primer, sekunder, serta tipografi aplikasi agar konsisten di seluruh layar.
- **Sistem Navigasi dan Routing (`Navigator`):** Menyediakan *navigation stack* bawaan untuk mengatur perpindahan antar-halaman (*screen*) serta menentukan halaman pembuka melalui properti `home`.
- **Infrastruktur *Overlay* dan Pesan (`ScaffoldMessenger`):** Menginisialisasi `ScaffoldMessenger` utama sehingga komponen antarmuka di bawahnya dapat memunculkan `SnackBar` atau dialog di atas layar.
- **Penyediaan Konteks Lingkungan (`MediaQuery`, `Directionality`, dan `Localizations`):** Membaca informasi ukuran layar perangkat melalui `MediaQuery`, menentukan arah orientasi teks (*Left-to-Right* atau *Right-to-Left*) melalui `Directionality`, serta menyediakan lokalisasi bahasa standar untuk komponen Material.

**Alasan mengapa `MaterialApp` umumnya digunakan sebagai *root widget*:**  
Sebagian besar *widget* Material di Flutter—seperti `Scaffold`, `AppBar`, `Card`, `Text`, `InkWell`, dan `SnackBar`—dirancang untuk mencari data konfigurasi dari *InheritedWidget* yang berada di atas mereka pada *widget tree* (misalnya memanggil `Theme.of(context)`, `MediaQuery.of(context)`, atau `ScaffoldMessenger.of(context)`). Apabila `MaterialApp` tidak ditempatkan sebagai *root widget* (induk paling atas), maka *widget-widget* di bawahnya akan gagal menemukan konteks `Theme`, `Directionality`, maupun `MaterialLocalizations` yang mereka butuhkan, sehingga aplikasi akan mengalami *runtime error* saat merender halaman. Dengan meletakkan `MaterialApp` di akar pohon, seluruh halaman dan komponen anak dijamin memperoleh akses ke layanan inti Material Design tersebut.

---

#### 4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`! Kapan kita sebaiknya memilih `StatelessWidget` dan kapan harus menggunakan `StatefulWidget`?

**Jawaban:**  
Perbedaan utama antara `StatelessWidget` dan `StatefulWidget` terletak pada ada atau tidaknya data keadaan internal (*internal mutable state*) yang dapat berubah selama *widget* tersebut hidup di layar:

- **`StatelessWidget`:**
  - Merupakan *widget* yang bersifat **statis dan *immutable*** (tidak memiliki *state* internal yang dapat berubah setelah *widget* selesai dibangun).
  - Seluruh atribut variabel di dalamnya dideklarasikan sebagai `final` dan nilainya ditentukan saat konstruktor dipanggil oleh *widget* induknya.
  - Hanya terdiri dari satu kelas yang meng-*override* metode `build(BuildContext context)`.
  - Proses *rebuild* (penggambaran ulang) hanya terjadi apabila *widget* induknya mengalami pembaruan dan mengirimkan nilai parameter konstruktor yang baru.
- **`StatefulWidget`:**
  - Merupakan *widget* yang bersifat **dinamis** karena memiliki objek `State` terpisah yang bersifat *mutable* (nilainya dapat berubah-ubah seiring waktu selama aplikasi berjalan).
  - Terdiri dari dua kelas yang saling berpasangan: kelas turunan `StatefulWidget` itu sendiri (yang tetap *immutable*) dan kelas turunan `State<T>` yang menyimpan variabel data dinamis serta metode `build()`.
  - Memiliki siklus hidup (*lifecycle*) yang lebih lengkap, seperti `initState()`, `didUpdateWidget()`, `setState()`, dan `dispose()`.
  - Dapat memicu penggambaran ulang tampilannya sendiri kapan saja secara mandiri dengan memanggil fungsi `setState(() { ... })` ketika terjadi perubahan data.

**Kapan sebaiknya memilih `StatelessWidget`?**  
Kita sebaiknya memilih `StatelessWidget` ketika tampilan suatu komponen atau halaman **sepenuhnya bergantung pada data informasi yang diberikan dari luar (konstruktor)** dan tidak memerlukan perubahan nilai variabel internal secara reaktif. Karena tidak perlu mengalokasikan objek `State` tambahan di memori, `StatelessWidget` lebih ringan dan efisien. Pada proyek `myportofolio_mobile` di Tugas 7 ini, kelas `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` semuanya tepat menggunakan `StatelessWidget` karena data NPM, Nama, Kelas, serta daftar ketiga tombol aksi bersifat tetap; interaksi ketukan pada tombol hanya memunculkan *overlay* `SnackBar` melalui `ScaffoldMessenger` tanpa memutasi properti di dalam `ItemCard`.

**Kapan harus menggunakan `StatefulWidget`?**  
Kita harus menggunakan `StatefulWidget` ketika tampilan *widget* perlu **berubah secara dinamis di layar sebagai respons terhadap interaksi pengguna, perubahan input, atau kedatangan data asinkron**, contohnya:
- Halaman formulir (*form*) untuk menambah proyek baru yang memiliki *input field* teks, *dropdown*, validasi *real-time*, atau *checkbox*.
- Halaman daftar proyek yang mengambil data JSON secara asinkron dari *endpoint* REST API Django (`/api/v1/`) dan perlu mengubah tampilan dari indikator *loading* menjadi daftar kartu proyek setelah data berhasil dimuat.
- Komponen penghitung (*counter*), tombol *toggle* suka/bintang (*star*), atau komponen yang menggunakan pengendali animasi.

---

#### 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode `build`?

**Jawaban:**  
**Pengertian `BuildContext`:**  
Di balik layar, ketika Flutter membaca struktur deklaratif dari *Widget Tree*, Flutter membangun pohon instansiasi nyata di memori yang disebut *Element Tree*. **`BuildContext`** adalah antarmuka (*interface*) dari objek `Element` tersebut yang berfungsi sebagai **penanda lokasi atau alamat posisi spesifik sebuah *widget* di dalam struktur pohon *widget* (*widget tree*)**. Setiap *widget* yang dirender memiliki `BuildContext`-nya masing-masing yang unik sesuai letaknya di dalam hierarki.

**Mengapa `BuildContext` penting di Flutter?**  
Dalam arsitektur *widget tree* yang bercabang dalam, sebuah *widget* anak yang berada jauh di bagian bawah pohon sering kali memerlukan akses ke data tema, ukuran layar, atau layanan navigasi yang disimpan pada *widget* leluhur (*ancestor*) di bagian atas pohon. Tanpa `BuildContext`, kita harus mengoper variabel-variabel tersebut secara manual melewati parameter konstruktor di setiap lapisan *widget* satu per satu (*prop drilling*). `BuildContext` menyelesaikan masalah ini dengan menyediakan metode pencarian ke atas pohon (*upward lookup* terhadap *InheritedWidget* terdekat) secara langsung dan efisien.

**Penggunaannya di dalam metode `build(BuildContext context)` pada proyek ini:**  
Di dalam metode `Widget build(BuildContext context)`, objek `context` diterima sebagai parameter otomatis dan saya gunakan secara nyata pada tiga bagian di berkas `lib/menu.dart`:
1. **Mengakses Skema Warna Tema (`Theme.of(context)`):**  
   Pada `AppBar` di dalam `MyHomePage`, pemanggilan `Theme.of(context).colorScheme.primary` menggunakan `context` untuk menelusuri *widget tree* ke atas hingga menemukan konfigurasi `ThemeData` milik `MaterialApp`, lalu mengambil warna utama (Indigo) sebagai warna latar `AppBar`.
2. **Mengukur Lebar Layar Perangkat (`MediaQuery.of(context)`):**  
   Pada metode `build` di kelas `InfoCard`, pemanggilan `MediaQuery.of(context).size.width / 3.5` menggunakan `context` milik `InfoCard` untuk mengambil informasi lebar layar dari `MediaQuery` leluhur, sehingga lebar setiap kartu identitas otomatis menyesuaikan ukuran layar secara proporsional.
3. **Menampilkan `SnackBar` pada Halaman (`ScaffoldMessenger.of(context)`):**  
   Pada properti `onTap` di dalam `ItemCard`, pemanggilan `ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(...)` menggunakan `context` untuk mencari `ScaffoldMessenger` terdekat di atas `ItemCard` agar dapat menutup *SnackBar* lama dan memunculkan *SnackBar* baru di bagian bawah `Scaffold`.

---

#### 6. Jelaskan konsep *hot reload* di Flutter dan apa perbedaannya dengan *hot restart*! Kapan kita tidak bisa hanya mengandalkan *hot reload* dan harus melakukan *hot restart* atau *full restart*?

**Jawaban:**  
Pada mode pengembangan (*debug mode*), Flutter menggunakan kompilasi *Just-In-Time* (JIT) yang memungkinkan dua mekanisme pembaruan kode secara langsung tanpa harus mengompilasi ulang seluruh aplikasi dari awal:

- **Hot Reload (`r`):**  
  *Hot reload* bekerja dengan cara menyuntikkan berkas kode sumber Dart yang baru saja diubah langsung ke dalam *Dart Virtual Machine* (VM) yang sedang berjalan. Setelah kode baru disuntikkan, Flutter secara otomatis membangun ulang (*rebuild*) *widget tree* dan menggambar ulang antarmuka layar **tanpa menghapus *state* aplikasi saat ini (*stateful hot reload*)**. Proses ini berlangsung sangat cepat (kurang dari satu detik) dan menjaga pengguna tetap berada di halaman maupun kondisi data yang sedang dibuka.
- **Hot Restart (`R`):**  
  *Hot restart* juga memperbarui kode di dalam *Dart VM*, tetapi dengan cara **mereset ulang seluruh kondisi *Dart VM* dan menghancurkan seluruh *state* yang tersimpan di memori**. Aplikasi akan memulai kembali eksekusi program dari fungsi `main()` dan `runApp()`, sehingga seluruh variabel maupun tampilan kembali ke kondisi awal pembukaan aplikasi. Waktu eksekusinya sedikit lebih lama dibanding *hot reload* (beberapa detik), namun tetap jauh lebih cepat dibandingkan *full restart*.

**Kondisi ketika kita TIDAK BISA hanya mengandalkan *Hot Reload* dan harus melakukan *Hot Restart* atau *Full Restart*:**
- **Kapan harus melakukan *Hot Restart* (`R`):**
  1. Ketika kita mengubah nilai inisialisasi variabel global, `static` fields, atau properti tingkat kelas yang sudah telanjur diinstansiasi sebelumnya (contohnya saat mengubah isi daftar `final List<ItemHomepage> items` atau atribut identitas apabila objek halaman dipertahankan di dalam *state*).
  2. Ketika kita mengubah logika di dalam fungsi `main()` atau metode siklus hidup `initState()`, karena kedua metode tersebut tidak dieksekusi ulang pada saat *hot reload*.
  3. Ketika kita mengubah jenis struktur kelas suatu *widget* secara fundamental, misalnya saat memodifikasi `MyHomePage` dari `StatefulWidget` menjadi `StatelessWidget` (atau sebaliknya).
- **Kapan harus melakukan *Full Restart* (menghentikan proses `flutter run` dengan `q` lalu menjalankannya kembali dari awal):**
  1. Ketika kita menambahkan atau memperbarui paket dependensi eksternal maupun aset (gambar/font) di dalam berkas `pubspec.yaml`.
  2. Ketika kita melakukan perubahan pada kode atau konfigurasi *native* platform di luar kode Dart, seperti mengubah berkas `build.gradle.kts` atau `AndroidManifest.xml` di folder `android/`, maupun mengubah konfigurasi di folder `ios/`, `macos/`, atau `web/`, karena *hot reload* dan *hot restart* hanya memperbarui kode Dart di dalam VM, bukan hasil kompilasi *native binary*.

---

#### Langkah Implementasi Checklist Tugas 7

Berikut adalah tahapan implementasi yang saya lakukan secara berurutan untuk memenuhi seluruh kriteria pada Tugas 7:

1. **Pemisahan Modul Antarmuka dan Konversi ke `StatelessWidget` (`lib/main.dart` & `lib/menu.dart`):**
   - Saya melanjutkan pengembangan pada repositori proyek `myportofolio_mobile` yang telah diinisialisasi pada Tutorial 08.
   - Pada berkas `lib/main.dart`, saya menyederhanakan kode agar hanya berfokus pada fungsi bootstrap `main()` dan kelas akar `MyApp` yang mengembalikan `MaterialApp` dengan skema warna Material 3 (`ColorScheme.fromSeed(seedColor: Colors.indigo)`), lalu mengimpor berkas `package:myportofolio_mobile/menu.dart`.
   - Pada berkas `lib/menu.dart`, saya mendefinisikan kelas `MyHomePage` sebagai turunan dari `StatelessWidget` karena seluruh informasi profil dan daftar menu aksi bersifat statis.

2. **Kustomisasi Identitas Pemilik pada Komponen `InfoCard`:**
   - Di dalam kelas `MyHomePage`, saya menetapkan variabel identitas sesuai data pribadi saya, yaitu `npm = '2506656835'`, `nama = 'Joceline Nadine Immanuella'`, dan `kelas = 'PBP A'`.
   - Saya membuat komponen *reusable* `InfoCard` yang membungkus `Card(elevation: 2.0)` dan `Container` dengan lebar proporsional `MediaQuery.of(context).size.width / 3.5`, lalu menata ketiga kartu tersebut secara sejajar menggunakan `Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly)`.

3. **Penambahan Atribut Warna Unik pada `ItemHomepage` dan `ItemCard`:**
   - Saya memodifikasi kelas model `ItemHomepage` di `lib/menu.dart` dengan menambahkan atribut `final Color color;` pada konstruktor `ItemHomepage(this.name, this.icon, this.color)`.
   - Saya mendefinisikan tiga objek tombol aksi di dalam daftar `items` dengan warna latar yang berbeda dan kontras satu sama lain:
     - `ItemHomepage("Lihat Proyek", Icons.folder, Colors.blue)` dengan warna latar **Biru**.
     - `ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green)` dengan warna latar **Hijau**.
     - `ItemHomepage("Logout", Icons.logout, Colors.red)` dengan warna latar **Merah**.
   - Pada widget `ItemCard`, saya mengganti properti warna latar `Material` menjadi `color: item.color` dengan sudut membulat `BorderRadius.circular(12)` dan menampilkannya dalam tata letak kisi 3 kolom menggunakan `GridView.count`.

4. **Implementasi Umpan Balik Interaktif `SnackBar`:**
   - Di dalam `ItemCard`, saya membungkus konten kartu dengan `InkWell` dan mengimplementasikan callback `onTap` yang memanggil `ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(...)`.
   - Setiap kali pengguna menekan salah satu kartu tombol, aplikasi secara responsif menyembunyikan *SnackBar* sebelumnya (jika ada) dan menampilkan `SnackBar` bertuliskan `"Kamu telah menekan tombol ${item.name}!"`.

5. **Penyesuaian Pengujian Otomatis dan Verifikasi Linter (`flutter analyze` & `flutter test`):**
   - Saya memperbarui berkas `test/widget_test.dart` untuk menguji keberadaan teks judul `'MyPortfolio'`, data identitas pada ketiga `InfoCard`, ketiga tombol `ItemCard`, serta simulasi ketukan (`tester.tap`) untuk memastikan `SnackBar` muncul dengan teks yang tepat.
   - Saya menjalankan `flutter analyze` dan memastikan hasilnya bersih (`No issues found!`), serta menjalankan `flutter test` dengan hasil seluruh pengujian lulus (`All tests passed!`).

---

### AI Disclosure (Pernyataan Penggunaan Kecerdasan Buatan)

Dalam pengerjaan Tugas Individu 7 PBP, saya memosisikan AI sebagai *study companion* untuk membantu memperkuat pemahaman logika saya mengenai arsitektur *widget tree* pada Flutter, siklus hidup `StatelessWidget` dan `StatefulWidget`, peran `BuildContext`, serta penerapan kustomisasi komponen Material Design, dengan rincian:

- **Alat Bantu:** Gemini (Google AI)
- **Tautan Log Diskusi:** [https://gemini.google.com/share/d/1Q865707QKe6A7wsmp-jXLEuSaIyha1z1?usp=sharing](https://gemini.google.com/share/d/1Q865707QKe6A7wsmp-jXLEuSaIyha1z1?usp=sharing)
- **Rincian Bantuan yang Dipelajari:**
  1. Memahami mekanisme tata letak *widget tree* di Flutter (*constraints go down, sizes go up, parent sets position*) serta memetakan hierarki komponen dari `MyApp` hingga `InfoCard` dan `ItemCard`.
  2. Memodifikasi model `ItemHomepage` untuk menyertakan atribut `final Color color` dan menghubungkannya ke properti `color: item.color` pada widget `Material` di `ItemCard` tanpa duplikasi kode.
  3. Menambahkan pembungkus `SingleChildScrollView` pada `body` halaman utama dan mengatur `primary: false` pada `GridView.count` secara mandiri agar tata letak halaman tetap responsif dan tidak mengalami *overflow* pada layar berukuran kecil.
  4. Menyelesaikan konfigurasi lingkungan macOS Apple Silicon dengan menautkan *binary* `dart` langsung ke SDK bawaan Flutter sehingga diagnostik `flutter doctor` terverifikasi bersih.
  5. Menyusun skenario pengujian otomatis pada `test/widget_test.dart` yang disesuaikan langsung dengan identitas pribadi (`2506656835` — `Joceline Nadine Immanuella` — `PBP A`) serta memverifikasi kualitas kode melalui `flutter analyze` (`No issues found!`).

Saya mengonfirmasi bahwa seluruh kode antarmuka Flutter, pemisahan berkas modul, kustomisasi warna komponen, serta pengujian widget pada proyek ini murni diimplementasikan, dianalisis menggunakan `flutter analyze`, diuji otomatis menggunakan `flutter test`, dan dikelola secara bertahap melalui sistem kontrol versi Git oleh saya sendiri.

# Proyek Portofolio Mobile - Pemrograman Berbasis Platform (CSGE602022)

- **Nama:** Joceline Nadine Immanuella
- **NPM:** 2506656835
- **Kelas:** PBP A
- **Program Studi:** Sistem Informasi, Fakultas Ilmu Komputer Universitas Indonesia
- **Repositori GitHub:** [https://github.com/jocelinenadine-dev/myportofolio_mobile](https://github.com/jocelinenadine-dev/myportofolio_mobile)

---

## Deskripsi Proyek

**MyPortfolio Mobile** (`myportofolio_mobile`) adalah aplikasi *mobile* multiplatform berbasis **Flutter** dan bahasa pemrograman **Dart** yang dikembangkan sebagai perluasan dari ekosistem web portofolio pribadi saya. Aplikasi ini dirancang menggunakan komponen antarmuka **Material Design 3** untuk menampilkan informasi identitas pemilik portofolio melalui komponen kartu (`InfoCard`), menyediakan navigasi lintas halaman melalui kartu aksi interaktif (`ItemCard`) serta panel navigasi samping (`LeftDrawer`), dan menyediakan halaman formulir tervalidasi untuk menambahkan data proyek (`ProjectFormPage`) maupun riwayat pengalaman (`ExperienceFormPage`).

---

## Ringkasan Progres Mingguan (Weekly Progress Tracker)

| Pekan / Tahap | Topik Materi | Fokus Implementasi Utama | Status Penyelesaian |
| :--- | :--- | :--- | :--- |
| **Tutorial 08** | Basic Flutter Setup & Widget | Instalasi Flutter SDK & Android SDK, inisialisasi proyek `myportofolio_mobile`, pemisahan modul `menu.dart`, dan pembuatan kerangka dasar `InfoCard` serta `ItemCard`. | Selesai (100%) |
| **Tugas 7** | Elemen Dasar Flutter | Kustomisasi identitas pribadi pada `InfoCard`, diferensiasi warna unik pada setiap `ItemCard` (`Colors.blue`, `Colors.green`, `Colors.red`), interaktivitas `SnackBar`, pengujian otomatis `widget_test.dart`, serta dokumentasi reflektif. | Selesai (100%) |
| **Tutorial 09** | Navigation, Layouts, Forms, & Input | Pembuatan panel navigasi `LeftDrawer`, halaman formulir `ProjectFormPage` beserta validasi dan dialog `AlertDialog`, serta *refactoring* struktur direktori ke `lib/screens/` dan `lib/widgets/`. | Selesai (100%) |
| **Tugas 8** | Flutter Navigation, Layouts, & Forms | Pembuatan halaman formulir baru `ExperienceFormPage` (`lib/screens/experience_form.dart`) dengan pemilih tanggal `showDatePicker()`, validasi komprehensif (teks wajib, panjang karakter, urutan tanggal, dan format URL), peningkatan antarmuka UI/UX bernuansa *Sage Green & Warm Ivory* responsif, integrasi navigasi pada `ItemCard` dan `LeftDrawer`, serta dokumentasi reflektif. | Selesai (100%) |
| **Tutorial 10** | Backend Integration, Auth, & CI/CD | Konfigurasi DRF `TokenAuthentication` dan CORS pada backend Django, pemodelan JSON dengan `json_serializable`, integrasi HTTP (`ApiClient`) dan `FutureBuilder` pada `ProjectListScreen`/`ProjectDetailScreen`, manajemen sesi `AuthState` (`Provider`), `LoginScreen` & `ensureLoggedIn`, serta *pipeline* CI/CD GitHub Actions (`.github/workflows/main.yaml`). | Selesai (100%) |

---

## Panduan Instalasi, Menjalankan Proyek, dan Pengujian (Setup, Run, & Test)

Berikut adalah langkah-langkah eksplisit untuk menyiapkan lingkungan pengembangan, menjalankan aplikasi, serta mengeksekusi analisis statis dan pengujian otomatis pada proyek ini:

### 1. Prasyarat Lingkungan (Prerequisites)
Pastikan perangkat telah terpasang **Flutter SDK** (kanal `stable`, versi `>= 3.x`), **Dart SDK** (terbundel bersama Flutter), **Android SDK**, serta peramban **Google Chrome**. Verifikasi kesiapan *toolchain* melalui terminal:
```bash
flutter doctor
```

### 2. Kloning Repositori, Instalasi Dependensi, dan Code Generation (Setup)
Unduh kode sumber dari repositori GitHub, pasang seluruh paket dependensi yang terdaftar pada `pubspec.yaml`, lalu bangkitkan berkas serialisasi JSON (`*.g.dart`):
```bash
git clone https://github.com/jocelinenadine-dev/myportofolio_mobile.git
cd myportofolio_mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### 3. Menjalankan Aplikasi (Run)
Pastikan server backend Django (`python manage.py runserver`) sedang berjalan. Untuk menjalankan aplikasi pada peramban web **Google Chrome**:
```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```
Untuk menjalankan aplikasi pada **Android Emulator** (otomatis mengarah ke `http://10.0.2.2:8000`):
```bash
flutter devices
flutter run
```
Saat aplikasi berjalan di terminal, tekan `r` untuk melakukan *Hot Reload*, `R` untuk melakukan *Hot Restart*, atau `q` untuk menghentikan sesi eksekusi.

### 4. Analisis Kualitas Kode dan Pengujian Otomatis (Format, Analyze, & Test)
Jalankan pemformatan kode, *static analysis*, dan pengujian otomatis:
```bash
dart format .
flutter analyze
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
Berikut adalah daftar seluruh *widget* yang saya gunakan di dalam berkas `lib/main.dart` dan `lib/screens/menu.dart` beserta fungsi spesifiknya pada aplikasi portofolio saya:

- **`MyApp` (`StatelessWidget`):** *Custom root widget* yang dijalankan pertama kali oleh fungsi `runApp()`. Fungsinya menginisialisasi konfigurasi global aplikasi melalui `MaterialApp`.
- **`MaterialApp`:** *Widget* pembungkus utama tingkat aplikasi yang menyediakan konfigurasi tema Material Design 3 (`ThemeData`), judul aplikasi (`title: 'MyPortfolio'`), sistem navigasi halaman, serta mengatur halaman awal aplikasi ke `MyHomePage()`.
- **`MyHomePage` (`StatelessWidget`):** *Custom widget* yang merepresentasikan halaman menu utama portofolio. Menyimpan data identitas pemilik (`npm`, `nama`, `kelas`) serta daftar objek menu `items`, lalu menyusun seluruh elemen antarmuka ke dalam `Scaffold`.
- **`Scaffold`:** Menyediakan kerangka dasar struktur visual halaman standar Material Design yang menampung bilah atas (`appBar`), panel samping (`drawer`), area konten utama (`body`), serta mendukung pemunculan pesan notifikasi bawah (`SnackBar`).
- **`AppBar`:** Menampilkan bilah navigasi di bagian paling atas halaman dengan judul `'MyPortfolio'` berwarna putih tebal dan warna latar yang diambil dari warna primer tema (`Theme.of(context).colorScheme.primary`).
- **`SingleChildScrollView`:** Membungkus konten utama pada `body` agar halaman dapat digulir (*scrollable*) secara vertikal apabila dibuka pada layar perangkat atau jendela browser yang ukurannya pendek, sehingga mencegah terjadinya *RenderFlex overflow*.
- **`Padding`:** Memberikan jarak ruang kosong di sekeliling *widget* anaknya, yaitu `EdgeInsets.all(16.0)` pada sekeliling `body` halaman, `EdgeInsets.only(top: 16.0)` di atas teks sambutan, serta `EdgeInsets.all(3)` di antara ikon dan teks pada kartu tombol.
- **`Column`:** Menyusun daftar *widget* anak secara berurutan dari atas ke bawah (vertikal). Digunakan pada susunan utama `body`, kelompok tengah pesan sambutan dan kisi tombol, susunan teks `title` dan `content` di dalam `InfoCard`, serta susunan ikon dan teks di dalam `ItemCard`.
- **`Row`:** Menyusun daftar *widget* anak secara berjajar dari kiri ke kanan (horizontal). Digunakan untuk menampilkan ketiga komponen `InfoCard` (*NPM*, *Name*, dan *Class*) secara sejajar dengan perataan jarak `MainAxisAlignment.spaceEvenly`.
- **`SizedBox`:** Memberikan ruang pemisah berdimensi tetap antar-elemen, yaitu `SizedBox(height: 16.0)` sebagai jarak vertikal antara baris `InfoCard` dengan bagian sambutan, serta `SizedBox(height: 8.0)` di antara judul dan isi di dalam `InfoCard`.
- **`Center`:** Menempatkan *widget* anaknya tepat di titik tengah area yang tersedia. Digunakan untuk memusatkan bagian teks sambutan beserta kisi tombol, serta memusatkan posisi ikon dan label di dalam setiap `ItemCard`.
- **`GridView.count`:** Menampilkan sekumpulan *widget* anak dalam tata letak kisi (*grid*) dengan jumlah kolom tetap (`crossAxisCount: 3`), jarak horizontal dan vertikal antar-kartu sebesar `10` piksel, serta `shrinkWrap: true` agar tinggi *grid* menyesuaikan isi dari `ItemCard`.
- **`InfoCard` (`StatelessWidget`):** *Reusable custom widget* yang saya buat untuk menampilkan kartu informasi identitas pemilik portofolio berdasarkan parameter `title` dan `content` tanpa perlu menulis ulang kode kartu berulang kali.
- **`Card`:** Komponen Material Design yang membungkus isi `InfoCard` ke dalam kotak bersudut membulat dengan efek bayangan kedalaman (*shadow*) sebesar `elevation: 2.0`.
- **`Container`:** *Widget* serbaguna untuk mengatur ukuran dimensi dan tata ruang internal, yang pada proyek ini digunakan untuk menetapkan lebar `InfoCard` secara proporsional (`MediaQuery.of(context).size.width / 3.5`) serta memberikan *padding* di dalam `InfoCard` dan `ItemCard`.
- **`ItemCard` (`StatelessWidget`):** *Reusable custom widget* yang merender setiap objek data `ItemHomepage` menjadi kartu tombol aksi interaktif lengkap dengan warna latar spesifik, ikon, teks, dan pemicu `SnackBar`.
- **`Material`:** Menyediakan permukaan kanvas Material Design pada `ItemCard` dengan warna latar yang diambil dari atribut `item.color` serta sudut membulat `BorderRadius.circular(12)` agar efek sentuhan `InkWell` dapat digambar di atasnya.
- **`InkWell`:** Menangkap interaksi ketukan pengguna (`onTap`) pada `ItemCard`, menampilkan animasi visual riak air (*ink ripple effect*) khas Material Design, dan menjalankan fungsi pemanggilan `SnackBar`.
- **`Icon`:** Menampilkan ikon grafis vektor dari katalog Material Icons berwarna putih dengan ukuran `30.0` di dalam masing-masing `ItemCard`.
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
Kita sebaiknya memilih `StatelessWidget` ketika tampilan suatu komponen atau halaman **sepenuhnya bergantung pada data informasi yang diberikan dari luar (konstruktor)** dan tidak memerlukan perubahan nilai variabel internal secara reaktif. Karena tidak perlu mengalokasikan objek `State` tambahan di memori, `StatelessWidget` lebih ringan dan efisien. Pada proyek `myportofolio_mobile` di Tugas 7 ini, kelas `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` semuanya tepat menggunakan `StatelessWidget` karena data NPM, Nama, Kelas, serta daftar tombol aksi bersifat tetap; interaksi ketukan pada tombol hanya memunculkan *overlay* `SnackBar` melalui `ScaffoldMessenger` tanpa memutasi properti di dalam `ItemCard`.

**Kapan harus menggunakan `StatefulWidget`?**  
Kita harus menggunakan `StatefulWidget` ketika tampilan *widget* perlu **berubah secara dinamis di layar sebagai respons terhadap interaksi pengguna, perubahan input, atau kedatangan data asinkron**, contohnya:
- Halaman formulir (*form*) untuk menambah proyek atau pengalaman baru yang memiliki *input field* teks, *dropdown*, pemilih tanggal, validasi *real-time*, atau *switch*.
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
Di dalam metode `Widget build(BuildContext context)`, objek `context` diterima sebagai parameter otomatis dan saya gunakan secara nyata pada tiga bagian utama:
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
   - Pada berkas `lib/main.dart`, saya menyederhanakan kode agar hanya berfokus pada fungsi bootstrap `main()` dan kelas akar `MyApp` yang mengembalikan `MaterialApp` dengan skema warna Material 3 (`ColorScheme.fromSeed(seedColor: Colors.indigo)`), lalu mengimpor berkas menu utama.
   - Pada berkas menu utama, saya mendefinisikan kelas `MyHomePage` sebagai turunan dari `StatelessWidget` karena seluruh informasi profil dan daftar menu aksi bersifat statis.

2. **Kustomisasi Identitas Pemilik pada Komponen `InfoCard`:**
   - Di dalam kelas `MyHomePage`, saya menetapkan variabel identitas sesuai data pribadi saya, yaitu `npm = '2506656835'`, `nama = 'Joceline Nadine Immanuella'`, dan `kelas = 'PBP A'`.
   - Saya membuat komponen *reusable* `InfoCard` yang membungkus `Card(elevation: 2.0)` dan `Container` dengan lebar proporsional `MediaQuery.of(context).size.width / 3.5`, lalu menata ketiga kartu tersebut secara sejajar menggunakan `Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly)`.

3. **Penambahan Atribut Warna Unik pada `ItemHomepage` dan `ItemCard`:**
   - Saya memodifikasi kelas model `ItemHomepage` dengan menambahkan atribut `final Color color;` pada konstruktor `ItemHomepage(this.name, this.icon, this.color)`.
   - Saya mendefinisikan tiga objek tombol aksi di dalam daftar `items` dengan warna latar yang berbeda dan kontras satu sama lain:
     - `ItemHomepage("Lihat Proyek", Icons.folder, Colors.blue)` dengan warna latar **Biru**.
     - `ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green)` dengan warna latar **Hijau**.
     - `ItemHomepage("Logout", Icons.logout, Colors.red)` dengan warna latar **Merah**.
   - Pada widget `ItemCard`, saya mengganti properti warna latar `Material` menjadi `color: item.color` dengan sudut membulat `BorderRadius.circular(12)` dan menampilkannya dalam tata letak kisi 3 kolom menggunakan `GridView.count`.

4. **Implementasi Umpan Balik Interaktif `SnackBar`:**
   - Di dalam `ItemCard`, saya membungkus konten kartu dengan `InkWell` dan mengimplementasikan callback `onTap` yang memanggil `ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(...)`.
   - Setiap kali pengguna menekan salah satu kartu tombol, aplikasi secara responsif menyembunyikan *SnackBar* sebelumnya (jika ada) dan menampilkan `SnackBar` bertuliskan `"Kamu telah menekan tombol ${item.name}!"`.

5. **Penyesuaian Pengujian Otomatis dan Verifikasi Linter (`flutter analyze` & `flutter test`):**
   - Saya memperbarui berkas `test/widget_test.dart` untuk menguji keberadaan teks judul `'MyPortfolio'`, data identitas pada ketiga `InfoCard`, tombol `ItemCard`, serta simulasi ketukan (`tester.tap`) untuk memastikan `SnackBar` muncul dengan teks yang tepat.
   - Saya menjalankan `flutter analyze` dan memastikan hasilnya bersih (`No issues found!`), serta menjalankan `flutter test` dengan hasil seluruh pengujian lulus (`All tests passed!`).

---

#### AI Disclosure (Pernyataan Penggunaan Kecerdasan Buatan) - Tugas 7

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

---

### Tugas 8

#### 1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi `Home` di drawer membawa pengguna kembali ke halaman utama.

**Jawaban:**  
Pada Flutter, perpindahan antar-halaman (*routing*) dikelola oleh widget `Navigator` yang mengimplementasikan struktur data tumpukan (*stack* dengan prinsip *Last-In, First-Out* / LIFO), di mana halaman yang berada paling atas tumpukan (*top of stack*) adalah halaman yang sedang aktif ditampilkan di layar pengguna. Perbedaan ketiga metode manipulasi tumpukan tersebut adalah sebagai berikut:

- **`Navigator.push(context, route)`:**  
  Menambahkan (*push*) sebuah halaman atau `Route` baru tepat di atas halaman yang sedang aktif di dalam *navigation stack* tanpa menghapus halaman sebelumnya. Karena halaman sebelumnya masih tersimpan di bawahnya di dalam tumpukan, Flutter secara otomatis menyediakan tombol kembali (*Back button*) pada `AppBar` (maupun mendukung tombol kembali bawaan perangkat) sehingga pengguna dapat kembali ke halaman asal dengan mudah.
- **`Navigator.pushReplacement(context, newRoute)`:**  
  Menambahkan halaman baru ke puncak tumpukan sekaligus **menghapus atau menggantikan halaman yang sedang aktif saat itu** dari *navigation stack*. Akibatnya, pengguna tidak dapat kembali ke halaman yang baru saja ditinggalkan menggunakan tombol *Back*, sehingga mencegah penumpukan halaman berulang tanpa batas di memori ketika pengguna berpindah-pindah menu utama melalui *drawer*.
- **`Navigator.pop(context)`:**  
  Menghapus (*pop*) rute atau lapisan paling atas dari *navigation stack* saat ini dan mengembalikan tampilan ke halaman atau lapisan yang berada tepat di bawahnya. Pada proyek ini, `Navigator.pop(context)` digunakan pada tombol `'OK'` di dalam `AlertDialog` untuk menutup lapisan dialog pop-up dan mengembalikan fokus pengguna ke halaman formulir.

**Metode yang digunakan untuk membuka formulir dari kartu aksi (`ItemCard`):**  
Pada berkas `lib/widgets/project_card.dart`, ketika pengguna menekan kartu aksi `"Tambah Proyek"` atau `"Tambah Pengalaman"`, metode yang saya gunakan adalah **`Navigator.push()`**:
```dart
if (item.name == "Tambah Pengalaman") {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ExperienceFormPage(),
    ),
  );
}
```
Pemilihan `Navigator.push()` pada kartu aksi sangat tepat karena halaman utama (`MyHomePage`) tetap dipertahankan di dasar tumpukan (*stack*), sehingga pengguna yang masuk ke formulir dari kartu menu dapat langsung menekan tombol *Back* untuk kembali ke halaman utama.

**Bagaimana opsi `Home` di `LeftDrawer` membawa pengguna kembali ke halaman utama:**  
Pada berkas `lib/widgets/left_drawer.dart`, opsi `ListTile` **`Home`** menggunakan metode **`Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()))`**. Ketika pengguna sedang berada di halaman formulir (`ExperienceFormPage` atau `ProjectFormPage`) lalu membuka *drawer* dan menekan opsi `Home`, `Navigator.pushReplacement()` akan menggantikan halaman formulir yang sedang aktif di puncak tumpukan dengan instansiasi baru dari `MyHomePage()`. Dengan demikian, pengguna langsung dibawa kembali ke tampilan halaman utama portofolio secara bersih tanpa menyisakan halaman formulir di tumpukan navigasi—mekanisme ini sangat membantu terutama saat pengujian di peramban Google Chrome ketika berpindah antar-menu tingkat atas.

---

#### 2. Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

**Jawaban:**  
Konsistensi struktur visual antar-halaman pada aplikasi `myportofolio_mobile` dijaga melalui pola komposisi kerangka halaman yang seragam menggunakan tiga komponen Material Design:

- **Peran `Scaffold` sebagai Kerangka Standar Halaman:**  
  Setiap layar penuh di dalam folder `lib/screens/`—yakni `MyHomePage` (`menu.dart`), `ProjectFormPage` (`project_form.dart`), dan `ExperienceFormPage` (`experience_form.dart`)—menggunakan `Scaffold` sebagai *widget* pembungkus utamanya. `Scaffold` memastikan setiap halaman memiliki slot tata letak standar yang berada di posisi yang sama, yaitu `appBar` di bagian atas, `drawer` di panel samping kiri, dan `body` di area konten utama.
- **Peran `AppBar` sebagai Identitas Navigasi Atas:**  
  Pada ketiga halaman, `AppBar` ditempatkan pada slot `appBar` milik `Scaffold` dengan tipografi judul berwarna putih tebal (`Colors.white`, `FontWeight.bold`) serta `iconTheme: const IconThemeData(color: Colors.white)`. Keberadaan `AppBar` di setiap `Scaffold` juga secara otomatis merender ikon *hamburger menu* (garis tiga) di pojok kiri atas apabila properti `drawer` disertakan, sehingga pengguna selalu menemukan titik akses navigasi di posisi yang identik.
- **Peran Komponen Reusable `LeftDrawer` (`Drawer`):**  
  Alih-alih menulis ulang kode panel navigasi di setiap halaman, seluruh logika dan tampilan `Drawer` dienkapsulasi ke dalam satu komponen *reusable* `LeftDrawer` pada berkas `lib/widgets/left_drawer.dart`, lalu dipasang melalui properti `drawer: const LeftDrawer()` pada `Scaffold` di `MyHomePage`, `ProjectFormPage`, maupun `ExperienceFormPage`. Hal ini menjamin bahwa dari halaman mana pun pengguna membuka *drawer*, urutan menu (*Home*, *Add Project*, dan *Add Experience*) serta tampilan `DrawerHeader` selalu konsisten 100%.

**Contoh konkret penggunaan warna tema portofolio di lebih dari satu halaman:**  
Di dalam berkas `lib/main.dart`, saya mendefinisikan tema global `MaterialApp` bernuansa *Sage Green & Warm Ivory* menggunakan `ColorScheme.fromSeed(seedColor: const Color(0xFF3E6353), primary: const Color(0xFF3E6353), secondary: const Color(0xFFC59B43))` serta `scaffoldBackgroundColor: const Color(0xFFF6F7F4)` agar selaras dengan identitas visual web portofolio saya. Warna primer dari skema tema tersebut (`Theme.of(context).colorScheme.primary`) digunakan secara konsisten di seluruh halaman:
1. Pada halaman utama **`MyHomePage`** (`lib/screens/menu.dart`), `Theme.of(context).colorScheme.primary` digunakan untuk warna `AppBar`, gradasi banner profil sambutan, serta aksen ikon pada setiap `InfoCard`.
2. Pada halaman formulir **`ExperienceFormPage`** (`lib/screens/experience_form.dart`) dan **`ProjectFormPage`** (`lib/screens/project_form.dart`), `Theme.of(context).colorScheme.primary` digunakan kembali pada `backgroundColor` milik `AppBar`, indikator aktif `SwitchListTile`, warna fokus `InputDecorationTheme`, serta warna latar tombol aksi **`Simpan`** dan tombol **`OK`** pada `AlertDialog`.
3. Pada panel navigasi **`LeftDrawer`** (`lib/widgets/left_drawer.dart`), warna primer dan sekunder tema (`colorScheme.primary` dan `colorScheme.secondary`) digunakan pada gradasi `DrawerHeader` dan aksen lencana kelas.

Dengan merujuk langsung pada `Theme.of(context).colorScheme`, seluruh halaman otomatis menampilkan identitas warna *Sage Green* portofolio yang serasi tanpa perlu menuliskan kode warna berulang secara manual.

---

#### 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

**Jawaban:**  
Pada halaman formulir `ExperienceFormPage` (`lib/screens/experience_form.dart`) dan `ProjectFormPage` (`lib/screens/project_form.dart`), saya memilih struktur tata letak **`Form` -> `SingleChildScrollView` -> `Center` -> `ConstrainedBox(maxWidth: 680)` -> `Container` (kartu putih) -> `Column(crossAxisAlignment: CrossAxisAlignment.start)`** yang menyusun elemen-elemen input secara vertikal dikelompokkan per kategori (*Informasi Utama*, *Periode & Status*, dan *Detail & Dokumentasi*), diikuti tombol **`Simpan`** selebar penuh (`SizedBox(width: double.infinity)`).

**Alasan pemilihan tata letak vertikal (`Column`) dan pembatas lebar (`ConstrainedBox`):**  
Pada perangkat *mobile* yang berorientasi *portrait* (lebar layar sempit namun memanjang ke bawah), penyusunan kolom input secara vertikal dari atas ke bawah adalah pola yang paling ergonomis karena setiap `TextFormField` dan `DropdownButtonFormField` memperoleh lebar penuh sehingga label, *hint text*, ikon prefiks, dan pesan kesalahan validasi dapat dibaca tanpa terpotong. Sementara itu, penambahan `Center` dan `ConstrainedBox(maxWidth: 680)` menjaga agar ketika aplikasi dibuka pada jendela peramban lebar seperti Google Chrome, kartu formulir tetap terpusat secara proporsional dan tidak melar memenuhi seluruh lebar monitor.

**Peran *widget* penggulir (`SingleChildScrollView`) ketika ruang layar terbatas:**  
Widget `Column` secara bawaan tidak dapat digulir (*non-scrollable*) dan akan melempar kesalahan **`RenderFlex overflowed by ... pixels on the bottom`** apabila total tinggi seluruh anak di dalamnya melebihi tinggi ruang layar yang tersisa. Pada halaman formulir, ruang vertikal layar sering kali menyempit secara drastis karena dua hal:
1. Ketika pengguna mengetuk `TextFormField` pada perangkat ponsel, **papan ketik virtual (*on-screen keyboard*) akan muncul dari bawah dan mengambil hampir separuh tinggi layar**.
2. Ketika validasi gagal, setiap `TextFormField` akan bertambah tinggi untuk merender baris teks pesan *error* berwarna merah di bawah kotak input, ditambah adanya kolom *multiline* seperti *Deskripsi Pengalaman* (`maxLines: 4`).

Dengan membungkus isi formulir di dalam **`SingleChildScrollView`** (baik pada `body` formulir maupun pada `content` di dalam `AlertDialog`), seluruh rangkaian input hingga tombol **`Simpan`** di bagian paling bawah tetap dapat digulir (*scrolled*) dan dijangkau dengan aman pada layar ponsel berukuran kecil maupun saat *keyboard* sedang terbuka.

**Peran *widget* pengatur jarak (`Padding` dan `SizedBox`):**  
Tanpa ruang pemisah, kotak-kotak `OutlineInputBorder` dari setiap `TextFormField` akan saling menempel rapat dan menyulitkan ketukan jari pengguna (*touch target crowding*). Penggunaan `Padding` antar-field (`EdgeInsets.only(bottom: 14.0)`), padding kartu (`EdgeInsets.all(24.0)`), dan `SizedBox` menciptakan ruang bernapas (*whitespace*) yang konsisten, memisahkan tiap kelompok informasi secara jelas, dan mencegah kesalahan ketuk antar-kolom.

---

#### 4. Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol `Simpan` ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

**Jawaban:**  
Ketiga komponen tersebut bekerja secara berantai untuk menegakkan integritas data formulir sebelum data diproses lebih lanjut:

- **Peran `GlobalKey<FormState>` (`_formKey`):**  
  Berfungsi sebagai pengenal unik lintas-*widget tree* sekaligus pemegang referensi langsung ke objek `FormState` internal milik widget `Form(key: _formKey, ...)`. Melalui `_formKey.currentState`, kode pada tombol `Simpan` dapat mengakses dan mengendalikan kondisi seluruh *field* di dalam formulir secara terpusat (seperti menjalankan validasi massal melalui `validate()` atau mengosongkan kembali seluruh isian melalui `reset()`).
- **Peran properti `validator` pada setiap *FormField*:**  
  Merupakan fungsi *callback* (`String? Function(String?)`) yang didefinisikan pada masing-masing `TextFormField`. Tugasnya adalah memeriksa nilai masukan (`value`) pada satu *field* spesifik terhadap aturan bisnis model: apabila nilai tidak memenuhi syarat, fungsi ini mengembalikan `String` berisi pesan kesalahan yang akan langsung dirender berwarna merah di bawah *field* tersebut; sebaliknya, apabila nilai sudah valid, fungsi ini mengembalikan `null`.
- **Peran metode `validate()` (`_formKey.currentState!.validate()`):**  
  Ketika tombol **`Simpan`** ditekan, pemanggilan `_formKey.currentState!.validate()` secara otomatis memicu eksekusi fungsi `validator` pada **setiap** `FormField` yang berada di bawah naungan `Form` tersebut. Jika seluruh `validator` mengembalikan `null`, maka `validate()` menghasilkan nilai `true` dan `AlertDialog` ringkasan data ditampilkan. Namun, jika ada satu saja `validator` yang mengembalikan teks pesan kesalahan, maka `validate()` menghasilkan `false`, membatalkan pemunculan dialog, dan menampilkan pesan kesalahan pada seluruh kolom yang bermasalah.

**Contoh konkret nilai yang ditolak oleh validasi pada `ExperienceFormPage`:**
1. **Input kosong atau hanya berisi karakter spasi (`"   "`):** Pada kolom *Judul / Posisi Pengalaman*, masukan `"   "` ditolak oleh kondisi `value == null || value.trim().isEmpty` dengan pesan `"Judul pengalaman tidak boleh kosong!"`.
2. **Input terlalu pendek (`"AB"`):** Pada kolom *Judul / Posisi Pengalaman*, masukan `"AB"` (2 karakter) ditolak oleh kondisi `value.trim().length < 3` dengan pesan `"Judul pengalaman minimal 3 karakter!"`.
3. **Urutan tanggal tidak logis:** Apabila *Tanggal Mulai* dipilih `2026-10-15` sedangkan *Tanggal Selesai* dipilih `2026-09-01` (mendahului tanggal mulai), validator menolak input tersebut melalui pemeriksaan `_endDate!.isBefore(_startDate!)` dengan pesan `"Tanggal selesai tidak boleh mendahului tanggal mulai!"`.
4. **Format tautan tidak valid (`"dokumentasi-kegiatan"` atau `"ftp://link"`):** Pada kolom *Tautan Dokumentasi / Sertifikat*, nilai yang tidak diawali skema `http://` atau `https://` serta domain yang valid ditolak dengan pesan `"Format URL tidak valid! Gunakan awalan http:// atau https://"`.

**Mengapa memilih jenis input atau papan ketik (`keyboardType`) saja belum cukup?**  
Mengatur properti seperti `keyboardType: TextInputType.url` atau `TextInputType.number` hanya berfungsi sebagai **petunjuk antarmuka (*UI convenience*)** untuk menyesuaikan tata letak tombol papan ketik virtual di layar ponsel (misalnya menampilkan tombol `/` dan `.com`), tetapi **sama sekali tidak membatasi atau menjamin kebenaran nilai yang masuk**:
- Pengguna tetap dapat mengetikkan teks sembarang yang bukan URL valid (seperti `"abc"` atau spasi kosong), atau melakukan *copy-paste* teks yang salah ke dalam kolom tersebut.
- Pada peramban desktop (seperti Google Chrome) atau saat menggunakan papan ketik fisik eksternal, pengaturan `keyboardType` tidak mencegah pengguna menekan tombol karakter apa pun.
- Aturan logika lintas-atribut—seperti kewajiban bahwa *Tanggal Selesai* tidak boleh lebih lampau dari *Tanggal Mulai* (`_endDate >= _startDate`) atau panjang minimal deskripsi 10 karakter—tidak mungkin ditegakkan hanya oleh jenis komponen input atau `showDatePicker()` semata, melainkan wajib diperiksa secara eksplisit di dalam fungsi `validator`.

---

#### Langkah Implementasi Checklist Tugas 8

Berikut adalah tahapan implementasi yang saya lakukan untuk menyelesaikan Tugas 8 secara menyeluruh:

1. **Pembuatan Halaman Formulir Baru `ExperienceFormPage` (`lib/screens/experience_form.dart`):**
   - Saya membuat berkas baru `lib/screens/experience_form.dart` yang mendefinisikan `ExperienceFormPage` sebagai `StatefulWidget` dengan `_formKey = GlobalKey<FormState>()`, disesuaikan dengan model `Experience` pada portofolio pribadi saya.
   - Saya menyediakan 8 komponen input yang relevan dengan tipe datanya:
     - `TextFormField` untuk **Judul / Posisi Pengalaman** (`_title`) dan **Organisasi / Institusi Penyelenggara** (`_organization`).
     - `DropdownButtonFormField<String>` dengan `initialValue` untuk **Kategori Pengalaman** (`_category`).
     - `TextFormField` (`readOnly: true`) yang terhubung dengan dialog kalender **`showDatePicker()`** untuk **Tanggal Mulai** (`_startDate`) dan **Tanggal Selesai** (`_endDate`).
     - `SwitchListTile` untuk status **Masih Berlangsung (Ongoing)** (`_isOngoing`) yang secara dinamis menyembunyikan kolom Tanggal Selesai apabila pengalaman masih aktif dijalani.
     - `TextFormField` *multiline* (`maxLines: 4`) untuk **Deskripsi Pengalaman** (`_description`) dan `TextFormField` (`keyboardType: TextInputType.url`) untuk **Tautan Dokumentasi / Sertifikat** (`_proofUrl`).

2. **Penerapan Validasi Input Sesuai Aturan Model:**
   - Saya menolak seluruh input wajib yang kosong atau hanya berisi spasi menggunakan `.trim().isEmpty`.
   - Saya memeriksa batas panjang karakter pada judul (3–100 karakter), organisasi (2–100 karakter), dan deskripsi (minimal 10 karakter).
   - Saya menerapkan validasi urutan tanggal (`_endDate!.isBefore(_startDate!)`) agar tanggal selesai tidak dapat mendahului tanggal mulai, serta validasi format URL (`http://` atau `https://`) menggunakan `Uri.tryParse`.

3. **Integrasi Navigasi pada Halaman Utama (`menu.dart` & `project_card.dart`) dan `LeftDrawer` (`left_drawer.dart`):**
   - Pada `lib/screens/menu.dart`, saya menambahkan kartu aksi baru `ItemHomepage("Tambah Pengalaman", Icons.work_history_outlined, const Color(0xFF0F766E))` ke dalam daftar `items`.
   - Pada `lib/widgets/project_card.dart`, saya menambahkan percabangan pada `onTap` untuk membuka `ExperienceFormPage` menggunakan **`Navigator.push()`** ketika kartu `"Tambah Pengalaman"` ditekan.
   - Pada `lib/widgets/left_drawer.dart`, saya mempertahankan opsi **`Home`** dan **`Add Project`**, lalu menambahkan opsi ketiga **`Add Experience`** (`Icons.work_outline`) yang membuka `ExperienceFormPage`, serta memasang `LeftDrawer` yang sama pada `Scaffold` di `ExperienceFormPage`.

4. **Implementasi Tombol Simpan dan Ringkasan `AlertDialog`:**
   - Saya menempatkan tombol **`Simpan`** di bagian bawah formulir yang memanggil `_formKey.currentState!.validate()`.
   - Apabila seluruh input valid, aplikasi memanggil `showDialog()` untuk menampilkan `AlertDialog` berjudul `'Pengalaman berhasil disimpan!'` yang memuat seluruh rincian isian pengguna, dilengkapi tombol `'OK'` yang memanggil `Navigator.pop(context)` serta mereset kondisi formulir.

5. **Peningkatan Antarmuka UI/UX Responsif (*Sage Green & Warm Ivory*):**
   - Saya menyelaraskan identitas visual aplikasi mobile dengan tema web portofolio saya pada `lib/main.dart` menggunakan palet *Sage Green* (`#3E6353`), aksen *Warm Gold* (`#C59B43`), dan latar *Warm Ivory* (`#F6F7F4`), serta `InputDecorationTheme` terpusat.
   - Saya menambahkan *Hero Profile Banner*, ikon pada tiap `InfoCard` dengan tinggi sejajar (`IntrinsicHeight`), kisi tombol responsif (`LayoutBuilder` 4 kolom pada layar lebar dan 2 kolom pada layar sempit), pembungkus `ConstrainedBox` agar tata letak proporsional di peramban Chrome, serta kartu putih terstruktur pada halaman formulir.

6. **Pengujian Otomatis dan Verifikasi `flutter analyze`:**
   - Saya memperbarui `test/widget_test.dart` untuk menguji navigasi dari kartu `"Tambah Pengalaman"` menuju `ExperienceFormPage` sekaligus memverifikasi kemunculan pesan kesalahan validasi ketika tombol `Simpan` ditekan pada kondisi kosong.
   - Saya menjalankan `flutter analyze` (`No issues found!`) dan `flutter test` (`All tests passed!`).

---

#### AI Disclosure (Pernyataan Penggunaan Kecerdasan Buatan) - Tugas 8

Dalam pengerjaan Tugas Individu 8 PBP, saya memosisikan AI sebagai *study companion* untuk membantu memperkuat pemahaman saya mengenai manajemen tumpukan navigasi (`Navigator`), perancangan tata letak formulir responsif di Flutter, integrasi pemilih tanggal `showDatePicker()`, serta mekanisme validasi `FormState`, dengan rincian:

- **Alat Bantu:** Gemini (Google AI)
- **Tautan Log Diskusi:** [https://gemini.google.com/share/d/1mQLqCvQYmf58mOVMyPKShEdZcwzhkXkV?usp=sharing](https://gemini.google.com/share/d/1mQLqCvQYmf58mOVMyPKShEdZcwzhkXkV?usp=sharing)
- **Rincian Bantuan yang Dipelajari & Evaluasi Kritis Mandiri:**
  1. Memahami perbedaan perilaku *navigation stack* antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`, sehingga dapat memilih `Navigator.push()` untuk navigasi dari kartu aksi `ItemCard` (agar tombol *Back* tetap berfungsi) dan `Navigator.pushReplacement()` untuk perpindahan menu tingkat atas melalui `LeftDrawer`.
  2. Merancang halaman formulir baru `ExperienceFormPage` (`lib/screens/experience_form.dart`) yang diselaraskan secara mandiri dengan atribut model `Experience` pada portofolio pribadi saya (judul posisi, organisasi, kategori, tanggal mulai, status *ongoing*, tanggal selesai, deskripsi, dan tautan dokumentasi).
  3. Mengidentifikasi keterbatasan contoh input dasar yang umumnya hanya memakai `TextFormField` biasa untuk tanggal; saya secara mandiri mengintegrasikan dialog kalender `showDatePicker()` menggunakan `TextEditingController` dan `SwitchListTile` untuk status *ongoing*, disertai validasi urutan kronologis tanggal (`_endDate` tidak boleh mendahului `_startDate`).
  4. Menambahkan validasi `.trim()` untuk menolak masukan yang hanya berisi spasi, validasi batas panjang karakter, serta validasi skema URL (`Uri.tryParse` dengan pemeriksaan `http`/`https`) pada kolom tautan dokumentasi.
  5. Menyusun pengujian widget otomatis pada `test/widget_test.dart` untuk menguji alur navigasi dan validasi formulir, serta memastikan seluruh kode bebas dari temuan *linter* melalui `flutter analyze` (`No issues found!`).

Saya mengonfirmasi bahwa seluruh kode halaman formulir, logika validasi, integrasi navigasi *drawer* dan kartu aksi, serta pengujian otomatis pada proyek ini murni diimplementasikan, dianalisis menggunakan `flutter analyze`, diuji menggunakan `flutter test`, dan dikelola secara bertahap melalui sistem kontrol versi Git oleh saya sendiri.

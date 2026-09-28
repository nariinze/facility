# CampusGo

Aplikasi reservasi fasilitas kampus. Login dummy: NIM `21si123`, password `campusgo123`.

## Analisis Kuis

### Soal 1: Widget tree detail

Contoh jalur dari root detail sampai teks:

```text
Scaffold (single: body)
└─ SafeArea (single: child)
	 └─ SingleChildScrollView (single: child)
			└─ Column (multi: children)
				 └─ Padding (single: child)
						└─ Column (multi: children)
							 └─ Row (multi: children)
									└─ Expanded (single: child)
										 └─ Text (leaf)
```

Pada implementasi, baris detail dibangun melalui `_DetailRow`; `Row` dan `Column` menerima banyak anak, sedangkan `Scaffold`, `SafeArea`, `SingleChildScrollView`, `Padding`, dan `Expanded` masing-masing membungkus satu anak.

### Soal 2: State reservasi

Dua masalah konsep: `StatelessWidget` adalah konfigurasi immutable, sehingga field mutable `isReserved` bukan state widget yang dikelola framework; dan mengubah field biasa tanpa `setState` tidak meminta Flutter menjalankan ulang `build()`. Gunakan `StatefulWidget` dan ubah status di dalam `setState`:

```dart
class FacilityDetailPage extends StatefulWidget {
	final FacilityModel facility;
	const FacilityDetailPage({super.key, required this.facility});

	@override
	State<FacilityDetailPage> createState() => _FacilityDetailPageState();
}

class _FacilityDetailPageState extends State<FacilityDetailPage> {
	bool isReserved = false;

	@override
	Widget build(BuildContext context) => ElevatedButton(
				onPressed: widget.facility.isAvailable
						? () => setState(() => isReserved = true)
						: null,
				child: Text(isReserved ? 'Reservasi Berhasil' : 'Reservasi'),
			);
}
```

### Soal 3: Daftar dalam Column

Potongan tersebut, jika berdiri sendiri di `Scaffold.body` dengan lima fasilitas dan ruang yang cukup, tetap merender item. Jadi klaim “tidak ada item” tidak dapat disimpulkan dari kode yang diberikan saja. `Column` bukan scrollable: jika tinggi anak melampaui constraint, Flutter memberi overflow/error; jika ditempatkan dalam parent dengan constraint tidak layak, layout juga bisa gagal. Untuk daftar yang dapat discroll dan dibuat efisien, gunakan `ListView.builder`:

```dart
body: ListView.builder(
	itemCount: facilities.length,
	itemBuilder: (context, index) {
		final item = facilities[index];
		return ListTile(
			title: Text(item.name),
			onTap: () => Navigator.push(
				context,
				MaterialPageRoute(
					builder: (_) => FacilityDetailPage(facility: item),
				),
			),
		);
	},
),
```

### Soal 4: Perubahan data bukan rebuild

Nilai yang berubah di memori belum otomatis membuat UI berubah. State adalah memori yang dikelola untuk sebuah `StatefulWidget`; Flutter menjadwalkan ulang `build()` saat perubahan state dilaporkan, umumnya melalui `setState`. Mengubah field objek lalu `print()` hanya membuktikan nilai objek berubah, bukan bahwa framework mengetahui dependensi UI tersebut berubah. Di contoh model ini `isAvailable` juga `final`, sehingga tidak boleh dimutasi. Simpan ketersediaan/reservasi lokal di state atau ganti model immutable lewat `setState`, lalu biarkan `build()` membaca nilai terbaru.

### Soal 5: Back stack

Login diimplementasikan dengan `pushReplacement`, jadi login tidak tersisa di stack sesudah autentikasi. Dari detail, setelah membuka Riwayat stack menjadi `[Root, Detail, Riwayat]` dan Riwayat tampil. Back pertama menghasilkan `[Root, Detail]` (Detail tampil); back kedua `[Root]` (Root tampil); back ketiga tidak punya route sebelumnya sehingga meminta aplikasi menutup/menangani back di Root, bukan kembali ke Login. Jika memakai ilustrasi stack biasa yang tidak menghapus Login, hasilnya `[Login, Root, Detail, Riwayat]` → `[Login, Root, Detail]` → `[Login, Root]` → `[Login]`.

### Soal 6: Konfirmasi reservasi

**Conditional rendering di halaman yang sama** memudahkan mempertahankan konteks fasilitas dan state lokal, menghindari route tambahan, dan memberi umpan balik cepat. Kekurangannya, halaman detail menanggung lebih banyak state/kondisi UI dan status sementara dapat hilang saat halaman dibuat ulang atau ditutup.

**Halaman konfirmasi terpisah dengan `push()`** memberi layar sukses yang fokus, mendukung tombol/aksi lanjutan khusus konfirmasi, dan memisahkan tanggung jawab tampilan. Kekurangannya, perlu mengirim data reservasi antar-route serta mengelola hasil/back stack; pengguna juga harus menavigasi kembali untuk melanjutkan konteks detail dan state dapat lebih rumit disinkronkan.

### Soal 7: Voucher opsional

Parameter named nullable yang tidak `required` otomatis bernilai `null` bila tidak diberikan:

```dart
class ReservationConfirmationPage extends StatelessWidget {
	final String? voucherCode;

	const ReservationConfirmationPage({
		super.key,
		this.voucherCode,
	});

	@override
	Widget build(BuildContext context) => Text(voucherCode ?? 'Tanpa voucher');
}
```

Pemanggilan boleh `ReservationConfirmationPage()` atau `ReservationConfirmationPage(voucherCode: 'HEMAT10')`. `required` tidak tepat karena voucher memang opsional.

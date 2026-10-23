import 'dart:io';

void main() {
  // Kode produk menjadi kunci, sedangkan detail produk disimpan dalam record.
  final Map<String, ({String nama, String kategori, int harga})> katalog = {
    'P01': (nama: 'Kopi Sidikalang 250 g', kategori: 'Kopi', harga: 45000),
    'P02': (nama: 'Kopi Gayo 250 g', kategori: 'Kopi', harga: 55000),
    'P03': (nama: 'Teh Kayu Aro 100 g', kategori: 'Teh', harga: 25000),
    'P04': (nama: 'Gula Aren 500 g', kategori: 'Pemanis', harga: 30000),
    'P05': (nama: 'Bolu Meranti', kategori: 'Makanan', harga: 80000),
  };

  print('TOKO OLEH-OLEH MEDAN');
  print('Kasir: Micael Zecsen Saragih');
  print('=' * 65);

  final judul =
      'Kode'.padRight(7) +
      'Nama Produk'.padRight(27) +
      'Kategori'.padRight(13) +
      'Harga (Rp)'.padLeft(12);

  print(judul);
  print('-' * 65);

  for (final item in katalog.entries) {
    final produk = item.value;

    final baris =
        item.key.padRight(7) +
        produk.nama.padRight(27) +
        produk.kategori.padRight(13) +
        produk.harga.toString().padLeft(12);

    print(baris);
  }

  print('=' * 65);

  stdout.write('Pesanan (contoh: P01x2, P03x1): ');
  final input = stdin.readLineSync() ?? '';

  // List menyimpan pesanan yang valid dan alasan penolakan.
  final pesananValid =
      <({String nama, String kategori, int harga, int jumlah})>[];
  final ditolak = <String>[];

  if (input.trim().isEmpty) {
    ditolak.add('Pesanan kosong.');
  } else {
    for (final item in input.split(',')) {
      final teks = item.trim();

      // Huruf X besar juga diterima sebagai pemisah.
      final bagian = teks.toLowerCase().split('x');

      if (bagian.length != 2) {
        ditolak.add('"$teks": format harus seperti P01x2.');
        continue;
      }

      final kode = bagian[0].trim().toUpperCase();
      final jumlah = int.tryParse(bagian[1].trim());

      // Pencarian Map bisa menghasilkan null jika kode tidak ada.
      final produk = katalog[kode];

      if (produk == null) {
        ditolak.add('"$teks": kode produk tidak ditemukan.');
        continue;
      }

      if (jumlah == null || jumlah <= 0) {
        ditolak.add('"$teks": jumlah harus bilangan bulat lebih dari nol.');
        continue;
      }

      // Setelah pengecekan, produk dan jumlah sudah pasti bukan null.
      pesananValid.add((
        nama: produk.nama,
        kategori: produk.kategori,
        harga: produk.harga,
        jumlah: jumlah,
      ));
    }
  }

  // map mengubah setiap pesanan menjadi item dengan subtotal.
  final rincian = pesananValid.map((item) {
    return (
      nama: item.nama,
      kategori: item.kategori,
      harga: item.harga,
      jumlah: item.jumlah,
      subtotal: item.harga * item.jumlah,
    );
  }).toList();

  // fold menjumlahkan subtotal mulai dari nilai awal 0.
  final total = rincian.fold<int>(
    0,
    (jumlahSementara, item) => jumlahSementara + item.subtotal,
  );

  const batasDiskon = 100000;
  const persentaseDiskon = 0.10;

  final diskon = total >= batasDiskon ? total * persentaseDiskon : 0.0;
  final jumlahBayar = total - diskon;

  // Set menyimpan kategori tanpa duplikat.
  final Set<String> kategoriDibeli = rincian
      .map((item) => item.kategori)
      .toSet();

  print('\nSTRUK BELANJA');
  print('=' * 75);
  print(
    '${'Produk'.padRight(27)} | '
    '${'Qty'.padLeft(5)} | '
    '${'Harga (Rp)'.padLeft(15)} | '
    '${'Subtotal (Rp)'.padLeft(18)}',
  );
  print('-' * 75);

  if (rincian.isEmpty) {
    print('Tidak ada item valid yang dibeli.');
  } else {
    for (final item in rincian) {
      print(
        '${item.nama.padRight(27)} | '
        '${item.jumlah.toString().padLeft(5)} | '
        '${item.harga.toString().padLeft(15)} | '
        '${item.subtotal.toString().padLeft(18)}',
      );
    }
  }

  print('-' * 75);
  print('Total (Rp)        : $total');
  print('Diskon (Rp)       : ${diskon.toStringAsFixed(0)}');
  print('Jumlah bayar (Rp) : ${jumlahBayar.toStringAsFixed(0)}');
  print('Kategori dibeli   : $kategoriDibeli');

  print('\nITEM DITOLAK');
  if (ditolak.isEmpty) {
    print('Tidak ada.');
  } else {
    for (final alasan in ditolak) {
      print('- $alasan');
    }
  }

  print('=' * 75);
  print('Terima kasih telah berbelanja!');
}

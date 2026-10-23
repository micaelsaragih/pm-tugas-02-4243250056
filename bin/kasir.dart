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

  print('Pesanan yang diterima: $input');
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../catatan.dart';
import '../api_client.dart';

/// Halaman utama — menampilkan daftar catatan dari SQLite
/// menggunakan FutureBuilder untuk menangani 3 state: loading, error, data.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Catatan>> _futureCatatan;

  @override
  void initState() {
    super.initState();
    _muatUlang();
  }

  /// Reload data dari database, disimpan di field Future
  /// agar FutureBuilder tidak terus-menerus query ulang.
  void _muatUlang() {
    setState(() {
      _futureCatatan = ApiClient.instance.getAll();
    });
  }

  /// Navigasi ke form — setelah kembali, selalu refresh dari DB.
  Future<void> _bukaForm({Catatan? initial}) async {
    await Navigator.pushNamed(context, '/form', arguments: initial);
    _muatUlang();
  }

  /// Navigasi ke halaman detail
  Future<void> _bukaDetail(Catatan c) async {
    await Navigator.pushNamed(context, '/detail', arguments: c);
    _muatUlang();
  }

  /// Konfirmasi hapus dengan dialog sebelum eksekusi
  Future<void> _konfirmasiHapus(Catatan c) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded,
            color: Colors.red, size: 48),
        title: const Text('Hapus catatan?'),
        content: Text(
          '"${c.judul}" akan dihapus permanen.',
          style: const TextStyle(fontSize: 15),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (yakin == true) {
      try {
        await ApiClient.instance.delete(c.id!);
        if (!mounted) return;
        _muatUlang();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${c.judul}" dihapus'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } on ApiException catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus: ${e.message}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  /// Warna badge berdasarkan kategori
  Color _warnaKategori(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return const Color(0xFF6366F1);
      case 'Tugas':
        return const Color(0xFFF59E0B);
      case 'Pribadi':
        return const Color(0xFF10B981);
      case 'Lainnya':
        return const Color(0xFF8B5CF6);
      default:
        return Colors.grey;
    }
  }

  /// Icon berdasarkan kategori
  IconData _iconKategori(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return Icons.school_rounded;
      case 'Tugas':
        return Icons.assignment_rounded;
      case 'Pribadi':
        return Icons.person_rounded;
      case 'Lainnya':
        return Icons.more_horiz_rounded;
      default:
        return Icons.note_rounded;
    }
  }

  /// Satu item catatan di list
  Widget _itemCatatan(Catatan c) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    final warna = _warnaKategori(c.kategori);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _bukaDetail(c),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: kategori badge + actions
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: warna.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_iconKategori(c.kategori),
                            size: 14, color: warna),
                        const SizedBox(width: 4),
                        Text(
                          c.kategori,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warna,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Action buttons
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      icon: Icon(Icons.edit_outlined,
                          color: Theme.of(context).colorScheme.primary),
                      onPressed: () => _bukaForm(initial: c),
                      tooltip: 'Edit',
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.red),
                      onPressed: () => _konfirmasiHapus(c),
                      tooltip: 'Hapus',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Judul
              Text(
                c.judul,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 6),

              // Isi (preview)
              Text(
                c.isi,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.65),
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 10),

              // Tanggal
              Row(
                children: [
                  Icon(Icons.access_time_rounded,
                      size: 13,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4)),
                  const SizedBox(width: 4),
                  Text(
                    dateFormat.format(c.dibuatPada),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.note_alt_rounded, size: 28),
            SizedBox(width: 10),
            Text(
              'Catatan Mahasiswa',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        centerTitle: false,
        scrolledUnderElevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _muatUlang,
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: FutureBuilder<List<Catatan>>(
        future: _futureCatatan,
        builder: (context, snapshot) {
          // STATE 1: Loading
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Memuat catatan...'),
                ],
              ),
            );
          }

          // STATE 2: Error
          if (snapshot.hasError) {
            final e = snapshot.error;
            final pesan = e is ApiException ? e.message : 'Terjadi kesalahan: $e';
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        size: 64, color: colorScheme.error),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi kesalahan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pesan,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: _muatUlang,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // STATE 3: Data kosong
          final data = snapshot.data ?? const [];
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.note_add_rounded,
                      size: 80, color: colorScheme.primary.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada catatan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap tombol + untuk menambah catatan baru',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            );
          }

          // STATE 4: Data ada
          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 88),
            itemBuilder: (_, i) => _itemCatatan(data[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bukaForm(),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Tambah',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

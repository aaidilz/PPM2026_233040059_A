import 'package:flutter/material.dart';

class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.dibuatPada,
  });
}

String _formatTanggal(DateTime dt) {
  final namaBulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  final hari = dt.day;
  final bulan = namaBulan[dt.month - 1];
  final tahun = dt.year;
  final jam = dt.hour.toString().padLeft(2, '0');
  final menit = dt.minute.toString().padLeft(2, '0');
  return '$hari $bulan $tahun - $jam:$menit';
}

class TugasMandiri1App extends StatelessWidget {
  const TugasMandiri1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Mandiri 1 - Edit Catatan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const TugasMandiri1Home(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
            return MaterialPageRoute(
              builder: (_) => const FormCatatanPage(),
            );
          case '/detail':
            final args = settings.arguments as Map<String, dynamic>;
            final catatan = args['catatan'] as Catatan;
            final index = args['index'] as int;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan, index: index),
            );
        }
        return null;
      },
    );
  }
}

class TugasMandiri1Home extends StatefulWidget {
  const TugasMandiri1Home({super.key});

  @override
  State<TugasMandiri1Home> createState() => _TugasMandiri1HomeState();
}

class _TugasMandiri1HomeState extends State<TugasMandiri1Home> {
  final List<Catatan> _catatan = [
    Catatan(
      judul: 'Belajar Flutter (Tugas 1)',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation dengan fitur Edit.',
      kategori: 'Kuliah',
      dibuatPada: DateTime.now(),
    ),
  ];

  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');

    if (hasil is Catatan) {
      setState(() => _catatan.add(hasil));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" ditambahkan')),
      );
    }
  }

  Future<void> _bukaDetailCatatan(Catatan c, int index) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/detail',
      arguments: {'catatan': c, 'index': index},
    );

    if (hasil is Map<String, dynamic>) {
      final action = hasil['action'];
      if (action == 'update') {
        final updatedCatatan = hasil['catatan'] as Catatan;
        setState(() {
          _catatan[index] = updatedCatatan;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Catatan "${updatedCatatan.judul}" berhasil diubah')),
        );
      } else if (action == 'delete') {
        setState(() {
          _catatan.removeAt(index);
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Catatan berhasil dihapus')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 1: Edit Catatan'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ),
      body: _catatan.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              itemCount: _catatan.length,
              itemBuilder: (context, i) {
                final c = _catatan[i];
                return ListTile(
                  title: Text(c.judul),
                  subtitle: Text('${c.kategori} • ${_formatTanggal(c.dibuatPada)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      setState(() {
                        _catatan.removeAt(i);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Catatan "${c.judul}" dihapus')),
                      );
                    },
                  ),
                  onTap: () => _bukaDetailCatatan(c, i),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 80,
            color: Colors.indigo.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada catatan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tekan tombol + untuk menambahkan catatan baru.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class FormCatatanPage extends StatefulWidget {
  final Catatan? catatan;

  const FormCatatanPage({super.key, this.catatan});

  @override
  State<FormCatatanPage> createState() => _FormCatatanPageState();
}

class _FormCatatanPageState extends State<FormCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulCtrl;
  late final TextEditingController _isiCtrl;
  late String _kategori;
  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    _judulCtrl = TextEditingController(text: widget.catatan?.judul ?? '');
    _isiCtrl = TextEditingController(text: widget.catatan?.isi ?? '');
    _kategori = widget.catatan?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final catatanBaru = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      dibuatPada: widget.catatan?.dibuatPada ?? DateTime.now(),
    );

    Navigator.pop(context, catatanBaru);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.catatan != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Catatan' : 'Tambah Catatan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judulCtrl,
              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _kategoriOpsi
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: Icon(isEdit ? Icons.save : Icons.add),
              label: Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailCatatanPage extends StatefulWidget {
  final Catatan catatan;
  final int index;

  const DetailCatatanPage({super.key, required this.catatan, required this.index});

  @override
  State<DetailCatatanPage> createState() => _DetailCatatanPageState();
}

class _DetailCatatanPageState extends State<DetailCatatanPage> {
  late Catatan _currentCatatan;
  bool _isUpdated = false;

  @override
  void initState() {
    super.initState();
    _currentCatatan = widget.catatan;
  }

  Future<void> _bukaEditCatatan() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormCatatanPage(catatan: _currentCatatan),
      ),
    );

    if (hasil is Catatan) {
      setState(() {
        _currentCatatan = hasil;
        _isUpdated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _bukaEditCatatan,
            tooltip: 'Edit Catatan',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, {'action': 'delete'});
            },
            tooltip: 'Hapus Catatan',
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_isUpdated) {
            Navigator.pop(context, {'action': 'update', 'catatan': _currentCatatan});
            return false;
          }
          return true;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentCatatan.judul,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(label: Text(_currentCatatan.kategori)),
                  const SizedBox(width: 8),
                  Text(
                    _formatTanggal(_currentCatatan.dibuatPada),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Divider(height: 32),
              Text(
                _currentCatatan.isi,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  if (_isUpdated) {
                    Navigator.pop(context, {'action': 'update', 'catatan': _currentCatatan});
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

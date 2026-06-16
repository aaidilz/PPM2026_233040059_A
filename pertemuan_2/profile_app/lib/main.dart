import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(const MyApp());
}

/// =====================================================================
/// MAIN APP
/// =====================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const ProfilePage(),
    );
  }
}

/// =====================================================================
/// PROFILE PAGE
/// =====================================================================
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImagePath;
  String _name = 'Aidil';
  String _role = 'Mahasiswa Teknik Informatika';
  String _tentang = 'Saya tertarik dengan cyber security, fullstack development, dan mobile development menggunakan Flutter.';
  String _pendidikan = 'Teknik Informatika\nSemester 5';
  String _lokasi = 'Bandung, Indonesia';
  String _kontak = 'aidil@example.com\n+62 812-3456-7890';
  List<String> _skills = ['Flutter', 'Dart', 'React', 'Cyber Security', 'Java'];

  // Bonus
  String? _pengalamanImagePath;
  String _pengalamanJudul = 'Flutter Developer Intern';
  String _pengalamanDeskripsi = 'Mengembangkan aplikasi mobile e-commerce menggunakan Flutter dan Firebase selama 3 bulan.';

  ImageProvider _getProfileImage() {
    if (_profileImagePath == null) {
      return const NetworkImage(
        'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
      );
    } else if (_profileImagePath!.startsWith('http')) {
      return NetworkImage(_profileImagePath!);
    } else {
      return FileImage(File(_profileImagePath!));
    }
  }

  Widget _getPengalamanImage() {
    if (_pengalamanImagePath == null) {
      return Image.network(
        'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=500&auto=format&fit=crop&q=60',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
        },
      );
    } else if (_pengalamanImagePath!.startsWith('http')) {
      return Image.network(
        _pengalamanImagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
        },
      );
    } else {
      return Image.file(
        File(_pengalamanImagePath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      /// DRAWER
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
            ),

            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text(
                      'Halaman pengaturan belum tersedia.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GalleryHome(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.work_history),
              title: const Text('Edit Pengalaman'),
              onTap: () async {
                Navigator.pop(context); // Close the drawer

                final result = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditPengalamanPage(
                      pengalamanImagePath: _pengalamanImagePath,
                      pengalamanJudul: _pengalamanJudul,
                      pengalamanDeskripsi: _pengalamanDeskripsi,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    _pengalamanImagePath = result['pengalamanImagePath'] as String?;
                    _pengalamanJudul = result['pengalamanJudul'] as String;
                    _pengalamanDeskripsi = result['pengalamanDeskripsi'] as String;
                  });
                }
              },
            ),
          ],
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// HEADER
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: _getProfileImage(),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    _role,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// STATISTIC
            const Row(
              children: [
                Expanded(
                  child: _StatBox(
                    label: 'Project',
                    value: '24',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Follower',
                    value: '1.5K',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Like',
                    value: '9.8K',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// SECTIONS
            _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content: _tentang,
            ),

            _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: _pendidikan,
            ),

            _SectionCard(
              icon: Icons.location_on,
              title: 'Lokasi',
              content: _lokasi,
            ),

            const _SectionCard(
              icon: Icons.favorite,
              title: 'Hobi & Minat',
              content: 'Coding • Musik • Anime • Game • Cyber Security',
            ),

            _SectionCard(
              icon: Icons.email,
              title: 'Kontak',
              content: _kontak,
            ),

            /// SKILLS
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 12),

                        Text(
                          'Skills',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _skills.map((skill) => Chip(label: Text(skill))).toList(),
                    ),
                  ],
                ),
              ),
            ),

            /// BONUS: CARD PENGALAMAN
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Pengalaman',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: _getPengalamanImage(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _pengalamanJudul,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _pengalamanDeskripsi,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      /// FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (_) => EditProfilePage(
                profileImagePath: _profileImagePath,
                name: _name,
                role: _role,
                tentang: _tentang,
                pendidikan: _pendidikan,
                lokasi: _lokasi,
                kontak: _kontak,
                skills: _skills,
              ),
            ),
          );

          if (result != null) {
            setState(() {
              _profileImagePath = result['profileImagePath'] as String?;
              _name = result['name'] as String;
              _role = result['role'] as String;
              _tentang = result['tentang'] as String;
              _pendidikan = result['pendidikan'] as String;
              _lokasi = result['lokasi'] as String;
              _kontak = result['kontak'] as String;
              _skills = result['skills'] as List<String>;
            });
          }
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
      ),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),

          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Pesan',
          ),

          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

/// =====================================================================
/// HELPER WIDGETS
/// =====================================================================
class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    content,
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================================================================
/// GALLERY HOME
/// =====================================================================
class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Display', Icons.image, Colors.blue),
      ('Input', Icons.edit, Colors.green),
      ('Button', Icons.smart_button, Colors.orange),
      ('Feedback', Icons.notifications, Colors.purple),
      ('Layout', Icons.dashboard, Colors.teal),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Gallery'),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final (name, icon, color) =
              categories[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),

              title: Text(name),

              trailing:
                  const Icon(Icons.chevron_right),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CategoryPage(name: name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// =====================================================================
/// CATEGORY PAGE
/// =====================================================================
class CategoryPage extends StatelessWidget {
  final String name;

  const CategoryPage({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final body = switch (name) {
      'Display' => const _DisplayDemo(),
      'Input' => const _InputDemo(),
      'Button' => const _ButtonDemo(),
      'Feedback' => const _FeedbackDemo(),
      'Layout' => const _LayoutDemo(),
      _ => const Center(
          child: Text('?'),
        ),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}

/// =====================================================================
/// DISPLAY DEMO
/// =====================================================================
class _DisplayDemo extends StatelessWidget {
  const _DisplayDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.album),
            title: Text('Judul Item'),
            subtitle: Text('Sub Judul'),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Chip',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Flutter')),
            Chip(label: Text('Dart')),
            Chip(label: Text('Mobile')),
          ],
        ),

        const SizedBox(height: 16),

        const Divider(thickness: 2),

        const SizedBox(height: 16),

        Row(
          children: const [
            CircleAvatar(
              child: Text('A'),
            ),

            SizedBox(width: 12),

            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check),
            ),

            SizedBox(width: 12),

            Icon(
              Icons.star,
              color: Colors.amber,
              size: 40,
            ),
          ],
        ),
      ],
    );
  }
}

/// =====================================================================
/// INPUT DEMO
/// =====================================================================
class _InputDemo extends StatefulWidget {
  const _InputDemo();

  @override
  State<_InputDemo> createState() =>
      _InputDemoState();
}

class _InputDemoState
    extends State<_InputDemo> {
  bool checked = false;
  bool switched = true;
  double slider = 0.5;
  String? dropdown = 'Apel';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama',
            hintText: 'Masukkan nama',
          ),
        ),

        const SizedBox(height: 16),

        CheckboxListTile(
          title: const Text('Checkbox'),
          value: checked,
          onChanged: (v) {
            setState(() {
              checked = v ?? false;
            });
          },
        ),

        SwitchListTile(
          title: const Text('Switch'),
          value: switched,
          onChanged: (v) {
            setState(() {
              switched = v;
            });
          },
        ),

        Slider(
          value: slider,
          onChanged: (v) {
            setState(() {
              slider = v;
            });
          },
        ),

        DropdownButton<String>(
          value: dropdown,
          items: ['Apel', 'Jeruk', 'Mangga']
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (v) {
            setState(() {
              dropdown = v;
            });
          },
        ),
      ],
    );
  }
}

/// =====================================================================
/// BUTTON DEMO
/// =====================================================================
class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Elevated'),
        ),

        const SizedBox(height: 8),

        FilledButton(
          onPressed: () {},
          child: const Text('Filled'),
        ),

        const SizedBox(height: 8),

        OutlinedButton(
          onPressed: () {},
          child: const Text('Outlined'),
        ),

        const SizedBox(height: 8),

        TextButton(
          onPressed: () {},
          child: const Text('Text Button'),
        ),

        const SizedBox(height: 8),

        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('Dengan Icon'),
        ),

        const SizedBox(height: 8),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

/// =====================================================================
/// FEEDBACK DEMO
/// =====================================================================
class _FeedbackDemo extends StatelessWidget {
  const _FeedbackDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'Halo dari SnackBar!',
                ),
              ),
            );
          },
          child: const Text(
            'Tampilkan SnackBar',
          ),
        ),

        const SizedBox(height: 8),

        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Konfirmasi'),
                content: const Text(
                  'Yakin ingin lanjut?',
                ),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    child: const Text('Batal'),
                  ),

                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    child: const Text('Ya'),
                  ),
                ],
              ),
            );
          },
          child: const Text(
            'Tampilkan Dialog',
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Progress Indicator',
        ),

        const SizedBox(height: 8),

        const LinearProgressIndicator(
          value: 0.6,
        ),

        const SizedBox(height: 16),

        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}

/// =====================================================================
/// LAYOUT DEMO
/// =====================================================================
class _LayoutDemo extends StatelessWidget {
  const _LayoutDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Stack',
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 120,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue.shade100,
              ),

              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
              ),

              const Positioned(
                bottom: 12,
                right: 12,
                child: Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Wrap',
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            8,
            (i) => Container(
              padding:
                  const EdgeInsets.all(12),
              color: Colors.teal.shade100,
              child: Text(
                'Item ${i + 1}',
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'GridView',
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(
              6,
              (i) => Container(
                alignment: Alignment.center,
                color:
                    Colors.purple.shade100,
                child: Text(
                  '${i + 1}',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// =====================================================================
/// EDIT PROFILE PAGE
/// =====================================================================
class EditProfilePage extends StatefulWidget {
  final String? profileImagePath;
  final String name;
  final String role;
  final String tentang;
  final String pendidikan;
  final String lokasi;
  final String kontak;
  final List<String> skills;

  const EditProfilePage({
    super.key,
    required this.profileImagePath,
    required this.name,
    required this.role,
    required this.tentang,
    required this.pendidikan,
    required this.lokasi,
    required this.kontak,
    required this.skills,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _localProfileImagePath;
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _tentangController;
  late TextEditingController _pendidikanController;
  late TextEditingController _lokasiController;
  late TextEditingController _kontakController;
  late TextEditingController _skillsController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _localProfileImagePath = widget.profileImagePath;
    _nameController = TextEditingController(text: widget.name);
    _roleController = TextEditingController(text: widget.role);
    _tentangController = TextEditingController(text: widget.tentang);
    _pendidikanController = TextEditingController(text: widget.pendidikan);
    _lokasiController = TextEditingController(text: widget.lokasi);
    _kontakController = TextEditingController(text: widget.kontak);
    _skillsController = TextEditingController(text: widget.skills.join(', '));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _tentangController.dispose();
    _pendidikanController.dispose();
    _lokasiController.dispose();
    _kontakController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _localProfileImagePath = image.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil gambar: $e')),
      );
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ubah Foto Profil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Kamera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getProfileImage() {
    if (_localProfileImagePath == null) {
      return const NetworkImage(
        'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
      );
    } else if (_localProfileImagePath!.startsWith('http')) {
      return NetworkImage(_localProfileImagePath!);
    } else {
      return FileImage(File(_localProfileImagePath!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, size: 28),
            onPressed: () {
              Navigator.pop(context, {
                'profileImagePath': _localProfileImagePath,
                'name': _nameController.text.trim(),
                'role': _roleController.text.trim(),
                'tentang': _tentangController.text.trim(),
                'pendidikan': _pendidikanController.text.trim(),
                'lokasi': _lokasiController.text.trim(),
                'kontak': _kontakController.text.trim(),
                'skills': _skillsController.text
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList(),
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar Editor
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: _getProfileImage(),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        onPressed: _showImageSourceActionSheet,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
            _buildTextField(
              controller: _nameController,
              label: 'Nama Lengkap',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _roleController,
              label: 'Peran / Pekerjaan',
              icon: Icons.work,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _tentangController,
              label: 'Tentang Saya',
              icon: Icons.info_outline,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _pendidikanController,
              label: 'Pendidikan',
              icon: Icons.school,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _lokasiController,
              label: 'Lokasi',
              icon: Icons.location_on,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _kontakController,
              label: 'Kontak (Email / Telp)',
              icon: Icons.email,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _skillsController,
              label: 'Skills (Pemisah Koma)',
              icon: Icons.star,
              hint: 'Contoh: Flutter, Dart, React, Java',
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'profileImagePath': _localProfileImagePath,
                    'name': _nameController.text.trim(),
                    'role': _roleController.text.trim(),
                    'tentang': _tentangController.text.trim(),
                    'pendidikan': _pendidikanController.text.trim(),
                    'lokasi': _lokasiController.text.trim(),
                    'kontak': _kontakController.text.trim(),
                    'skills': _skillsController.text
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList(),
                  });
                },
                child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}

/// =====================================================================
/// EDIT PENGALAMAN PAGE
/// =====================================================================
class EditPengalamanPage extends StatefulWidget {
  final String? pengalamanImagePath;
  final String pengalamanJudul;
  final String pengalamanDeskripsi;

  const EditPengalamanPage({
    super.key,
    required this.pengalamanImagePath,
    required this.pengalamanJudul,
    required this.pengalamanDeskripsi,
  });

  @override
  State<EditPengalamanPage> createState() => _EditPengalamanPageState();
}

class _EditPengalamanPageState extends State<EditPengalamanPage> {
  String? _localPengalamanImagePath;
  late TextEditingController _judulController;
  late TextEditingController _deskripsiController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _localPengalamanImagePath = widget.pengalamanImagePath;
    _judulController = TextEditingController(text: widget.pengalamanJudul);
    _deskripsiController = TextEditingController(text: widget.pengalamanDeskripsi);
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _localPengalamanImagePath = image.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil gambar: $e')),
      );
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ubah Gambar Pengalaman',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Kamera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPengalamanImage() {
    if (_localPengalamanImagePath == null) {
      return Image.network(
        'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=500&auto=format&fit=crop&q=60',
        fit: BoxFit.cover,
      );
    } else if (_localPengalamanImagePath!.startsWith('http')) {
      return Image.network(
        _localPengalamanImagePath!,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(_localPengalamanImagePath!),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pengalaman'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, size: 28),
            onPressed: () {
              Navigator.pop(context, {
                'pengalamanImagePath': _localPengalamanImagePath,
                'pengalamanJudul': _judulController.text.trim(),
                'pengalamanDeskripsi': _deskripsiController.text.trim(),
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Editor Container
            GestureDetector(
              onTap: _showImageSourceActionSheet,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _getPengalamanImage(),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: const Color(0x4D000000),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text(
                                'Ubah Gambar Pengalaman',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
            TextFormField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: 'Judul Pengalaman',
                prefixIcon: const Icon(Icons.work, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deskripsiController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Deskripsi Pengalaman',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Icon(Icons.description, color: Colors.blue),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'pengalamanImagePath': _localPengalamanImagePath,
                    'pengalamanJudul': _judulController.text.trim(),
                    'pengalamanDeskripsi': _deskripsiController.text.trim(),
                  });
                },
                child: const Text('Simpan Pengalaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
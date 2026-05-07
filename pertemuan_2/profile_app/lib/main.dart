import 'package:flutter/material.dart';

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
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Aidil',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Mahasiswa Teknik Informatika',
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

            /// SECTION
            const _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content:
                  'Saya tertarik dengan cyber security, fullstack development, dan mobile development menggunakan Flutter.',
            ),

            const _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content:
                  'Teknik Informatika\nSemester 5',
            ),

            const _SectionCard(
              icon: Icons.favorite,
              title: 'Hobi & Minat',
              content:
                  'Coding • Musik • Anime • Game • Cyber Security',
            ),

            const _SectionCard(
              icon: Icons.email,
              title: 'Kontak',
              content:
                  'aidil@example.com\n+62 812-3456-7890',
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
                      children: const [
                        Chip(label: Text('Flutter')),
                        Chip(label: Text('Dart')),
                        Chip(label: Text('React')),
                        Chip(label: Text('Cyber Security')),
                        Chip(label: Text('Java')),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      /// FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Edit profil belum tersedia',
              ),
            ),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
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
        separatorBuilder: (_, __) =>
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
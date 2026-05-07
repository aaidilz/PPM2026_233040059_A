import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

///
/// MAIN APP
///
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Widget',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

///
/// HOME PAGE
///
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pertemuan 1 Flutter'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Hello'),
              Tab(text: 'Text'),
              Tab(text: 'Container'),
              Tab(text: 'Row & Column'),
              Tab(text: 'Icon'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HelloWorldPage(),
            TextStylingPage(),
            ContainerPage(),
            RowColumnPage(),
            IconPage(),
          ],
        ),
      ),
    );
  }
}

///
/// HELLO WORLD + PROFILE CARD
///
class HelloWorldPage extends StatelessWidget {
  const HelloWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '👋',
                style: TextStyle(fontSize: 64),
              ),

              const SizedBox(height: 16),

              const Text(
                'Halo, Aidil!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Selamat datang di dunia Flutter.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.blue.shade200,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NIM: 233040000',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Prodi: Teknik Informatika',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Semester: 5',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tombol ditekan!'),
                    ),
                  );
                },
                child: const Text('Tap Saya'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// LATIHAN 1 - TEXT & STYLING
///
class TextStylingPage extends StatelessWidget {
  const TextStylingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello Flutter!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple,
                letterSpacing: 2,
              ),
            ),

            SizedBox(height: 12),

            Text(
              'Ini teks kecil biasa',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 12),

            Text(
              'Flutter itu menyenangkan 🚀',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// LATIHAN 2 - CONTAINER & DECORATION
///
class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.black,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Container',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
/// LATIHAN 3 - ROW & COLUMN
///
class RowColumnPage extends StatelessWidget {
  const RowColumnPage({super.key});

  Widget kotak(Color warna) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Contoh Row',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                kotak(Colors.red),
                kotak(Colors.green),
                kotak(Colors.blue),
              ],
            ),

            const SizedBox(height: 40),

            const Text(
              'Contoh Column',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Column(
              children: [
                kotak(Colors.orange),
                const SizedBox(height: 12),
                kotak(Colors.purple),
                const SizedBox(height: 12),
                kotak(Colors.teal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///
/// LATIHAN 4 - ICON & BOTTOM BAR MOCKUP
///
class IconPage extends StatelessWidget {
  const IconPage({super.key});

  Widget menuIcon(
    IconData icon,
    String label,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 40,
          color: color,
        ),

        const SizedBox(height: 8),

        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Bottom Navigation Mockup',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            menuIcon(
              Icons.home,
              'Home',
              Colors.red,
            ),

            menuIcon(
              Icons.favorite,
              'Favorite',
              Colors.green,
            ),

            menuIcon(
              Icons.person,
              'Profile',
              Colors.purple,
            ),

            menuIcon(
              Icons.settings,
              'Settings',
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
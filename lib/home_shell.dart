import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_identification_app/pages/home_page.dart';
import 'package:plant_identification_app/pages/my_plants.dart';
import 'package:plant_identification_app/pages/red_book.dart';
import 'package:plant_identification_app/pages/scan_loading.dart';
import 'package:plant_identification_app/pages/search.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  final ImagePicker _picker = ImagePicker();

  final _pages = [
    const HomeScreen(),
    const SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 8),
        child: SizedBox(
          width: 77,
          height: 77,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: _showScanOptions,
            child: Center(
              child: ImageIcon(
                const AssetImage('assets/camera_icon.png'),
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/home_icon.png')),
            label: 'Acasa',
          ),
          NavigationDestination(
            icon: ImageIcon(AssetImage('assets/world_icon.png')),
            label: 'Exploreaza',
          ),
        ],
      ),
    );
  }

  void _showScanOptions() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Fa o fotografie'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Alege din galerie'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    if (!mounted || file == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ScanLoadingPage(imagePath: file.path),
      ),
    );
  }
}


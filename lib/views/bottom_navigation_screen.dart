import 'package:flutter/material.dart';
import 'package:weather_app/views/home/home_screen.dart';
import 'package:weather_app/appdata/session_manager.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:weather_app/views/conversion/conversion_screen.dart';
import 'package:weather_app/appdata/app_colors.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    if (index == 3) {
      // Logout
      await SessionManager.clearSession();
      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      ProfileScreen(
        key: ValueKey(DateTime.now().millisecondsSinceEpoch *
            (_selectedIndex == 1 ? 1 : 0)),
        onRefresh: () => setState(() {}),
      ),
      const SaranKesanScreen(),
      // Placeholder for Logout, will never be shown
      const SizedBox.shrink(),
      const ConversionScreen(),
    ];
    return Scaffold(
      body: _selectedIndex == 3 ? Container() : pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: AppColors.secondaryColor,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: 'Saran & Kesan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: 'Konversi',
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Screen with image and username
class ProfileScreen extends StatefulWidget {
  final VoidCallback? onRefresh;
  const ProfileScreen({Key? key, this.onRefresh}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _username;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadProfileImage();
  }

  Future<void> _loadUsername() async {
    final username = await SessionManager.getSession();
    setState(() {
      _username = username;
    });
  }

  Future<void> _loadProfileImage() async {
    final path = await SessionManager.getProfileImagePath();
    if (path != null && File(path).existsSync()) {
      setState(() {
        _imageFile = File(path);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library,
                  color: AppColors.secondaryColor),
              title: const Text('Ambil dari Galeri',
                  style: TextStyle(color: AppColors.secondaryColor)),
              onTap: () async {
                Navigator.of(context).pop();
                final picked =
                    await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  await SessionManager.saveProfileImagePath(picked.path);
                  setState(() {
                    _imageFile = File(picked.path);
                  });
                  if (widget.onRefresh != null) widget.onRefresh!();
                }
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.camera_alt, color: AppColors.secondaryColor),
              title: const Text('Ambil dari Kamera',
                  style: TextStyle(color: AppColors.secondaryColor)),
              onTap: () async {
                Navigator.of(context).pop();
                final picked =
                    await picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  await SessionManager.saveProfileImagePath(picked.path);
                  setState(() {
                    _imageFile = File(picked.path);
                  });
                  if (widget.onRefresh != null) widget.onRefresh!();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 60),
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 54,
                backgroundColor: Colors.white,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null
                    ? const Icon(Icons.person,
                        size: 54, color: AppColors.secondaryColor)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
                child: Text(
                  _username ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Saran & Kesan Screen
class SaranKesanScreen extends StatelessWidget {
  const SaranKesanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Matkul Teknologi dan Pemrograman Mobile sangat berkesan banget didalam memori saya, mulai dari 70 soal uts dan 50 soal kuis dan semua tugas dan projeknya yang sangat2 banyak ketentuannya, akhir kata saya sangat berterimakasih banyak dengan pak bagus sebagai dosen matkul ini atas pengalaman dalam matkul ini (topi biru)',
                style: TextStyle(fontSize: 16, color: AppColors.secondaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

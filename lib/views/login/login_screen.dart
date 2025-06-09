import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../utils/crypto_helper.dart';
import '../../appdata/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appdata/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  // Dummy user (username: user, password: password123)
  final User dummyUser = User(
    username: 'user',
    passwordHash: CryptoHelper.hashPassword('password123'),
  );

  Future<User?> _getRegisteredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('registered_username');
    final passwordHash = prefs.getString('registered_password_hash');
    if (username != null && passwordHash != null) {
      return User(username: username, passwordHash: passwordHash);
    }
    return null;
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() => _error = 'Username dan password wajib diisi');
      return;
    }

    final hashed = CryptoHelper.hashPassword(password);

    final registeredUser = await _getRegisteredUser();

    bool isValid = false;
    if (registeredUser != null) {
      isValid = (username == registeredUser.username &&
          hashed == registeredUser.passwordHash);
    } else {
      isValid =
          (username == dummyUser.username && hashed == dummyUser.passwordHash);
    }

    if (isValid) {
      await SessionManager.saveSession(username);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _error = 'Username atau password salah');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text('Login',
            style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: AppColors.secondaryColor),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: AppColors.secondaryColor),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(_error!,
                        style: const TextStyle(color: Colors.red)),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      foregroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Belum punya akun? Daftar di sini',
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

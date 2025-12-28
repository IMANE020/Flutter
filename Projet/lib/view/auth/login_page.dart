import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/controller/auth_controller.dart';
import 'package:weather_app/view/auth/signup_page.dart';
import 'package:weather_app/view/auth/forgot_password_page.dart';
import 'package:weather_app/view/core/constants.dart';
import 'package:weather_app/view/core/ui_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();
    final AuthController authCtrl = Get.find<AuthController>();

    // Checkbox state managed in AuthController

    return Scaffold(
      body: Stack(
        children: [
          // Dynamic Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(UiHelper.getDynamicBackground()),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Météo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Freezing',
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 2))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Bienvenue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: TextField(
                      controller: emailCtrl,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Entrez votre email',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  Obx(() => Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: TextField(
                      controller: passwordCtrl,
                      obscureText: !authCtrl.isPasswordVisible.value,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Entrez votre mot de passe',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            authCtrl.isPasswordVisible.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.white70
                          ),
                          onPressed: () => authCtrl.isPasswordVisible.toggle(),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  )),
                  const SizedBox(height: 15),

                  // Remember Me / Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Row(
                        children: [
                          Checkbox(
                            value: authCtrl.rememberMe.value, 
                            onChanged: (v) => authCtrl.rememberMe.value = v!,
                            activeColor: blueColor,
                            side: const BorderSide(color: Colors.white70),
                          ),
                          Text('Se souvenir de moi', 
                              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                        ],
                      )),
                      TextButton(
                        onPressed: () {
                          // Link to Forgot Password Page
                          Get.to(() => ForgotPasswordPage());
                        },
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(color: Colors.blue[100], fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        authCtrl.login(emailCtrl.text.trim(), passwordCtrl.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Se connecter',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Signup Link
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignupPage());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Pas encore de compte ? ",
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                        children: [
                          TextSpan(
                            text: "Créer un compte",
                            style: GoogleFonts.outfit(
                              color: Colors.blue[100],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

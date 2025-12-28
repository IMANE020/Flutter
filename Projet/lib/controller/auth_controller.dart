import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/auth/login_page.dart';
import 'package:weather_app/view/splash/splash.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  
  // Observable user
  late Rx<User?> firebaseUser;
  var rememberMe = false.obs; // UI State for Login Page
  var isPasswordVisible = false.obs; // UI State for Password Visibility
  
  // FirebaseAuth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    // Initialize the user
    firebaseUser = Rx<User?>(auth.currentUser);
    // Bind the user to the stream
    firebaseUser.bindStream(auth.userChanges());
    // Listen to changes and route
    ever(firebaseUser, _setInitialScreen); //ecoute les changements d etat de user et redirige
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      
      // Navigation is handled by the auth state listener (_setInitialScreen)
      Get.snackbar(
        "Succès",
        "Connexion avec Google réussie !",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    } catch (e) {
       Get.snackbar(
        "Erreur Google",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const SplashScreen());
    }
  }

  void register(String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      
      // Update Display Name
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
      }
      
      // User requested: Register -> Login Page -> App
      // So we sign out immediately after registration to force them to login manually
      await auth.signOut();
      
      Get.snackbar(
        "Succès",
        "Compte créé ! Veuillez vous connecter.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
      
      // Navigate explicitly to Login Page (redundant with listener but safe)
      Get.offAll(() => const LoginPage());
      
    } catch (e) {
      Get.snackbar(
        "Erreur Inscription",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // Listener will handle redirection to Splash/Home
    } catch (e) {
      Get.snackbar(
        "Erreur Connexion",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Email envoyé",
        "Un lien de réinitialisation a été envoyé à $email",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        duration: const Duration(seconds: 4), // Show it longer
      );
      // Wait for user to read it
      await Future.delayed(const Duration(seconds: 3));
      Get.back(); // Go back to login
    } on FirebaseAuthException catch (e) {
      String message = "Une erreur est survenue";
      if (e.code == 'user-not-found') {
        message = "Cet email ne correspond à aucun compte.";
      } else if (e.code == 'invalid-email') {
        message = "Format d'email invalide.";
      }
      
      Get.snackbar(
        "Erreur",
        message,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    } catch (e) {
      Get.snackbar(
        "Erreur",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}

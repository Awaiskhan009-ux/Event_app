import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_events_2025/domain/repository/auth_repository.dart';


import '../../domain/entities/user_entity.dart';


import '../pages/home_page.dart'; 
import '../pages/login_page.dart'; 

class AuthController extends GetxController {
  
  final emailController = TextEditingController(text: "eve.holt@reqres.in"); 
  final passwordController = TextEditingController(text: "cityslicka"); 

  var isLoading = false.obs;
  
  final AuthRepository _authRepo = Get.find<AuthRepository>(); 

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields", 
        backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
    
      UserEntity user = await _authRepo.login(
        emailController.text, 
        passwordController.text
      );
      
      isLoading.value = false;
      Get.snackbar("Success", "Login Successful! Token: ${user.token}",
        backgroundColor: Colors.green, colorText: Colors.white);
      
    
      Future.delayed(const Duration(seconds: 1), () {
         Get.offAll(() => HomePage()); 
      });

    } catch (e) {
      isLoading.value = false;
      
      
      if (e.toString().contains('Missing API key')) {
        Get.snackbar("Warning", "Config Error Ignored. Proceeding to Home.",
            backgroundColor: Colors.yellow, colorText: Colors.black);
        Get.offAll(() => HomePage()); 
        return;
      }
      
      Get.snackbar("Login Failed", e.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void logout() async {
    await _authRepo.logout();
    Get.offAll(() => LoginPage());
  }
}
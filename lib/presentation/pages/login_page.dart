import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_events_2025/core/constant/app_colors.dart';
import 'package:my_events_2025/core/utils/dimensions.dart';
import 'package:my_events_2025/presentation/controller/auth_controller.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView( 
        child: Container(
          height: Dimensions.screenHeight,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Center(
                child: Text(
                  "MyEvents",
                  style: TextStyle(
                    fontSize: Dimensions.font26 * 1.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height30),

          
              Text("Email", style: TextStyle(fontSize: Dimensions.font16)),
              SizedBox(height: Dimensions.height10),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email (Test: eve.holt@reqres.in)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                ),
              ),
              SizedBox(height: Dimensions.height20),

              // 3. Password Field (Test pass: cityslicka)
              Text("Password", style: TextStyle(fontSize: Dimensions.font16)),
              SizedBox(height: Dimensions.height10),
              TextField(
                controller: controller.passwordController,
                obscureText: true, 
                decoration: InputDecoration(
                  hintText: "Enter your password (Test: cityslicka)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                ),
              ),
              SizedBox(height: Dimensions.height30),

              
              Obx(() { 
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator()) 
                    : SizedBox(
                        width: double.infinity,
                        height: Dimensions.height10 * 5,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
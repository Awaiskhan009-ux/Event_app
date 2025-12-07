// lib/core/utils/dimensions.dart
import 'package:get/get.dart';

class Dimensions {

  
  static double get screenHeight => Get.height;
  static double get screenWidth => Get.width;

  static double get height10 => screenHeight * 0.0118; 
  static double get height20 => screenHeight * 0.0236;
  static double get height15 => screenHeight * 0.0177;
  static double get height30 => screenHeight * 0.0354;

  // Width calculations
  static double get width10 => screenWidth * 0.0256;
  static double get width20 => screenWidth * 0.0512;
  static double get width15 => screenWidth * 0.0384;
  
  // Font Size
  static double get font20 => screenHeight * 0.0236;
  static double get font16 => screenHeight * 0.0189;
  static double get font26 => screenHeight * 0.0308;

  // Radius 
  static double get radius20 => screenHeight * 0.0236;
  static double get radius15 => screenHeight * 0.0177;
  static double get radius30 => screenHeight * 0.0354;
}
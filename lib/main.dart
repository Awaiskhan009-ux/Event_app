import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_events_2025/data/models/sources/remote_sourses.dart';
import 'package:my_events_2025/data/repository/auth_repository_impl.dart';
import 'package:my_events_2025/domain/repository/auth_repository.dart';


import 'presentation/pages/login_page.dart';

void initDependencies() {
  
  Get.lazyPut(() => RemoteDataSource());
  
  
  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(Get.find<RemoteDataSource>()),
  );
}


void main() {
  
  WidgetsFlutterBinding.ensureInitialized(); 
  
  initDependencies(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyEvents',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: LoginPage(), 
    );
  }
}
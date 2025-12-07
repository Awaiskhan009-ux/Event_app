import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_events_2025/data/models/sources/remote_sourses.dart';
import 'package:my_events_2025/data/models/user_model.dart';
import 'package:my_events_2025/domain/entities/user_entity.dart';
import 'package:my_events_2025/domain/repository/auth_repository.dart';
// Note: Relative imports use '..' to go up a folder level (safe and clean)

// Domain Layer Imports

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(); 

  // Dependency Injection (remoteDataSource yahan milta hai)
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      // 1. API Call
      final data = await remoteDataSource.login(email, password);
      
      // 2. Data Model/Entity Conversion (UserModel ko use kar rahe hain)
      final user = UserModel.fromJson(data);

      // 3. Token Saving (Mandatory requirement)
      await _secureStorage.write(key: 'user_token', value: user.token);
      
      return user; 
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    // Session token clear karein (Mandatory requirement)
    await _secureStorage.delete(key: 'user_token');
    print("User logged out and token deleted from secure storage.");
  }
}

import 'package:my_events_2025/domain/entities/user_entity.dart';


// Ye sirf ek contract hai (abstract class)
abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
}
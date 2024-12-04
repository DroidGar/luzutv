import 'package:luzu/features/auth/domain/entities/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheSession(Session session);

  Future<String> getSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences shared;

  AuthLocalDataSourceImpl(this.shared);

  @override
  Future<void> cacheSession(Session session) async {
    await shared.setString('token', session.token);
  }

  @override
  Future<String> getSession() async {
    return shared.getString('token') ?? '';
  }
}

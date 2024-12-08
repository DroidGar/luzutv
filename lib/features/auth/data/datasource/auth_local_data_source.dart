import 'package:luzu/features/auth/data/models/session_model.dart';
import 'package:luzu/features/auth/domain/entities/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSourceBase {
  Future<void> cacheSession(Session session);

  Future<Session> getSession();

  Future<void> clearSession();
}

class AuthLocalDataSource implements AuthLocalDataSourceBase {
  final SharedPreferences shared;

  AuthLocalDataSource(this.shared);

  @override
  Future<void> cacheSession(Session session) async {
    await shared.setString('token', session.token);
    await shared.setString('uid', session.uid);
  }

  @override
  Future<Session> getSession() async {
    return SessionModel(
      token: shared.getString('token') ?? '',
      uid: shared.getString('uid') ?? '',
    );
  }

  @override
  Future<void> clearSession() {
    return shared.clear();
  }
}

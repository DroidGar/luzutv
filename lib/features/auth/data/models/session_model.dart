import 'package:luzu/features/auth/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel({required super.token, required super.uid});
}
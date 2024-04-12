import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';
import '../models/user.dart';
import '../methods/auth_methods.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthMethode _authMethode = AuthMethode();

  Users? get user => _user;

  Future<void> refreshUser() async {
    Users userDetails = await _authMethode.getUserDetails();
    _user = userDetails;
    notifyListeners();
  }
}



import 'package:mynotes/services/auth/auth_exeptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('cant log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedExeption>()),
      );
    });

    test('should be able to initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('user should be null', () {
      expect(provider.currentUser, null);
    });

    test(
      'should be able to initialized in less than 2 secs',
      () async {
        // await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
    test('create user should deligate to login', () async {
      final bademailuser = provider.createUser(
        email: 'crisis@mail.com',
        password: 'yoyoyoyoyo',
      );
      expect(
        bademailuser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badpassworduser = provider.createUser(
        email: 'yooyoy@yo.com',
        password: 'antubantu',
      );
      expect(
        badpassworduser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(
        email: 'foo',
        password: 'bar',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('logged in user should be verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('should be able to logout and login again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'etrgtr',
        password: 'sadasd',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedExeption implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedExeption();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedExeption();
    if (email == 'crisis@mail.com') throw UserNotFoundAuthException();
    if (password == 'antubantu') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedExeption();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedExeption();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newuser = AuthUser(isEmailVerified: true);
    _user = newuser;
  }
}

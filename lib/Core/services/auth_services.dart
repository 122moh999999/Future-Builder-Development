import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// الحصول على المستخدم الحالي
  User? get currentUser => _auth.currentUser;

  /// الحصول على تيار حالة المصادقة
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// تسجيل الدخول بالبريد وكلمة السر
  Future<User?> myLogin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني';
          break;
        case 'wrong-password':
          errorMessage = 'كلمة المرور غير صحيحة';
          break;
        case 'invalid-email':
          errorMessage = 'البريد الإلكتروني غير صالح';
          break;
        default:
          errorMessage = 'خطأ في تسجيل الدخول: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('خطأ غير متوقع في تسجيل الدخول: $e');
    }
  }

  /// إنشاء حساب جديد بالبريد وكلمة السر
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'هذا البريد الإلكتروني مستخدم بالفعل';
          break;
        case 'weak-password':
          errorMessage = 'كلمة المرور ضعيفة جداً';
          break;
        case 'invalid-email':
          errorMessage = 'البريد الإلكتروني غير صالح';
          break;
        default:
          errorMessage = 'خطأ في إنشاء الحساب: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('خطأ غير متوقع في إنشاء الحساب: $e');
    }
  }

  /// إرسال إيميل لإعادة تعيين كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'البريد الإلكتروني غير صالح';
          break;
        case 'user-not-found':
          errorMessage = 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني';
          break;
        default:
          errorMessage = 'خطأ في إعادة تعيين كلمة المرور: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('خطأ غير متوقع في إعادة تعيين كلمة المرور: $e');
    }
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('خطأ في تسجيل الخروج: $e');
    }
  }
}

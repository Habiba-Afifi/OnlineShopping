import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'admin_login_state.dart';

class AdminLoginCubit extends Cubit<AdminLoginState> {
  AdminLoginCubit() : super(AdminLoginInitial());

  Future<void> loginAdmin(String email, String password) async {
    emit(AdminLoginLoading());
    try {
      // Fetch admin data from Firestore
      final snapshot =
          await FirebaseFirestore.instance.collection("Admin").get();

      // Check if admin exists
      snapshot.docs.firstWhere(
        (doc) {
          final data = doc.data();
          return data['email'] == email && data['password'] == password;
        },
      );

      emit(AdminLoginSuccess());
    } catch (e) {
      emit(AdminLoginError("Failed to login: $e"));
    }
  }
}

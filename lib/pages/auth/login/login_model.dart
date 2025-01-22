// lib/pages/auth/login/login_model.dart
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_model.dart';

class LoginModel extends FlutterFlowModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

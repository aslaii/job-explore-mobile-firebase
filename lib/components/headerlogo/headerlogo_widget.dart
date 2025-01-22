import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'headerlogo_model.dart';
export 'headerlogo_model.dart';

class HeaderlogoWidget extends StatefulWidget {
  const HeaderlogoWidget({super.key});

  @override
  State<HeaderlogoWidget> createState() => _HeaderlogoWidgetState();
}

class _HeaderlogoWidgetState extends State<HeaderlogoWidget> {
  late HeaderlogoModel _model;

  Future<void> _signOut() async {
    setState(() => _model.isLoading = true);
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        await Future.delayed(Duration.zero);
        if (!context.mounted) return;
        context.goNamed("Login");
        //Navigator.pushNamedAndRemoveUntil(
        //  context,
        //  'Login',
        //  (route) => false,
        //);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error signing out: $e',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _model.isLoading = false);
      }
    }
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderlogoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 130.0,
                height: 50.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          if (_model.isLoading)
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primary,
                strokeWidth: 2,
              ),
            )
          else
            PopupMenuButton<String>(
              offset: const Offset(0, 40),
              icon: FaIcon(
                FontAwesomeIcons.solidUserCircle,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 28.0,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'signOut':
                    _signOut();
                    break;
                  case 'profile':
                    // Add profile navigation here
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Profile',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'signOut',
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sign Out',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

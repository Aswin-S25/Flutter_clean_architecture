// lib/main.dart

import 'package:clean_architecture/features/auth/presentation/pages/login_pages.dart';
import 'package:clean_architecture/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'service_locator.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture with BLoC',
      home: BlocProvider<AuthBloc>(
        create: (context) => di.sl<AuthBloc>(),
        child: RegisterPage(),
      ),
    );
  }
}

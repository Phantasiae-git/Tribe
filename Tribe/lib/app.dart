import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tribe/features/auth/data/node_auth_repo.dart';
import 'package:tribe/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tribe/features/auth/presentation/cubits/auth_states.dart';
import 'package:tribe/features/auth/presentation/pages/auth_page.dart';
import 'package:tribe/features/home/presentation/pages/home_page.dart';
import 'package:tribe/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  final authRepo = NodeAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //providing the cubit to the main app
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        title: "Tribe",
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Unauthenticated) {
              return const AuthPage();
            }
            if (authState is Authenticated) {
              return const HomePage();
            } else {
              //loading?
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
          listener: (context, state) {
            if(state is AuthError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}

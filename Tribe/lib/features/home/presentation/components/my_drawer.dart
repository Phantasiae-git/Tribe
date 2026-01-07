import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tribe/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tribe/features/home/presentation/components/my_drawer_tile.dart';
import 'package:tribe/features/profile/presentation/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              Divider(color: Theme.of(context).colorScheme.secondary,),
              MyDrawerTile(title: "HOME", icon: Icons.home, onTap: () => Navigator.of(context).pop()),
              MyDrawerTile(title: "PROFILE", icon: Icons.person_2, onTap: () {
                Navigator.of(context).pop();
                final user = context.read<AuthCubit>().currentUser;
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(uid: user!.uid),));
              }),
              MyDrawerTile(title: "FIND YOUR TRIBE", icon: Icons.people, onTap: () {}),
              MyDrawerTile(title: "SEARCH USERS", icon: Icons.search, onTap: () {}),
              MyDrawerTile(title: "SETTINGS", icon: Icons.settings, onTap: () {}),

              const Spacer(),

              MyDrawerTile(title: "LOGOUT", icon: Icons.logout, onTap: () => context.read<AuthCubit>().logout()),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:demo_clean_architech_riverpod/routes/app_route.gr.dart';
import 'package:demo_clean_architech_riverpod/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:demo_clean_architech_riverpod/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:demo_clean_architech_riverpod/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardDrawer extends ConsumerWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider).asData?.value;

    return SafeArea(
        bottom: false,
        child: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background),
                accountName: Text(
                  '${currentUser?.firstName}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                accountEmail: Text(
                  '${currentUser?.email}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('${currentUser?.image}'),
                ),
                otherAccountsPictures: [
                  InkWell(
                    onTap: () async {
                      await ref.read(userLocalRepositoryProvider).deleteUser();

                      if (context.mounted) {
                        context.router.pushAndPopUntil(LoginRoute(),
                            predicate: (_) => false);
                      }
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.logout,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(appThemeProvider.notifier).toggleTheme();
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

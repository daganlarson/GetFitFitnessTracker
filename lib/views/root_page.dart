import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/LoginProvider.dart';
import 'login_page.dart';
import 'loading_page.dart';
import 'home_page.dart';


class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginStatus.instance(),
      child: Consumer(
        builder: (context, LoginStatus loginStatus, _) {
          switch (loginStatus.status) {
            case Status.Uninitialized:
              return const LoadingPage();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return const LoginPage();
            case Status.Authenticated:
              return const HomePage();
              default:
                return const LoginPage();
          }
        },
      ),
    );
  }

}

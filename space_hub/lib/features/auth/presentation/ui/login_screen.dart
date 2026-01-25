import 'package:flutter/widgets.dart';
import 'package:space_hub/shared/ui/space_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      body: Container(
        color: const Color.fromARGB(255, 16, 161, 33),
        child: const Center(child: Text('Login Screen')),
      ),
    );
  }
}

import 'package:ui_kit/ui_kit.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      body: Container(
        color: const Color.fromARGB(255, 16, 161, 137),
        child: const Center(child: Text('Registration Screen')),
      ),
    );
  }
}

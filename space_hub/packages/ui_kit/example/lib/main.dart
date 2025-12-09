// ignore_for_file: avoid_redundant_argument_values
import 'package:ui_kit/ui_kit.dart';

void main() {
  runApp(const UiDemoApp());
}

class UiDemoApp extends StatelessWidget {
  const UiDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Kit Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const UiShowcaseScreen(),
    );
  }
}

class UiShowcaseScreen extends StatefulWidget {
  const UiShowcaseScreen({super.key});

  @override
  State<UiShowcaseScreen> createState() => _UiShowcaseScreenState();
}

class _UiShowcaseScreenState extends State<UiShowcaseScreen> {
  void _showDemoDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Demo dialog'),
          content: const Text(
            'UI-kit dialog'
            'some description text to show how it looks in a dialog.',
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Kit Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Buttons'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SpaceButton.primary(text: 'Primary Button', onPressed: () {}),
              SpaceButton.secondary(text: 'Secondary Button', onPressed: () {}),
            ],
          ),
          const SizedBox(height: 32),
          const _SectionTitle('Checkboxes / Toggles'),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: _checkboxValue,
          //       onChanged: (value) {
          //         setState(() => _checkboxValue = value ?? false);
          //       },
          //     ),
          //     const SizedBox(width: 8),
          //     const Text('Some checkbox'),
          //   ],
          // ),
          const SizedBox(height: 32),
          const _SectionTitle('Text fields'),
          // const TextField(
          //   decoration: InputDecoration(
          //     labelText: 'Demo input',
          //     hintText: 'Type something...',
          //   ),
          // ),
          const SizedBox(height: 32),
          const _SectionTitle('Logos / Icons'),
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Icon(Icons.apple),
              // Icon(Icons.android),
              // Icon(Icons.chat_bubble_outline),
            ],
          ),
          const SizedBox(height: 32),
          const _SectionTitle('Dialogs'),
          ElevatedButton(
            onPressed: _showDemoDialog,
            child: const Text('Open demo dialog'),
          ),
          const SizedBox(height: 32),
          const _SectionTitle('Typography'),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Title style',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 8),
              // Text('Body style', style: TextStyle(fontSize: 16)),
              // SizedBox(height: 8),
              // Text(
              //   'Longer paragraph text to see how it looks in a block of text. '
              //   'Здесь можно подставить свои TextStyles из UI-кита.',
              // ),
            ],
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

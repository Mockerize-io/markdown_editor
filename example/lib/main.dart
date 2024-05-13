import 'package:flutter/material.dart';
import 'package:markdown_editor/markdown_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController exampleController = TextEditingController();
  final ScrollController parseScrollController = ScrollController();

  Stream<String> sampleListener(TextEditingController controller) async* {
    // <- here
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield controller.value.text;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    exampleController.dispose();
    parseScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Form Field - Editor"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: sampleListener(exampleController),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: snapshot.hasError
                        ? const Text('Error')
                        : MarkdownParse(
                            data: snapshot.data ?? ' ',
                            controller: parseScrollController,
                            selectable: true,
                            shrinkWrap: true,
                          ),
                  );
                },
              ),
              MarkdownFormField(
                controller: exampleController,
                minLines: 10,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    top: 120,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  label: const Text('Test'),
                  hintText: "Type here. . .",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

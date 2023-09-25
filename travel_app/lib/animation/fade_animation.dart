import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum AnimationType { opacity, translateX }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final bool isLoading; // Boolean flag to control loading spinner

  const FadeAnimation({
    Key? key,
    required this.delay,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1.0, // Adjust opacity as needed when not loading
          child: child,
        ),
        if (isLoading) // Display the loading spinner conditionally
          const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue, // Customize the color as needed
              size: 50.0, // Adjust the size as needed
            ),
          ),
      ],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: YourPage(),
    );
  }
}

class YourPage extends StatefulWidget {
  const YourPage({super.key});

  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  bool isLoading = false; // Flag to control loading spinner visibility

  // Simulate a time-consuming operation
  void fetchData() {
    setState(() {
      isLoading = true; // Display the loading spinner
    });

    // Simulate a time-consuming operation (e.g., fetching data from an API)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading =
            false; // Hide the loading spinner when the operation is done
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Your content, including the FadeAnimation widget
          FadeAnimation(
            delay: 0.5,
            isLoading: isLoading,
            child: const YourContentWidget(), // Pass the isLoading flag
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger the fetchData function to start loading
          fetchData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class YourContentWidget extends StatelessWidget {
  const YourContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Your content widget goes here
    return const Text('Your Content');
  }
}

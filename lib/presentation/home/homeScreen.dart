import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LinkTokenConfiguration _linkTokenConfiguration;
  String status = "Click To Link Bank Account".toUpperCase();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _linkTokenConfiguration = LinkTokenConfiguration(
      token: "link-sandbox-42ede7b8-6c79-4d2c-9c66-d4cae2fb91b9",
    );

    PlaidLink.onSuccess(_onSuccessCallback);
    PlaidLink.onEvent(_onEventCallback);
    PlaidLink.onExit(_onExitCallback);
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
    setState(() {
      status = "yay! Your linked bank is bank of america".toUpperCase();
    });
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      print("onExit error: ${error.description()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: () =>
                PlaidLink.open(configuration: _linkTokenConfiguration),
            child: Text(
              status,
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ),
      ),
    );
  }
}

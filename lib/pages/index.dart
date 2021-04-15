import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Menu"),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/formulir');
              },
              child: Text("Daftar Baru"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pendaftar');
              },
              child: Text("Pendaftar"),
            )
          ],
        ),
      ),
    );
  }
}

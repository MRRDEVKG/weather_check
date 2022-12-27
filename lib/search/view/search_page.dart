import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const routeName = 'search';

  @override
  Widget build(BuildContext context) {
    final locationController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.lightBlue),
        title: Text(
          'WeatherCheck',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[Colors.greenAccent, Colors.lightBlue],
              ).createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
              ),
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: locationController,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(fontStyle: FontStyle.italic),
                    hintText: 'Bishkek',
                    hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(locationController.text);
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.lightBlue,
                  semanticLabel: 'Submit',
                ))
          ],
        ),
      ),
    );
  }
}

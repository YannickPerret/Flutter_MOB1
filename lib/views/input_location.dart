import 'package:flutter/material.dart';

class InputLocation extends StatelessWidget {
  InputLocation({Key? key}) : super(key: key);

  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E21),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
                controller: locationController,
                onChanged: (v) => locationController.text = v,
                decoration: const InputDecoration(
                  labelText: 'Nom de la ville',
                  labelStyle: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
              builder: (context) {
                return FractionallySizedBox(
                  widthFactor: 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      if (locationController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Le nom de la ville doit contenir 1 caractères minimum'),
                        ));
                      } else {
                        Navigator.pushNamed(context, '/',
                            arguments: locationController.text);
                      }
                    },
                    child: const Text('Search'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

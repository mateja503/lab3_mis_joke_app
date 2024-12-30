import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget {
  final List<String> types;

  const TypeCard({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: types.length,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.red[50],
          onTap: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: types[index],
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red.withOpacity(0.8), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                types[index],
                style:  TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
              
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


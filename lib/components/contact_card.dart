import 'package:contact_app/screens/detail_contact_screen.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(this.name, this.number, {super.key});

  final String name, number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailContact(
                name: name,
                number: number,
              ),
            ),
          ),
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[800],
              child: Text(name.substring(0, 1)),
            ),
            title: Text(name),
            subtitle: Text(number),
          ),
        ),
      ),
    );
  }
}

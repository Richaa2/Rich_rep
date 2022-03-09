import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Container(
              child: ListTile(
                leading: Text(
                  'ID: 1',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Column(
                  children: [
                    Text(
                      'My Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Email: test@test.ua',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Phone: 123456789',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:localstorage/localstorage.dart';

import '../../util/helpers.dart';

class StudentDrawerHeader extends StatelessWidget {
  StudentDrawerHeader({Key? key}) : super(key: key);
  final localStorage = LocalStorage('store');
  final baseUrl = FlavorConfig.instance.variables['baseUrl'];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: localStorage.ready,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Text('');
          }

          if (localStorage.getItem('displayName') == null) {
            return const Text('');
          }

          String displayName = localStorage.getItem('displayName');
          String entry = localStorage.getItem('email').split('@')[0];

          return DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.blue.shade800,
                  child: const CircleAvatar(
                    radius: 38,
                    child: ClipOval(
                        child: Icon(
                      Icons.person,
                      size: 60,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  formatDisplayName(displayName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  entry.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

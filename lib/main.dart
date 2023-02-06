import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './models/user.dart';

void main() {
  runApp(const MyApp());
}

Future<List<User>> fetchUsersData() async {
  final dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/users');
  if (response.statusCode == 200) {
    Iterable userList = response.data;
    return List<User>.from(userList.map((userJson) => User.fromJson(userJson)));
  } else {
    throw Exception("An error occurred on fetching users data!");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freezed guide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsersData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(
                      '${user.address!.street}, ${user.address!.city}, ${user.address!.zipcode}'),
                  tileColor: Colors.white,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

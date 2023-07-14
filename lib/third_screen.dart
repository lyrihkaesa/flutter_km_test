import 'package:flutter/material.dart';
import 'package:flutter_km_test/components/custom_elevated_button.dart';
import 'package:flutter_km_test/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int currentPage = 1;
  int perPage = 10;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=$perPage'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> userList = data['data'];

        List<User> fetchedUsers = userList.map((user) => User.fromJson(user)).toList();

        setState(() {
          users.addAll(fetchedUsers);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectUser(String userName) {
    Navigator.pop(context, userName);
  }

  Future<void> refreshData() async {
    setState(() {
      users.clear();
      currentPage = 1;
    });
    await fetchData();
  }

  Future<void> loadNextPage() async {
    setState(() {
      currentPage++;
    });
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFF04021D),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.builder(
          itemCount: users.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == users.length) {
              return buildLoader();
            } else {
              final user = users[index];
              return ListTile(
                title: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Color(0xFF04021D),
                  ),
                ),
                subtitle: Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Color(0xFF686777),
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
                onTap: () {
                  selectUser('${user.firstName} ${user.lastName}');
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildLoader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: isLoading
          ? const CircularProgressIndicator()
          : users.isEmpty
              ? const Text('No users found.')
              : CustomElevatedButton(onPressed: loadNextPage, text: "Load More"),
    );
  }
}

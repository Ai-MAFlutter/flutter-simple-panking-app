import 'package:flutter/material.dart';
import 'package:panking_app/services/db_helper.dart';
import 'details.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  DBHelper db = DBHelper();
  List users = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    users = await db.getUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Customers",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigoAccent.withOpacity(0.8), Colors.white],
          ),
        ),
        child: users.isEmpty 
          ? const Center(child: CircularProgressIndicator(color: Colors.indigo))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              itemCount: users.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), 
                  ),
                  elevation: 5,
                  shadowColor: Colors.black26,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100,
                      child: Icon(Icons.person, color: Colors.indigo.shade800),
                    ),
                    title: Text(
                      users[i]["name"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 18,
                        color: Colors.indigo,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Balance: \$${users[i]["balance"]}",
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(user: users[i]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'transfer.dart';

class Details extends StatelessWidget {
  final Map user;

  const Details({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user["name"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigoAccent.withOpacity(0.8), Colors.white],
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 12,
            shadowColor: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo.shade50,
                    child: const Icon(Icons.person, size: 60, color: Colors.indigo),
                  ),
                  const SizedBox(height: 20),
                  
                  Text(
                    user["name"],
                    style: const TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    "${user["email"]}",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(thickness: 1, indent: 20, endIndent: 20),
                  ),
                  
                  const Text(
                    "Current Balance",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${user["balance"]}",
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    label: const Text(
                      "Transfer Money",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Transfer(user: user),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
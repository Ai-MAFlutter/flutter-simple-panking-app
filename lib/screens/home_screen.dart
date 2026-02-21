import 'package:flutter/material.dart';
import 'package:panking_app/screens/customers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bank App",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, size: 80, color: Colors.indigo),
            const SizedBox(height: 30),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: Colors.indigo, 
                minimumSize: const Size(250, 60), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
                elevation: 10, 
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Customers()),
                );
              },
              child: const Text(
                "View All Customers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
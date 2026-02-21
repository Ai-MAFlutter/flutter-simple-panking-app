import 'package:flutter/material.dart';
import 'package:panking_app/services/db_helper.dart';

class Transfer extends StatefulWidget {
  final Map user;

  const Transfer({super.key, required this.user});

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  DBHelper db = DBHelper();
  List users = [];
  int? selectedId;
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  loadUsers() async {
    users = await db.getUsers();
    users.removeWhere((u) => u["id"] == widget.user["id"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Money", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigoAccent.withOpacity(0.8), Colors.white],
          ),
        ),
        child: SingleChildScrollView( 
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Transfer From:",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${widget.user["name"]} (Balance: \$${widget.user["balance"]})",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                    const Divider(height: 30),
                    
                    const Text(
                      "Transfer To:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_add, color: Colors.indigo),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      hint: const Text("Select recipient"),
                      value: selectedId,
                      items: users.map((u) {
                        return DropdownMenuItem(
                          value: u["id"],
                          child: Text(u["name"]),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedId = val as int;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 25),
                    
                    const Text(
                      "Amount to Send:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: amount,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money, color: Colors.green),
                        hintText: "0.00",
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 35),
                    
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        if (selectedId != null && amount.text.isNotEmpty) {
                          await db.transfer(widget.user["id"], selectedId!,
                              double.parse(amount.text));
                          
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("✅ Transfer Successful"),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context); 
                        }
                      },
                      child: const Text(
                        "Confirm Transfer",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
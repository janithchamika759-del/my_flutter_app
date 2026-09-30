import 'package:flutter/material.dart';

void main() {
  runApp(const EmergencyServiceApp());
}

class EmergencyServiceApp extends StatelessWidget {
  const EmergencyServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'High-Trust Service App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MainNavigationController(),
    );
  }
}

class MainNavigationController extends StatefulWidget {
  const MainNavigationController({super.key});

  @override
  State<MainNavigationController> createState() => _MainNavigationControllerState();
}

class _MainNavigationControllerState extends State<MainNavigationController> {
  bool isWorkerMode = false;
  int selectedIndex = 0;

  void toggleMode(bool value) {
    setState(() {
      isWorkerMode = value;
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isWorkerMode ? 'Worker Dashboard' : 'Client Dashboard'),
        actions: [
          Row(
            children: [
              Text(
                isWorkerMode ? "Worker" : "Client",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Switch(
                value: isWorkerMode,
                onChanged: toggleMode,
                activeColor: Colors.orangeAccent,
              ),
            ],
          )
        ],
      ),
      body: isWorkerMode ? const WorkerDashboardView() : const ClientDashboardView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: isWorkerMode
            ? const [
                BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Requests'),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
              ]
            : const [
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Services'),
                BottomNavigationBarItem(icon: Icon(Icons.warning_amber), label: 'SOS Emergency'),
              ],
      ),
    );
  }
}

class ClientDashboardView extends StatelessWidget {
  const ClientDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: Colors.red.shade50,
          child: ListTile(
            leading: const Icon(Icons.sos, color: Colors.red, size: 40),
            title: const Text('Roadside SOS Emergency', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Tow Truck, Battery Jumpstart, Flat Tyre'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SOS Broadcast Sent to Nearby Workers!')),
                );
              },
              child: const Text('TRIGGER'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Micro Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.plumbing, color: Colors.indigo),
          title: const Text('Plumbing Repair'),
          subtitle: const Text('Base Rate: Rs. 1500 + KM Charge'),
          trailing: const Icon(Icons.verified, color: Colors.green),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.electric_bolt, color: Colors.indigo),
          title: const Text('Electrical Repairs'),
          subtitle: const Text('Base Rate: Rs. 1200 + KM Charge'),
          trailing: const Icon(Icons.verified, color: Colors.green),
          onTap: () {},
        ),
      ],
    );
  }
}

class WorkerDashboardView extends StatelessWidget {
  const WorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: Colors.green.shade50,
          child: const ListTile(
            leading: Icon(Icons.verified_user, color: Colors.green, size: 36),
            title: Text('Verification Status: Police Verified'),
            subtitle: Text('Badge Active • ID Match 94%'),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Incoming Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            title: const Text('SOS Job: Battery Jumpstart (#JOB-9921)'),
            subtitle: const Text('Location: 2.4 KM Away'),
            trailing: ElevatedButton(
              onPressed: () {},
              child: const Text('Accept'),
            ),
          ),
        ),
      ],
    );
  }
}

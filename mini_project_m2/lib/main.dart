import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StudentDashboard(),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MY Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Profile Picture

              // const CircleAvatar(
              //   radius: 45,
              //   child: Icon(Icons.person, size: 50),
              // ),

              // Profile Picture with Online Indicator

              Stack(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    child: Icon(Icons.person, size: 50),
                  ),

                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Student Information
              const Text(
                'Abir',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const Text('Computer Science & Engineering'),

              const Text('IIUC'),

              const SizedBox(height: 30),

              // Statistics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.blue.shade100,
                    child: const Column(
                      children: [
                        Icon(Icons.folder),
                        Text('05'),
                        Text('Projects'),
                      ],
                    ),
                  ),

                  //const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.orange.shade100,
                    child: const Column(
                      children: [Icon(Icons.book), Text('08'), Text('Courses')],
                    ),
                  ),

                  // const SizedBox(height: 15),

                  // Container(
                  //   padding: const EdgeInsets.all(15),
                  //   color: Colors.green.shade100,
                  //   child: const Column(
                  //     children: [
                  //       Icon(Icons.task_alt),
                  //       Text('12'),
                  //       Text('Tasks'),
                  //     ],
                  //   ),
                  // ),
                  // Stack(
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(15),
                  //       color: Colors.green.shade100,
                  //       child: const Column(
                  //         children: [
                  //           Icon(Icons.task_alt),
                  //           Text('12'),
                  //           Text('Tasks'),
                  //         ],
                  //       ),
                  //     ),

                  //     Positioned(
                  //       top: 0,
                  //       right: 0,
                  //       child: Icon(
                  //         Icons.check_circle,
                  //         color: Colors.green,
                  //         size: 20,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),

              const SizedBox(height: 30),

              // Button
              ElevatedButton(
                onPressed: () {},
                child: const Text('View Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

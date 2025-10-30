import 'package:flutter/material.dart';

class AppointmentConfirmation extends StatelessWidget {
  final String appointmentDate;
  final String appointmentTime;

  const AppointmentConfirmation({
    super.key,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 215, 240),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: double.infinity,
              color: Color.fromARGB(255, 175, 215, 240),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Appointment Confirmed",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ✅ Confirmation Card
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("assets/images/doctor.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Appointment Confirmed!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Your appointment is confirmed for",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,)
                      ,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "$appointmentDate at $appointmentTime",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "You will receive a reminder email shortly before the appointment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2CA58D),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                     Navigator.pushNamed(context, '/homePage');
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inner_samvad/homePage.dart';
import 'appointmentConfirmation.dart';
import 'package:intl/intl.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String appointmentMode = "Online";

  Future<void> saveAppointment() async {
    try {
      final String selectedDate = dateController.text;
      final String selectedTime = timeController.text;

      await FirebaseFirestore.instance.collection("appointments").add({
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "symptoms": symptomsController.text,
        "date": selectedDate,
        "time": selectedTime,
        "mode": appointmentMode,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentConfirmation(
            appointmentDate: selectedDate,
            appointmentTime: selectedTime,
          ),
        ),
      );

      nameController.clear();
      emailController.clear();
      phoneController.clear();
      symptomsController.clear();
      dateController.clear();
      timeController.clear();
      setState(() => appointmentMode = "Online");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color(0xFF2CA58D),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
      ),
      title: const Text(
        "Book Appointment",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    ),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 175, 215, 240),
            Color.fromARGB(255, 234, 240, 246),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Info
                      const Text(
                        "Personal Information",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      TextField(
                        controller: nameController,
                        decoration: _inputDecoration("Full name*"),
                      ),
                      const SizedBox(height: 12),

                      TextField(
                        controller: emailController,
                        decoration: _inputDecoration("E-mail"),
                      ),
                      const SizedBox(height: 12),

                      TextField(
                        controller: phoneController,
                        decoration: _inputDecoration("Phone Number"),
                      ),

                      const SizedBox(height: 20),

                      // Appointment Mode
                      const Text(
                        "Appointment Mode",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          ChoiceChip(
                            label: const Text("Online"),
                            selected: appointmentMode == "Online",
                            onSelected: (selected) {
                              setState(() => appointmentMode = "Online");
                            },
                          ),
                          const SizedBox(width: 10),
                          ChoiceChip(
                            label: const Text("Offline (Mumbai, Agra, Bengaluru)"),
                            selected: appointmentMode == "Offline",
                            onSelected: (selected) {
                              setState(() => appointmentMode = "Offline");
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Appointment Info
                      const Text(
                        "Appointment Information",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      TextField(
                        controller: symptomsController,
                        maxLines: 3,
                        decoration: _inputDecoration(
                            "Please describe your symptoms..."),
                      ),

                      const SizedBox(height: 20),

                      // Date
                      const Text(
                        "Date",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      TextField(
                        controller: dateController,
                        readOnly: true,
                        decoration: _inputDecoration("Select Date"),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat("MMM d, yyyy").format(pickedDate);
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      // Time
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      TextField(
                        controller: timeController,
                        readOnly: true,
                        decoration: _inputDecoration("Select Time"),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final now = DateTime.now();
                            final dt = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                pickedTime.hour,
                                pickedTime.minute);

                            final formattedTime =
                                TimeOfDay.fromDateTime(dt).format(context);

                            setState(() {
                              timeController.text = formattedTime;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2CA58D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Request Appointment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo
                Image.asset(
                  'assets/images/samvad_logo.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),


                const SizedBox(height: 40),

                // Welcome heading
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Description text
                const Text(
                  "Here, every thought is heard, every feeling is valid.\n"
                  "Take a deep breath — you’ve found a space where healing begins with a conversation.",
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),

                // Sign In button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // ✅ Important to remove default padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,   // horizontal start
                          end: Alignment.centerRight,    // horizontal end
                          colors: [
                            Color.fromARGB(255, 98, 158, 236), // left color
                            Color.fromARGB(255, 108, 192, 162), // right color
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // ✅ Better contrast on gradient
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Log in text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Login screen
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
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

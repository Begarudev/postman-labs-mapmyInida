import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Page'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Color(0xFF00ACD7)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MapMyIndia Hacakthon',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(
                          0xFF00ACD7,
                        ),
                      ),
                    ),
                    Text('89%',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '80m away',
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.east_rounded,
                      color: Color(0xFF00ACD7),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Navigate Now',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: const Color(0xFF00ACD7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

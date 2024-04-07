import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mappls_flutter_sdk/pages/utils/riverpod.dart';

class EventsPage extends ConsumerWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocationprov = ref.watch(currentLocationProvider);
    final uri = Uri.parse(
        "https://findafriend.bits-postman-lab.in/api/events/see-events");
    currentLocationprov.when(
      data: (data) {
        final response = http.post(uri,
            body: {"latitude": data.latitude, "longitude": data.longitude});
        return Scaffold(
            appBar: AppBar(
              title: const Text('Events Page'),
            ),
            body: FutureBuilder(
                future: response,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final response = snapshot.data!.body;
                    final eventsMaps =
                        jsonDecode(response) as Map<String, dynamic>;
                    final eventslist = eventsMaps["events"] as List<dynamic>;
                    return ListView.builder(
                        itemCount: eventslist.length,
                        itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side:
                                    const BorderSide(color: Color(0xFF00ACD7)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          eventslist[index],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '80m away',
                                          style: GoogleFonts.montserrat(
                                              color: Colors.grey),
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
                            ));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }));
      },
      error: (error, stackTrace) => Center(
        child: Text("$error"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

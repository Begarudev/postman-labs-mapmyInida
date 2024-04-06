import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mappls_flutter_sdk/pages/mapmy_india_map.dart';

import 'events_page.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        title: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Go",
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(0, 172, 215, 1),
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900),
                ),
                TextSpan(
                  text: "CROWD",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.person),
          color: Colors.white,
          onPressed: () {
            // context.push("/profileScreen");
            // showDialog(
            //   context: context,
            //   builder: (context) => ProfileScreen(),
            // );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                // context.push('/notification');
              },
              icon: const Icon(Icons.notifications_active))
        ],
      ),
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: true,
      floatingActionButton: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  context.push("/share");
                },
                icon: const Icon(Icons.send)),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const EventsPage(),
                  );
                },
                icon: const Icon(Icons.event_note_outlined)),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          foregroundDecoration: const BoxDecoration(
            color: Colors.white,
            backgroundBlendMode: BlendMode.difference,
          ),
          child: const MapMyIndia(),
        ),
      ),
    );
  }
}

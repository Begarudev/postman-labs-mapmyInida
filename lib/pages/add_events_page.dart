import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class AddEventsScreen extends StatelessWidget {
  const AddEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final uri =
        Uri.parse("https://findafriend.bits-postman-lab.in/api/events/near");
    final response = http.get(
      uri,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: const Text("Share Events Around You")),
      ),
      body: Center(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FutureBuilder(
                future: response,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    case ConnectionState.active:
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        final response = snapshot.data!.body;
                        final eventsMaps =
                            jsonDecode(response) as Map<String, dynamic>;
                        final eventslist = (eventsMaps["events"] as List)
                            .map((e) => e.toString())
                            .toList();
                        return DropdownSearch<String>(
                          items: eventslist,
                          popupProps: const PopupProps.menu(
                            showSearchBox: true,
                            menuProps: MenuProps(),
                          ),
                          dropdownButtonProps: const DropdownButtonProps(
                            color: Colors.blue,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              textAlignVertical: TextAlignVertical.center,
                              dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      gapPadding: 3,
                                      borderSide: const BorderSide(
                                          color: Colors.cyan)))),
                          onChanged: print,
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Start Time",
                        style: TextStyle(color: Color.fromRGBO(2, 153, 190, 1)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Color.fromRGBO(2, 153, 190, 1),
                          ),
                          SizedBox(
                            width: 130,
                            child: FormBuilderDateTimePicker(
                              name: "Start Time",
                              style: const TextStyle(
                                  color: Color.fromRGBO(2, 153, 190, 1)),
                              initialDate: DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  Gap(40),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "End Time",
                        style: TextStyle(color: Color.fromRGBO(2, 153, 190, 1)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Color.fromRGBO(2, 153, 190, 1),
                          ),
                          SizedBox(
                            width: 130,
                            child: FormBuilderDateTimePicker(
                              name: "End Time",
                              style: const TextStyle(color: Colors.white),
                              initialDate: DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.share),
                    Gap(4),
                    Text(
                      "Share",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: Text(data))
            ],
          ),
        ),
      ),
    );
  }
}

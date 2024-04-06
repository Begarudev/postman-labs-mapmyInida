import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class AddEventsScreen extends StatelessWidget {
  const AddEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _emailFieldKey = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Share Events Around You"),
      ),
      body: Center(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.white70)),
                ),
                child: FormBuilderTextField(
                  key: _emailFieldKey,
                  name: 'Name',
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.white70)),
                ),
                child: FormBuilderTextField(
                  name: 'description',
                  decoration: const InputDecoration(labelText: 'Description'),
                  obscureText: true,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Start Time"),
                  const Icon(Icons.calendar_month),
                  SizedBox(
                    width: 130,
                    child: FormBuilderDateTimePicker(
                      name: "Start Time",
                      style: const TextStyle(color: Colors.white),
                      initialDate: DateTime.now(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("End Time"),
                  const Icon(Icons.calendar_month),
                  SizedBox(
                    width: 130,
                    child: FormBuilderDateTimePicker(
                      name: "Start Time",
                      style: const TextStyle(color: Colors.white),
                      initialDate: DateTime.now(),
                    ),
                  ),
                ],
              ),
              const Gap(5),
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
            ],
          ),
        ),
      ),
    );
  }
}

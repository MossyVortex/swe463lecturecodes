import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FormsPage(),
    );
  }
}

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});
  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _majors = ['ICS', 'COE', 'SWE'];
  final _minController = TextEditingController(text: '0');
  final _maxController = TextEditingController(text: '0');
  void _onMinChanged() {
    final min = int.tryParse(_minController.text) ?? 0;
    _maxController.text = (min * 1.15).toString();
  }

  String _phone = '';
  String location = 'In Campus';
  String? _major;
  bool is_cx = false;
  String _name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormsPage'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: Icon(Icons.check),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value ?? '';
                    }),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Major',
                    suffixIcon: Icon(Icons.school),
                  ),
                  items: _majors
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  value: _major,
                  onChanged: (value) {
                    setState(() {
                      _major = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Major is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                    keyboardType: TextInputType.phone,
                    initialValue: '+9665',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    onSaved: (value) {
                      _phone = value ?? '';
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 12) {
                        return 'Phone number must be 12 digits';
                      }
                      return null;
                    }),
                ListTile(
                    title: const Text('Are you a CX student?'),
                    trailing: Switch(
                        value: is_cx,
                        onChanged: (value) {
                          setState(() {
                            is_cx = value;
                          });
                        })),
                const SizedBox(height: 10),
                RadioListTile<String>(
                  title: const Text('In Campus'),
                  value: 'In Campus',
                  groupValue: location,
                  onChanged: (value) {
                    setState(() {
                      location = value as String;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Off Campus'),
                  value: 'Off Campus',
                  groupValue: location,
                  onChanged: (value) {
                    setState(() {
                      location = value as String;
                    });
                  },
                ),
                TextFormField(
                  controller: _minController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  onChanged: (value) {
                    _onMinChanged();
                  },
                ),
                TextFormField(
                  enabled: false,
                  controller: _maxController,
                  decoration: InputDecoration(
                    labelText: 'Include 15% VAT',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final student = Student(
                        name: _name,
                        major: _major!,
                        fee: double.tryParse(_maxController.text) ?? 0,
                        is_cx: is_cx,
                        location: location,
                        phone: _phone,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        student.toString(),
                      )));
                    }
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Student {
  final String name;
  final String major;
  final double fee;
  final String location;
  final bool is_cx;
  final String phone;
  const Student(
      {required this.location,
      required this.name,
      required this.major,
      required this.fee,
      required this.is_cx,
      required this.phone});
  @override
  String toString() {
    return 'Student{name: $name, major: $major, fee: $fee, location: $location, is_cx: $is_cx, phone: $phone}';
  }
}

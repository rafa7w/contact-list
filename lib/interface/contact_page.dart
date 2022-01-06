import 'dart:io';
import 'package:contact_list/helpers/contact_help.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContactPage extends StatefulWidget {
  Contact? contact;

  ContactPage({Key? key, this.contact}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _userEdited = false;
  Contact? _editedContact;

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_null_comparison
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());
      _nameController.text = _editedContact!.name!;
      _emailController.text = _editedContact!.email!;
      _phoneController.text = _editedContact!.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContact!.name ?? 'Novo Contato'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editedContact!.img != null
                        ? FileImage(File(_editedContact!.img))
                        : const AssetImage('images/user.png'),
                  ),
                ),
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact!.name = text;
                });
              },
              controller: _nameController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact!.email = text;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact!.phone = text;
              },
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
          ],
        ),
      ),
    );
  }
}

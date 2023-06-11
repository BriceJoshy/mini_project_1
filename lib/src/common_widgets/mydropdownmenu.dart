import 'package:flutter/material.dart';
import 'package:mini_project_1/src/common_widgets/provider.dart';
import 'package:mini_project_1/src/constants/image_strings.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../features/authentication/screens/signinpage/signinpage.dart';

class MyDropDown extends StatefulWidget {
  final List<String> myList;
  final bool isEdit;
  const MyDropDown({Key? key, required this.myList, required this.isEdit})
      : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  late bool isFont = editCheck();

  editCheck() {
    if (widget.isEdit == true) {
      return isFont = true;
    } else {
      return isFont = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return myDropDown(widget.myList, context);
  }

  Widget myDropDown(List<String> lists, BuildContext context) {
    var tagProvider = Provider.of<TagProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .3),
                blurRadius: 20,
                offset: Offset(0, 2))
          ]),
      width: width * 1,
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Image(image: AssetImage(mySignInPageRoleIcon)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: null,
          labelStyle: const TextStyle(
              fontSize: 17, color: Colors.black, letterSpacing: .2),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          contentPadding: const EdgeInsets.all(3),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  selectedRole,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: isFont ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              borderRadius: BorderRadius.circular(20),
              autofocus: true,
              items: lists
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  isFont = true;
                });
                tagProvider.changeMenu();
                selectedRole = value!;
              }),
        ),
      ),
    );
  }
}

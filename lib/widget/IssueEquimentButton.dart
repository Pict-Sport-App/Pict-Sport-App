import 'package:flutter/material.dart';

class IssueEquimentWidget extends StatelessWidget {
  final Widget name;
  final VoidCallback onTap;
  const IssueEquimentWidget({Key? key,
  required this.name,
  required this.onTap}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 17),
        child: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: RaisedButton(
              onPressed: onTap,
              shape: const StadiumBorder(),
              color: Colors.redAccent,
              child: name,
            ),
          ),
        ),
      ),
    );
  }
}

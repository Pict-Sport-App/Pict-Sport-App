import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardItem extends StatelessWidget {

 final String? inputString2,inputString1,inputString3;
  const CardItem(
      {Key? key,
        required this.inputString1,
        this.inputString2,
        this.inputString3})
      : super(key: key);

  final String idname = "Mis Id";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), // shadow direction: bottom right
              )
            ],
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              inputString1 == 'Achievement'
                  ? const FaIcon(
                FontAwesomeIcons.shieldAlt,
                color: Colors.black,
                size: 25,
              )
              /*
              const FaIcon(
FontAwesomeIcons.arrowCircleLeft,
color: Colors.white,
size: 25,
),
               */
                  : inputString1 == 'About Myself'
                  ? const FaIcon(
                FontAwesomeIcons.addressCard,
                color: Colors.black,
                size: 25,
              )
                  : inputString1 == 'Sport '
                  ? const Icon(
                Icons.sports_baseball_sharp,
                size: 35,
              )
                  : inputString1 == 'Sport '
                  ? const FaIcon(
                FontAwesomeIcons.baseballBall,
                color: Colors.black,
                size: 25,
              )
                  : inputString1 == 'Date of Birth'
                  ? const FaIcon(
                FontAwesomeIcons.birthdayCake,
                size: 27,
              )
                  : inputString1 == 'Roll No'
                  ? const FaIcon(
                FontAwesomeIcons.listOl,
                color: Colors.black,
                size: 25,
              )
                  : const FaIcon(
                FontAwesomeIcons.envelope,
                color: Color(0xFF272D34),
                size: 25,
              ),
              const SizedBox(width: 24.0),
              inputString1 != 'MIS ID'
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    inputString1!,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  inputString2 != null
                      ? SizedBox(
                    width: 250,
                    child: Text(
                      inputString2!,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  )
                      : const SizedBox(),
                ],
              )
                  : EmailORMisId(
                misid: inputString2,
                mail: inputString3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class EmailORMisId extends StatefulWidget {
  String? mail;
  String? misid;
  EmailORMisId({Key? key, required this.mail, required this.misid}) : super(key: key);
  @override
  _EmailORMisIdState createState() => _EmailORMisIdState();
}

class _EmailORMisIdState extends State<EmailORMisId> {
  bool _isMail = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _isMail = false;
                });
              },
              child: Text(
                "MIS ID",
                style: TextStyle(
                  color: !_isMail ? Colors.black : Colors.grey,
                  fontSize: 18.0,
                ),
              ),
            ),
            const Text(
              " / ",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isMail = true;
                });
              },
              child: Text(
                "EMAIL ID",
                style: TextStyle(
                  color: _isMail ? Colors.black : Colors.grey,
                  fontSize: 18.0,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          width: 250,
          child: SelectableText(
            _isMail ? '${widget.mail}' : '${widget.misid}',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 15.0,
            ),
          ),
        )
      ],
    );
  }
}

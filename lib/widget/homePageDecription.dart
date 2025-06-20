import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:universal_html/html.dart' as html;
import '../constant/utils.dart';

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);
  static final appContainer = kIsWeb
      ? html.window.document.querySelectorAll('flt-glass-pane')[0]
      : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // title
        const FittedBox(
          child: Text('''Land Registration Using Blockchain''',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 241, 244, 248),
                fontSize: 50,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                //letterSpacing: 1.5,
              )),
        ),
        // Description

        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            '''
 
        ''',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 17, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              // letterSpacing: 1.5,
            ),
          ),
        ),

        // const SizedBox(
        //   height: 20,
        // ),

        // const SizedBox(
        //   height: 100,
        // )
      ],
    );
  }
}

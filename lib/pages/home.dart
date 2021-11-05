import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;

    String bgImage = data['isDayTime'] ? 'day_bg.png' : 'night_bg2.png';
    Color ? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage (
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 120, 40, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time' : result['time'],
                          'location' : result['location'],
                          'isDayTime' : result['isDayTime'],
                          'flag' : result['flag']
                        };
                      });
                    },
                    label : Text(
                        'Edit The Location',
                        style: GoogleFonts.firaSans(
                            textStyle: const TextStyle(
                                fontSize: 16.0
                            ),
                          color: Colors.tealAccent
                        ),
                    ),
                    icon: const Icon(
                        Icons.edit_location,
                        color: Colors.tealAccent
                    ),
                ),

                const SizedBox(height: 8.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                        data['location'],

                        style: GoogleFonts.firaSans(
                          textStyle: const TextStyle(
                            fontSize: 28,
                            letterSpacing: 2.0,
                            color: Colors.amberAccent
                          ),
                        ),
                    ),


                  ],
                ),

                const SizedBox(height: 20.0),

                Text(
                    data['time'],
                    style: GoogleFonts.firaSans(
                      textStyle: const TextStyle(
                          fontSize: 35,
                          letterSpacing: 2.0,
                          color: Colors.pinkAccent
                      ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

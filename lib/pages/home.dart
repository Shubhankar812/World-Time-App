import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Map? data = {};

  @override
  Widget build(BuildContext context) {

    data = data!.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map?;

    print(data);

    // set background
    String bgImage = data?['isDayTime'] ? 'day.png' : 'night.png';

    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
              child: Column(
                children: <Widget>[
              TextButton.icon(
                  onPressed: () async {
                   dynamic result = await Navigator.pushNamed(context, '/location');
                   setState(() {
                     data = {
                       'time' : result['time'],
                       'location' : result['location'],
                       'isDayTime' : result['isDayTime']
                     };
                   });
                  },
                  icon: Icon(
                      Icons.edit_location,
                      color : Colors.black,
                  ),
                  label: Text("Edit Location",
                 style: TextStyle(
                   color: Colors.black,
                 ),
            ),
              ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data?['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          // color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data?['time'],
                    style: TextStyle(
                      fontSize: 60.0,
                      // color: Colors.grey[300],
                    ),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}

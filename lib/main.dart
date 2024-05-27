import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.orange.withOpacity(0.2),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // child: ListWheelScrollView(
        //   itemExtent: 90,
        //   diameterRatio: RenderListWheelViewport.defaultDiameterRatio,
        //   // offAxisFraction: 0.7,
        //   // useMagnifier: true,
        //   // magnification: 0.1,
        //   // squeeze: 0.8,
        //   children: List.generate(20, (index) => index).map((e) {
        //     int color = 0xFF222EEA + (e * 100);
        //     return Container(
        //       // height: 10,
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //         color: Color(color),
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //     );
        //   }).toList(),
        // ),

        child: ListView.builder(
          itemCount: 20,
          itemBuilder: ((context, index) {
            int color = 0xFF222EEA + (index * 100);
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                ),
                // Transform(
                //   // duration: Duration(milliseconds: 100),
                //   // top: -10.0 * index,
                //   // left: 0,
                //   // right: 0,
                //   child: Container(
                //     width: double.infinity,
                //     height: 100,
                //     decoration: BoxDecoration(
                //       color: Color(color).withOpacity(0.7),
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                // ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

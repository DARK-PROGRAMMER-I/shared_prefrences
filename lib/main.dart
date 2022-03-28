// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyHomePage());


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SharedPrefs(),
    );
  }
}

class SharedPrefs extends StatefulWidget {
  const SharedPrefs({Key? key}) : super(key: key);

  @override
  _SharedPrefsState createState() => _SharedPrefsState();
}

class _SharedPrefsState extends State<SharedPrefs> {
  int? appCounter;
  // for paths
  String document_path= '';
  String tempraroy_path= '';
  // Variables for creating a file and inside text
  File? myFile;
  String? myText = '';

  // Method for reteriving paths
  Future getPaths()async{
    final doc_path = await getApplicationDocumentsDirectory();
     final  temp_path = await getTemporaryDirectory();

     setState(() {
       document_path = doc_path.path;
       tempraroy_path = temp_path.path;
     });
  }

  // Methods to create a file , read it and save its content
  Future<bool> writeOnFile()async{
    try{
      await myFile!.writeAsString("Hi there, Im Malik, Inshallah I will become a great Developer and Enterpernure ");

      return true;
    }catch(e){
        return false;
    };
  }
  // Read FIle
  Future<bool> readFile()async{
    try{
      String fileContent =  await myFile!.readAsString();
      setState(() {
        myText = fileContent;
      });
      return true;
    }catch(e){
      return false;
    };
  }


  @override
  void initState(){
    // readAndWritePrefrences();
    // initiallizing getPaths() method
    getPaths().then((_){
      myFile = File("$document_path/pizza.txt");
      writeOnFile();
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Prefrences!"),
        backgroundColor: Colors.purple[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Document Dir: $document_path'),

            Text("Temporary Dir: $tempraroy_path"),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple[900])
                ),
                onPressed: (){
                  readFile();
                  // setState(() {
                  //   Text("$myText");
                  // });
                },
                child: Text("Read File")),

            Text("$myText"),
            
            

            // Comenting Previous code

            // Text("You have opend app ${appCounter} times" , style: TextStyle(fontSize: 18),),
            // SizedBox(height: 20,),
            // ElevatedButton(
            //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[900])),
            //     onPressed: (){
            //       setState(() {
            //         deleteCounter();
            //       });
            //     },
            //     child: Text("Clear Counter"),
            // )
          ],
        ),
      ),
    );
  }



  Future readAndWritePrefrences()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    appCounter = sharedPreferences.getInt('appCounter');
    if(appCounter == null){
      appCounter = 1;
    }else{
      appCounter = appCounter !+ 1 ;
    }

    await sharedPreferences.setInt("appCounter", appCounter!);
    setState(() {
      appCounter = appCounter;
    });
  }

  // Delete Prefrences Counter
  Future deleteCounter()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }
}

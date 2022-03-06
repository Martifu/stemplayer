import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stem Player',
      home:  StemPlayer(),
    );
  }
}




class StemPlayer extends StatelessWidget {
  const StemPlayer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  AudioPlayer player1 = AudioPlayer();
  AudioPlayer player2 = AudioPlayer();
  AudioPlayer player4 = AudioPlayer();
  AudioPlayer player3 = AudioPlayer();

  List<AudioPlayer> players = [player1, player2, player3, player4];
 
    return Scaffold(
      backgroundColor: Colors.black,
      body:  SizedBox(
        width: size.width,
        
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://i.pinimg.com/564x/54/10/6d/54106d270e0885240f13167a51d12923.jpg', ),
           
           fit: BoxFit.cover ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Stack(
                children: [
                  Center(
                    child: Image.asset('assets/stem.png'),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: size.width * 0.02, top: size.height * 0.07),
                    child: SizedBox(
                      width: size.width,
                      child: Column(
                        children: [
                          GestureDetector(
                            onVerticalDragUpdate: (details) { 
                              
                              if (details.delta.dy > 0) {
                                print("arriba menos");
                               players[0].setVolume(   players[0].volume - 0.1);
                                
                              } else if (details.delta.dy < 0) {
                                print("arriba mas");

                                  players[0].setVolume(   players[0].volume + 0.1);

                              }
                            },
                            child: Container(
                              width: size.width*0.05,
                              height: size.height * 0.12,
                              color: Colors.transparent,
                            
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    if (details.delta.dx > 0) {
                                      print("izquierda menos");
                                      players[1].setVolume(   players[1].volume - 0.1);
                                    } else if (details.delta.dx < 0) {
                                      print("izquierda mas");

                                      players[1].setVolume(   players[1].volume + 0.1);
                                    }
                                  },
                                  child: Container(
                                    width: size.width * 0.25,
                                    height: size.height * 0.025,
                                    color: Colors.transparent,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async{
                                  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                                  if (result != null) {
                                    List<File> files = result.paths.map((path) => File(path.toString())).toList();

                                    for (var i = 0; i < files.length; i++) {
                                      try {
                                        await players[i].setFilePath(files[i].path);
                                        
                                      } catch (e) {
                                        print(e);
                                      }

                                    }

                                    players[0].play();
                                    players[1].play();
                                    players[2].play();
                                    players[3].play();
                                 
                                  } else {
                                    // User canceled the picker
                                  }

                                      
                                  },
                                  child: GestureDetector(
                                    onHorizontalDragUpdate: (details) {
                                      if (details.delta.dx > 0) {
                                        players[2].setVolume(   players[2].volume + 0.1);

                                        print("derecha mas");
                                      } else if (details.delta.dx < 0) {
                                        print("derecha menos");
                                        players[2].setVolume(   players[2].volume - 0.1);

                                      }
                                    
                                    },
                                    child: Container(
                                      width: size.width * 0.1,
                                      height: size.height * 0.05,
                                      color: Colors.transparent,
                                    
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    if (details.delta.dx > 0) {
                                      print("derecha subir");
                                      players[2].setVolume(   players[2].volume + 0.1);
                                    } else if (details.delta.dx < 0) {
                                       print("derecha bajar");
                                      players[2].setVolume(   players[2].volume - 0.1);
                                      
                                    }
                                  
                                  },
                                  child: Container(
                                    width: size.width * 0.25,
                                    height: size.height * 0.025,
                                    color: Colors.transparent,
                                  
                                  ),
                                )
                              ],
                            ),
                          )
                         , GestureDetector(
                            onVerticalDragUpdate: (details) { 
                              
                              if (details.delta.dy > 0) {
                                
                                 print("abajo mas");

                                  players[3].setVolume(   players[3].volume + 0.1);
                              } else if (details.delta.dy < 0) {
                                print("abajo menos");
                               players[3].setVolume(   players[3].volume - 0.1);
                               

                              }
                            },
                            child: Container(
                              width: size.width*0.05,
                              height: size.height * 0.12,
                              color: Colors.transparent,
                            
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            
            ],
          ),
        ),
      ),

    );
  }
}



import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'widgets/audio_list.dart';

bool globalstarted = false;
bool globalisPlaying = false;
AudioPlayer globalplayer = AudioPlayer();
String playingnow = "false";
String playingprev = "false";
bool globalchange = false;


class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  late AudioPlayer player;
  late bool isPlaying;
  late bool started;
  late List<AudioItem> audioItems;

  @override
  void initState() {
    super.initState();

    player = globalplayer;
    isPlaying = globalisPlaying;
    started = globalstarted;

    audioItems = [
      AudioItem(
        player: player,
        assettoplay: 'audio/Music_is_Love.mp3',
        onPressed: () {
          playingnow = "Music_is_Love";
          onpressed();
        },
      ),
      AudioItem(
        player:player,
        assettoplay: 'audio/Inception.mp3',
        onPressed: (){
          playingnow = "Inception";
          onpressed();
        }
        ),
    ];
    //globalwidgets = audioItems;

    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        // Song has completed, restart it
        setState(() {
          isPlaying = false;
          globalisPlaying = false;
        });
        player.seek(Duration.zero);
      }
    });
  }

  void onpressed() {
    if (!started) {
      started = true;
      globalstarted = true;
      isPlaying = false;
      globalisPlaying = false;
      playingprev = playingnow;
      player.play(AssetSource('audio/${playingnow}.mp3'));
    } else if(playingprev!=playingnow){
      globalchange = true;
      print("stopping one start other");
      player.pause();
      player.stop();
      player.play(AssetSource('audio/${playingnow}.mp3'));
      playingprev = playingnow;
      isPlaying = !isPlaying;
    }
    else {
      if (isPlaying) {
        print("pausing");
        player.pause();
      } else {
        print("resuming");
        player.resume();
      }
    }
    setState(() {
      isPlaying = !isPlaying;
      globalisPlaying = !globalisPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("daboudai"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/MusicPage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            width: 350,
            padding: EdgeInsets.all(8.0),  // Adjust padding as needed
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 226, 106, 178),  // Set container color to purple
              borderRadius: BorderRadius.circular(8.0),  // Optional: Add rounded corners
            ),
            child: Text(
              "Playing now :"+playingnow,
              style: TextStyle(
                color: Color.fromARGB(255, 62, 17, 110),        // Set text color to pink
                fontSize: 24,              // Set font size to 24
                fontWeight: FontWeight.bold,  // Make the text bold
              ),
            ),
          ),
        ),

          ListView.builder(
            itemCount: 1 + audioItems.length,
            padding: EdgeInsets.only(top: 200.0),
            itemExtent: 60.0,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox.shrink();
              }
              return audioItems[index - 1];
            },
          ),
        ],
      ),
    );
  }
}

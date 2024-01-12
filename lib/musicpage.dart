import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'widgets/audio_list.dart';
import 'widgets/custom_appbar.dart';

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
  //late AudioPlayer player;
  late bool isPlaying;
  late bool started;
  late List<AudioItem> audioItems;

  Future<void> asyncfuncforaudio() async {
    // Pause the player and wait for it to complete
    await globalplayer.pause();

    // Stop the player and wait for it to complete
    await globalplayer.stop();

    // Play the new audio file and wait for it to complete
    await globalplayer.play(AssetSource('audio/$playingnow.mp3'));

    // Other code in your function
  }

  @override
  void initState() {
    super.initState();

    //player = globalplayer;
    isPlaying = globalisPlaying;
    started = globalstarted;

    audioItems = [
      AudioItem(
        player: globalplayer,
        assettoplay: 'audio/Music_is_Love.mp3',
        onPressed: () {
          playingnow = "Music_is_Love";
          onpressed();
        },
      ),
      AudioItem(
          player: globalplayer,
          assettoplay: 'audio/Inception.mp3',
          onPressed: () {
            playingnow = "Inception";
            onpressed();
          }),
    ];
    //globalwidgets = audioItems;

    globalplayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        // Song has completed, restart it
        globalplayer.stop();
        setState(() {
          isPlaying = false;
          globalisPlaying = false;
          started = false;
          globalstarted = false;
        });
        globalplayer.seek(Duration.zero);
      }
    });
  }

  void onpressed() {
    bool continuewith = false;
    if (!started) {
      started = true;
      globalstarted = true;
      playingprev = playingnow;
      globalplayer.play(AssetSource('audio/${playingnow}.mp3'));
    } else if (playingprev != playingnow) {
      continuewith = true;
      globalchange = true;
      print("stopping one start other");
      asyncfuncforaudio();
      playingprev = playingnow;

    } else {
      print("wtf");
      if (isPlaying) {
        print("pausing");
        globalplayer.pause();
      } else {
        print("resuming");
        globalplayer.resume();
      }
    }
    if(!continuewith){
      setState(() {
        isPlaying = !isPlaying;
        globalisPlaying = !globalisPlaying;
      });
    }else{
      setState(() {
        isPlaying = true;
        globalisPlaying = true;
      });
    }
  }

  void onButtonClick() {
    if (isPlaying) {
      print("pausing");
      globalplayer.pause();
      //player.pause();
    } else {
      print("resuming");
      //player.resume();
      globalplayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
      globalisPlaying = !globalisPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("daboudai"),
      // ),
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
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Container(
              width: 350,
              padding: EdgeInsets.all(8.0), // Adjust padding as needed
              decoration: BoxDecoration(
                color: Color.fromARGB(
                    255, 129, 16, 235), // Set container color to purple
                borderRadius:
                    BorderRadius.circular(8.0), // Optional: Add rounded corners
              ),
              child: Text(
                "Playing now :" + playingnow,
                style: TextStyle(
                  color: Color.fromARGB(
                      255, 236, 178, 18), // Set text color to pink
                  fontSize: 24, // Set font size to 24
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            left: MediaQuery.of(context).size.width * 0.39,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      print("pausing");
                      //player.pause();
                      globalplayer.pause();
                    } else {
                      print("resuming");
                      //player.resume();
                      globalplayer.resume();
                    }

                    isPlaying = !isPlaying;
                    globalisPlaying = !globalisPlaying;
                  });
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 154, 25, 177))),
                child: Center(
                    child: isPlaying
                        ? const Center(
                            child: Icon(
                              Icons.pause,
                              size: 50,
                              color: Color.fromARGB(255, 90, 255, 205),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: Color.fromARGB(255, 90, 255, 205),
                            ),
                          ))),
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomAppBar(
              showSettings: false,
              showProfile: false,
              showInfo: false,
              infoCallback: null,
            ),
          ),
        ],
      ),
    );
  }
}

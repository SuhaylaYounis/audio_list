import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song Album',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SongList(),
    );
  }
}

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  late AssetsAudioPlayer audioPlayer;
  late List<Song> songs;

  @override
  void initState() {
    super.initState();
    audioPlayer = AssetsAudioPlayer();
    songs = [
      Song(name: 'Song 1', assetPath: 'assets/audios/file_example_MP3_700KB.mp3'),
      Song(name: 'Song 2', assetPath: 'assets/audios/sample-3s.mp3'),
      Song(name: 'Song 2', assetPath: 'assets/audios/sample-6s.mp3'),
      Song(name: 'Song 2', assetPath: 'assets/audios/sample-9s.mp3'),
      Song(name: 'Song 2', assetPath: 'assets/audios/sample-12s.mp3'),


      // Add more songs as needed
    ];
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Album'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Card(
            child: ListTile(
              title: Text(song.name),
              trailing: IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  playSong(song.assetPath);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void playSong(String assetPath) async {
    if (audioPlayer.isPlaying.value) {
      audioPlayer.stop();
    } else {
      audioPlayer.open(
        Audio('assets/$assetPath'),
        showNotification: true,
      );
    }
  }
}

class Song {
  final String name;
  final String assetPath;

  Song({required this.name, required this.assetPath});
}

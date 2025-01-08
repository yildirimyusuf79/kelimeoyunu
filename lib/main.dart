import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kelime Tahmin Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.teal.shade100,
      ),
      home: UsernameInputScreen(),
    );
  }
}

class UsernameInputScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Adı"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hoşgeldiniz",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Kullanıcı adınızı girin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.teal),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (usernameController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainMenuScreen(
                          username: usernameController.text,
                          highScores: [],
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Lütfen kullanıcı adınızı girin!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text("Devam Et"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  final String username;
  final List<int> highScores;

  MainMenuScreen({required this.username, required this.highScores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Menü"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hoşgeldin, $username!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSelectionScreen(
                      username: username,
                      highScores: highScores,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.play_arrow),
              label: Text("Oyna"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScoreboardScreen(
                      highScores: highScores,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.leaderboard),
              label: Text("Skor Tablosu"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreboardScreen extends StatelessWidget {
  final List<int> highScores;

  ScoreboardScreen({required this.highScores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skor Tablosu"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "En Yüksek Skorlar",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 20),
            ...highScores.map((score) => Text(
              "$score",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
            if (highScores.isEmpty)
              Text(
                "Henüz skor yok!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  final String username;
  final List<int> highScores;

  LanguageSelectionScreen({required this.username, required this.highScores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dil Seçimi"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModeSelectionScreen(
                      language: "Türkçe",
                      username: username,
                      highScores: highScores,
                    ),
                  ),
                );
              },
              child: Text("Türkçe"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModeSelectionScreen(
                      language: "English",
                      username: username,
                      highScores: highScores,
                    ),
                  ),
                );
              },
              child: Text("English"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ModeSelectionScreen extends StatelessWidget {
  final String language;
  final String username;
  final List<int> highScores;

  ModeSelectionScreen({
    required this.language,
    required this.username,
    required this.highScores,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Oyun Modu"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      language: language,
                      mode: "Kolay",
                      highScores: highScores,
                    ),
                  ),
                );
              },
              child: Text("Kolay"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      language: language,
                      mode: "Zor",
                      highScores: highScores,
                    ),
                  ),
                );
              },
              child: Text("Zor"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final String language;
  final String mode;
  final List<int> highScores;

  GameScreen({
    required this.language,
    required this.mode,
    required this.highScores,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> words;
  late String currentWord;
  late Set<int> revealedIndices;
  final TextEditingController guessController = TextEditingController();
  int attempts = 3;
  int score = 100;
  String message = "";

  @override
  void initState() {
    super.initState();
    words = _getWordsByMode(widget.language, widget.mode);
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      currentWord = words[Random().nextInt(words.length)];
      revealedIndices = {};
      attempts = 3;
      message = "";
    });
  }

  List<String> _getWordsByMode(String language, String mode) {
    if (language == "Türkçe") {
      return mode == "Kolay"
          ? ["elma", "kedi", "masa"]
          : ["yıldırım", "kelebek", "çiftçi"];
    } else {
      return mode == "Easy"
          ? ["apple", "cat", "table"]
          : ["lightning", "butterfly", "farmer"];
    }
  }

  void _checkGuess(String guess) {
    if (guess.toLowerCase() == currentWord.toLowerCase()) {
      setState(() {
        score += 20;
        message = widget.language == "Türkçe"
            ? "Tebrikler! Doğru tahmin."
            : "Congratulations! Correct guess.";
        _resetGame();
      });
    } else {
      setState(() {
        attempts--;
        if (attempts > 0) {
          message = widget.language == "Türkçe"
              ? "Yanlış tahmin! Kalan hak: $attempts"
              : "Wrong guess! Attempts left: $attempts";
        } else {
          _endGame();
        }
      });
    }
  }

  void _useHint() {
    if (revealedIndices.length < currentWord.length) {
      setState(() {
        score -= 5;
        int index;
        do {
          index = Random().nextInt(currentWord.length);
        } while (revealedIndices.contains(index));
        revealedIndices.add(index);

        message = widget.language == "Türkçe"
            ? "İpucu alındı! Skor: $score"
            : "Hint used! Score: $score";
      });
    } else {
      message = widget.language == "Türkçe"
          ? "Tüm harfler zaten görünüyor!"
          : "All letters are already revealed!";
    }
  }

  void _endGame() {
    setState(() {
      message = widget.language == "Türkçe"
          ? "Oyun bitti! Kelime: $currentWord"
          : "Game over! Word: $currentWord";
      widget.highScores.add(score);
      widget.highScores.sort((a, b) => b.compareTo(a));
      if (widget.highScores.length > 5) {
        widget.highScores.removeLast();
      }
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.language == "Türkçe" ? "Oyun Bitti" : "Game Over"),
        content: Text(widget.language == "Türkçe"
            ? "Doğru cevap: $currentWord"
            : "Correct word: $currentWord"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(widget.language == "Türkçe" ? "Çıkış" : "Exit"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            child: Text(widget.language == "Türkçe" ? "Yeniden Oyna" : "Play Again"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayedWord = currentWord.split('').asMap().entries.map((entry) {
      return revealedIndices.contains(entry.key) ? entry.value : '_';
    }).join(' ');

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.language} - ${widget.mode}"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.language == "Türkçe"
                  ? "Kelime: $displayedWord"
                  : "Word: $displayedWord",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: guessController,
              decoration: InputDecoration(
                labelText: widget.language == "Türkçe" ? "Tahmininizi girin" : "Enter your guess",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (guessController.text.isNotEmpty) {
                  _checkGuess(guessController.text);
                  guessController.clear();
                }
              },
              child: Text(widget.language == "Türkçe" ? "Tahmin Et" : "Guess"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _useHint,
              child: Text(widget.language == "Türkçe" ? "İpucu Al" : "Use Hint"),
            ),
            SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

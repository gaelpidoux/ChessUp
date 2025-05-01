import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

class StockfishService {
  Process? _process;
  late StreamSubscription<String> _subscription;
  final StreamController<String> _outputController = StreamController<String>();

  Future<void> start() async {
    // Obtient le répertoire des documents de l'application
    final directory = await getApplicationDocumentsDirectory();
    final stockfishPath = directory.path + '/stockfish';

    // Copie de l'exécutable stockfish à partir des assets vers le répertoire
    final byteData = await rootBundle.load('assets/stockfish/stockfish-android-armv8');
    final file = File(stockfishPath);
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Lancer le processus Stockfish
    _process = await Process.start(stockfishPath, []);
    _subscription = _process!.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((event) {
      _outputController.add(event);
    });

    sendCommand('uci');
  }

  void sendCommand(String command) {
    _process?.stdin.writeln(command);
  }

  Stream<String> get outputStream => _outputController.stream;

  Future<String> getBestMove(String fen) async {
    sendCommand('position fen $fen');
    sendCommand('go depth 15');

    // Attendre que la sortie contienne "bestmove"
    await for (var output in outputStream) {
      if (output.startsWith('bestmove')) {
        return output.split(' ')[1]; // Extrait le meilleur coup
      }
    }
    throw Exception('No move found');
  }

  void stop() {
    _subscription.cancel();
    _process?.kill();
    _outputController.close();
  }
}

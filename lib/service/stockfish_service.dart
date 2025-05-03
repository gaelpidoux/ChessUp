
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class StockfishService {
  Process? _process;
  late IOSink _inputSink;
  final _outputController = StreamController<String>.broadcast();

  Future<void> start() async {
    final dir = await getApplicationDocumentsDirectory();
    final stockfishPath = '${dir.path}/stockfish';

    final file = File(stockfishPath);
    if (!await file.exists()) {
      final byteData = await rootBundle.load('assets/stockfish/stockfish-android-armv8');
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

    try {
      await Process.run('chmod', ['755', stockfishPath]);
    } catch (_) {
      // Ignore failure
    }

    _process = await Process.start(stockfishPath, []);
    _inputSink = _process!.stdin;

    _process!.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(_outputController.add);
  }

  Future<String?> getBestMove(String fen) async {
    if (_process == null) return null;

    _inputSink.writeln('position fen $fen');
    _inputSink.writeln('go depth 12');

    try {
      await for (final line in _outputController.stream.timeout(const Duration(seconds: 5))) {
        if (line.startsWith('bestmove')) {
          return line.split(' ')[1];
        }
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  void stop() {
    _inputSink.writeln('quit');
    _process?.kill();
  }
}

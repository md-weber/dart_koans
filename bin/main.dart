import 'package:io/io.dart';
import 'package:path/path.dart' as path;
import 'package:watcher/watcher.dart';

main(List<String> arguments) async {
  var watcher = DirectoryWatcher(path.relative("lib"));

  final manager = ProcessManager();
  await manager.spawn(
    "dart",
    [
      "--enable-asserts",
      path.absolute(path.relative("./bin/dart_koans_runner.dart"))
    ],
  );

  print("Debug: Watcher is watching!");
  watcher.events.listen((event) async {
    final manager = ProcessManager();

    try {
      print("test");
      await manager.spawn(
        "dart",
        [
          "--enable-asserts",
          path.absolute(path.relative("./bin/dart_koans_runner.dart"))
        ],
      );
    } catch (e) {
      print(e);
    }
  });
}

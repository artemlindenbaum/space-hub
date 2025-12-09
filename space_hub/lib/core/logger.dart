import 'package:l/l.dart';

String? $customFormatter(LogMessage log) {
  final prefix = log.level.when(
    v: () => '✅',
    vv: () => '🔄',
    vvv: () => '🏹',
    vvvv: () => '4️⃣',
    vvvvv: () => '5️⃣',
    vvvvvv: () => '🛜',
    info: () => 'ℹ️',
    debug: () => '⚒️',
    shout: () => '🎤',
    error: () => '❌',
    warning: () => '⚠️',
  );

  return '[$prefix]'
      ' ${_timeFormat(log.timestamp)}'
      ' | ${log.message}';
}

String? _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}';

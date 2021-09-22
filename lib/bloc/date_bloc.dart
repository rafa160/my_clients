import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class DateBloc extends BlocBase {

  DateBloc() {
    getActualDayStream();
    getCurrentMonth();
  }

  DateTime _now = DateTime.now();
  DateTime get now => _now;
  set now(value) {
    _now = value;
  }

  final _streamActualDay = BehaviorSubject<String>();
  Stream<String> get streamActualDay => _streamActualDay.stream;
  Sink<String> get sinkActualDay => _streamActualDay.sink;

  final _streamActualMonth = BehaviorSubject<String>();
  Stream<String> get streamActualMonth => _streamActualMonth.stream;
  Sink<String> get sinkActualMonth => _streamActualMonth.sink;

  void getCurrentMonth() {
    String month = DateFormat('MMMM').format(now);
    _streamActualMonth.sink.add(month);
  }

  void getActualDayStream() {
    String formattedDate = DateFormat('dd/MM/yyyy').format(_now);
    _streamActualDay.sink.add(formattedDate);
  }

  @override
  void dispose() {
    _streamActualMonth.close();
    _streamActualDay.close();
    super.dispose();
  }

}
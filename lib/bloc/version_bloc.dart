import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class VersionBloc extends BlocBase {

  VersionBloc() {
    versionApp();
  }

  final _version$ = BehaviorSubject<String>.seeded("0.0.0");
  Stream<String> get streamVersion$ => _version$.stream;
  Sink get sinkVersion => _version$.sink;

  Future<void> versionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.version);
    sinkVersion.add('${packageInfo.version}');
  }

  @override
  void dispose() {
    super.dispose();
    _version$.close();
  }
}
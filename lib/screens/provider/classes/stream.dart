
class StreamProv{

  Stream<int> get streamValues async* {
    var i = 0;
    while (i < 85) {
      await Future.delayed(Duration(seconds: 1), () {
        i++;
      });
      yield i;
    }
  }

}
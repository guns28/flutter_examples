
class FutureProv{

  Future<String> getFutureValue() async{
    final val = await Future.delayed(Duration(seconds: 4), () {
      return "1232345";
    });

    return val;
  }

}
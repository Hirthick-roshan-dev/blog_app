

class ServerException implements Exception{


  final String message;
  final int? statusCode;

  ServerException({required this.message,this.statusCode});

  @override
  String toString() {

    if(statusCode != null){
      return "Server Exception $statusCode - $message";
    }



    return "Server Exception - $message";
    }


  }


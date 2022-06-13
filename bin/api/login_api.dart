import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi {
  Handler get handler {
    final Router router = Router();
    router.post('/api/v1/login', (Request req) {
      return Response.ok('Login API');
    });

    return router;
  }
}

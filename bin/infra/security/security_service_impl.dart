import 'package:shelf/shelf.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityServiceImpl implements SecurityService<JWT> {
  @override
  Future<String> generateJWT({required String userId}) async {
    var jwt = JWT(
      {
        "iat": DateTime.now().millisecondsSinceEpoch,
        "userId": userId,
        "roles": ['admin', 'user']
      },
    );
    final String key = await CustomEnv.get(key: 'jwt_key');
    final String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT({required String token}) async {
    final String key = await CustomEnv.get(key: 'jwt_key');
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        final String? authorizationHeader = req.headers["Authorization"];
        JWT? jwt;
        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith("Bearer ")) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token: token);
          }
        }
        var request = req.change(
          context: {
            'jwt': jwt,
          },
        );
        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJwt => createMiddleware(
        requestHandler: (Request req) {
          if (req.context["jwt"] == null) {
            return Response.forbidden("Unauthorized");
          }
          return null;
        },
      );
}

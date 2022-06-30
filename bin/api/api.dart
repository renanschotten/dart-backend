import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurityRequired = false,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurityRequired = false,
  }) {
    middlewares ??= [];
    var securityService = DependencyInjector().get<SecurityService>();
    if (isSecurityRequired) {
      middlewares.addAll([
        securityService.authorization,
        securityService.verifyJwt,
      ]);
    }
    var pipeline = Pipeline();
    for (var middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }

    return pipeline.addHandler(router);
  }
}

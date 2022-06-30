import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

Future<void> main(List<String> args) async {
  final di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(di.get<LoginApi>().getHandler())
      .add(di.get<BlogApi>().getHandler(isSecurityRequired: true))
      .handler;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  final String address = await CustomEnv.get<String>(key: 'server_address');
  final int port = await CustomEnv.get<int>(key: 'server_port');

  await CustomServer().initialize(
    handler: handler,
    address: address,
    port: port,
  );
}

import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

Future<void> main(List<String> args) async {
  final LoginApi loginApi = LoginApi();
  final BlogApi blogApi = BlogApi(NoticiaService());

  var cascateHandler =
      Cascade().add(loginApi.handler).add(blogApi.handler).handler;

  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascateHandler);

  final String address = await CustomEnv.get<String>(key: 'server_address');
  final int port = await CustomEnv.get<int>(key: 'server_port');

  await CustomServer().initialize(
    handler: handler,
    address: address,
    port: port,
  );
}

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/noticia_model.dart';
import '../services/generic_service.dart';

class BlogApi {
  final GenericService<NoticiaModel> _noticiaService;

  BlogApi(
    this._noticiaService,
  );
  Handler get handler {
    final Router router = Router();

    //Listagem
    router.get(
      '/api/v1/blog/noticias',
      (Request req) {
        List<NoticiaModel> noticias = _noticiaService.findAll();
        List<Map> noticiasMap = [];
        for (var element in noticias) {
          noticiasMap.add(element.toMap());
        }
        String jsonString = jsonEncode(noticiasMap);
        return Response.ok(jsonString);
      },
    );

    //Nova notícia
    router.post(
      '/api/v1/blog/noticias',
      (Request req) async {
        var body = await req.readAsString();

        _noticiaService.save(NoticiaModel.fromJson(body));
        return Response(
          201,
        );
      },
    );

    //Atualização
    router.put(
      '/api/v1/blog/noticias',
      (Request req) {
        String? id = req.url.queryParameters['id'];

        // _noticiaService.save('');
        return Response.ok('Atualizado');
      },
    );

    //Exclusão
    router.delete(
      '/api/v1/blog/noticias',
      (Request req) {
        String? id = req.url.queryParameters['id'];
        _noticiaService.delete(1);
        return Response.ok('Deletado');
      },
    );

    return router;
  }
}

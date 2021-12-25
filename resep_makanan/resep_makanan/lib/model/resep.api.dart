import 'dart:convert';
import 'dart:html';
import 'package:resep_makanan/model/resep.dart';
import 'package:http/http.dart' as http;

class ResepApi {
  //  var req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

//  req.query({
// 	"limit": "18",
// 	"start": "0",
// 	"tag": "list.recipe.popular"
// });

// req.headers({
// 	"x-rapidapi-host": "yummly2.p.rapidapi.com",
// 	"x-rapidapi-key": "7f6a6c196emsh1ae84ec86be4607p11d91cjsnf19603e85636",
// 	"useQueryString": true
// });

  static Future<List<Resep>> getResep() async {
    var url = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "0", "size": "20", "tags": "under_30_minutes"});

    final response = await http.get(url, headers: {
      "x-rapidapi-host": "tasty.p.rapidapi.com",
      "x-rapidapi-key": "7f6a6c196emsh1ae84ec86be4607p11d91cjsnf19603e85636",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);

    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }
    return Resep.resepFromSnapshot(_temp);
  }
}

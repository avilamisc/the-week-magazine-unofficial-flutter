import "dart:async";
import "dart:convert";

import "package:http/http.dart";
import "package:flutter/services.dart";
import "package:xml2json/xml2json.dart";

// TODO: Switch methods to use async keyword.
class TheWeekAPI {

    // TODO: Move to config file.
    // static String _url = "https://magazine.theweek.com/endpoint.xml";
    static const String _url = "https://home.justin-credible.net/private/the-week/endpoint.xml";

    static Future<Map> retrieveIssueFeed() {

        var completer = new Completer<Map>();

        var client = createHttpClient();

        client.get(TheWeekAPI._url)
            .then((Response response) {

            var xml2json = new Xml2Json();
            xml2json.parse(response.body);

            var json = xml2json.toParker();

            var wrapper = JSON.decode(json);

            completer.complete(wrapper["feed"]);

        }).catchError((Object error) {

            completer.completeError(error);
        });

        return completer.future;
    }
}

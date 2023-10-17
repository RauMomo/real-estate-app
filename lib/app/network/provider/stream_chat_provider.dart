import 'package:real_estate_app/app/network/provider/db_provider.dart';
import 'package:real_estate_app/core/dependency_injection.dart';
import 'package:real_estate_app/shared/util/conversion.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamChatProvider {
  late StreamChatClient client;

  StreamChatProvider({required this.client});

  Future<void> init() async {
    var displayName = parseUsername(sl.get<DBProvider>().user?.email);
    await client
        .connectUser(User(id: 'raumomo'), client.devToken('raumomo').rawValue)
        .then((value) => print(
              'apa hasilnya:$value',
            ));
  }
}

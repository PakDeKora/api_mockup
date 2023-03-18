import 'package:coin_gecko/app/config/api_config.dart';
import 'package:coin_gecko/app/models/coin_list_response.dart';

class HomeService {
   Future<dynamic> coinList() async {
    return await ApiService().dataRequest<CoinListResponse>(
      isArray: true,
      method: 'GET',
      url: '/markets?vs_currency=usd&order=market_cap_desc&sparkline=false',
      header: NetworkConfiguration().dioWithoutAuth(),
    );
  }

  Future<dynamic> detailCoin({required id}) async {
    return await ApiService().dataRequest<CoinListResponse>(
      method: 'GET',
      url: '/$id',
      header: NetworkConfiguration().dioWithoutAuth(),
    );
  }
}

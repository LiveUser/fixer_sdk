library fixer_sdk;

import 'package:sexy_api_client/sexy_api_client.dart';
import 'dart:convert';

const String _baseURL = "https://api.apilayer.com";

class CurrencyRate{
  CurrencyRate({
    required this.currencyCode,
    required this.rate,
  });
  final String currencyCode;
  final double rate;
}
class Currency{
  Currency({
    required this.amount,
    required this.currencyCode,
  });
  final String currencyCode;
  final double amount;
}
class ExchangeRates{
  ExchangeRates({
    required this.baseCurrency,
    required this.currencies,
    required this.date,
  });
  final String baseCurrency;
  final List<CurrencyRate> currencies;
  final DateTime date;
}
class FixerSDK{
  FixerSDK({
    required this.apikey,
  });
  final String apikey;
  Future<ExchangeRates> getLatestRates({
    baseCurrency = "USD",
  })async{
    String response = await SexyAPI(
      url: _baseURL,
      path: "/fixer/latest",
      parameters: {
        "base" : baseCurrency,
      }
    ).get(
      headers: {
        "apikey": apikey,
      },
    );
    //Parse response
    Map<String,dynamic> parsedResponse = jsonDecode(response);
    List<CurrencyRate> rates = [];
    Map<String,dynamic> onlineRates = parsedResponse["rates"];
    for(String currencyCode in onlineRates.keys){
      rates.add(CurrencyRate(
          currencyCode: currencyCode, 
          rate: (onlineRates[currencyCode] as num).toDouble(),
        ),
      );
    }
    List<String> splitDate = (parsedResponse["date"] as String).split("-");
    DateTime date = DateTime(int.parse(splitDate[0]),int.parse(splitDate[1]),int.parse(splitDate[2]));
    return ExchangeRates(
      baseCurrency: baseCurrency, 
      currencies: rates,
      date: date,
    );
  }
  //Convert currency using response exchange rates as argument
  static Currency equivalentIn({
    required Currency fromCurrency,
    required String toCurrency,
    required ExchangeRates rates,
  }){
    double resultingAmount = fromCurrency.amount;
    //Convert from to base currency
    resultingAmount /= rates.currencies[rates.currencies.indexWhere((currency) => currency.currencyCode == rates.baseCurrency)].rate;
    //Convert the equivalent in base currency to toCurrency
    resultingAmount *= rates.currencies[rates.currencies.indexWhere((currency) => currency.currencyCode == toCurrency)].rate;
    return Currency(
      currencyCode: toCurrency, 
      amount: resultingAmount,
    );
  }
}
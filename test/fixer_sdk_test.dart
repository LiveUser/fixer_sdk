import 'package:fixer_sdk/fixer_sdk.dart';
import 'package:test/test.dart';
//TODO: Delete API key before publishing
const String apikey = "";

void main() {
  test("Get exchange rates", ()async{
    ExchangeRates rates = await FixerSDK(
      apikey: apikey,
    ).getLatestRates();
    print(rates.date.year);
    print("Base Currency: ${rates.baseCurrency}");
    for(CurrencyRate currency in rates.currencies){
      print("${currency.currencyCode}: ${currency.rate}");
    }
  });
  test("Convert USD to CAD", ()async{
    ExchangeRates rates = await FixerSDK(
      apikey: apikey,
    ).getLatestRates();
    Currency converted = FixerSDK.equivalentIn(
      fromCurrency: Currency(
        amount: 15, 
        currencyCode: "USD",
      ), 
      toCurrency: "CAD", 
      rates: rates,
    );
    print("15 USD = ${converted.amount} CAD");
  });
}
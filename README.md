# Fixer Unofficial SDK
Get currency rates and convert currencies<br>
Hecho en 🇵🇷 por Radamés J. Valentín Reyes
# Get API key
Subscribe and get an API key from [here](https://apilayer.com/marketplace/fixer-api#details-tab)
# Import
~~~dart
import 'package:fixer_sdk/fixer_sdk.dart';
~~~
# Examples
## Get latest rates
~~~dart
ExchangeRates rates = await FixerSDK(
      apikey: apikey,
).getLatestRates();
~~~
## Convert currencies
~~~dart
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
~~~
# References
- https://apilayer.com/marketplace/fixer-api#documentation-tab

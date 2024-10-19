import 'dart:convert';
import 'package:financial_app/data/keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/simple_button.dart';

class MoneyConveror extends StatefulWidget {
  const MoneyConveror({super.key});

  @override
  State<MoneyConveror> createState() => _MoneyConverorState();
}

class _MoneyConverorState extends State<MoneyConveror> {
  String? fromCurrency = 'USD';
  String? toCurrency = 'SGD';
  TextEditingController amountController = TextEditingController();
  double convertedAmount = 0.0;

  List<String> currencies = [
    'USD', // United States Dollar
    'SGD', // Singapore Dollar
    'EUR', // Euro
    'JPY', // Japanese Yen
    'GBP', // British Pound Sterling
    'AUD', // Australian Dollar
    'LKR', // Sri Lankan Rupee
    'CAD', // Canadian Dollar
    'CHF', // Swiss Franc
    'CNY', // Chinese Yuan
    'INR', // Indian Rupee
    'NZD', // New Zealand Dollar
    'MXN', // Mexican Peso
    'HKD', // Hong Kong Dollar
    'SEK', // Swedish Krona
    'NOK', // Norwegian Krone
    'RUB', // Russian Ruble
    'ZAR', // South African Rand
    'BRL', // Brazilian Real
    'IDR', // Indonesian Rupiah
    'MYR', // Malaysian Ringgit
    'PHP', // Philippine Peso
    'THB', // Thai Baht
    'VND', // Vietnamese Dong
    'DKK', // Danish Krone
    'PLN', // Polish Zloty
    'HUF', // Hungarian Forint
    'CZK', // Czech Koruna
    'ILS', // Israeli New Shekel
    'AED', // United Arab Emirates Dirham
    'SAR', // Saudi Riyal
    'TRY', // Turkish Lira
    'PKR', // Pakistani Rupee
    'NGN', // Nigerian Naira
    'KES', // Kenyan Shilling
    'CLP', // Chilean Peso
    'COP', // Colombian Peso
    'PEN', // Peruvian Sol
    'MAD', // Moroccan Dirham
    'DOP', // Dominican Peso
    'GTQ', // Guatemalan Quetzal
    'PAB', // Panamanian Balboa
  ];

  String exchangeRateMessage = '';

  Map<String, String> currencyFlags = {
    'USD': 'https://flagcdn.com/us.svg', // United States Dollar
    'SGD': 'https://flagcdn.com/sg.svg', // Singapore Dollar
    'EUR': 'https://flagcdn.com/eu.svg', // Euro
    'JPY': 'https://flagcdn.com/jp.svg', // Japanese Yen
    'GBP': 'https://flagcdn.com/gb.svg', // British Pound Sterling
    'AUD': 'https://flagcdn.com/au.svg', // Australian Dollar
    'LKR': 'https://flagcdn.com/lk.svg', // Sri Lankan Rupee
    'CAD': 'https://flagcdn.com/ca.svg', // Canadian Dollar
    'CHF': 'https://flagcdn.com/ch.svg', // Swiss Franc
    'CNY': 'https://flagcdn.com/cn.svg', // Chinese Yuan
    'INR': 'https://flagcdn.com/in.svg', // Indian Rupee
    'NZD': 'https://flagcdn.com/nz.svg', // New Zealand Dollar
    'MXN': 'https://flagcdn.com/mx.svg', // Mexican Peso
    'HKD': 'https://flagcdn.com/hk.svg', // Hong Kong Dollar
    'SEK': 'https://flagcdn.com/se.svg', // Swedish Krona
    'NOK': 'https://flagcdn.com/no.svg', // Norwegian Krone
    'RUB': 'https://flagcdn.com/ru.svg', // Russian Ruble
    'ZAR': 'https://flagcdn.com/za.svg', // South African Rand
    'BRL': 'https://flagcdn.com/br.svg', // Brazilian Real
    'IDR': 'https://flagcdn.com/id.svg', // Indonesian Rupiah
    'MYR': 'https://flagcdn.com/my.svg', // Malaysian Ringgit
    'PHP': 'https://flagcdn.com/ph.svg', // Philippine Peso
    'THB': 'https://flagcdn.com/th.svg', // Thai Baht
    'VND': 'https://flagcdn.com/vn.svg', // Vietnamese Dong
    'DKK': 'https://flagcdn.com/dk.svg', // Danish Krone
    'PLN': 'https://flagcdn.com/pl.svg', // Polish Zloty
    'HUF': 'https://flagcdn.com/hu.svg', // Hungarian Forint
    'CZK': 'https://flagcdn.com/cz.svg', // Czech Koruna
    'ILS': 'https://flagcdn.com/il.svg', // Israeli New Shekel
    'AED': 'https://flagcdn.com/ae.svg', // United Arab Emirates Dirham
    'SAR': 'https://flagcdn.com/sa.svg', // Saudi Riyal
    'TRY': 'https://flagcdn.com/tr.svg', // Turkish Lira
    'PKR': 'https://flagcdn.com/pk.svg', // Pakistani Rupee
    'NGN': 'https://flagcdn.com/ng.svg', // Nigerian Naira
    'KES': 'https://flagcdn.com/ke.svg', // Kenyan Shilling
    'CLP': 'https://flagcdn.com/cl.svg', // Chilean Peso
    'COP': 'https://flagcdn.com/co.svg', // Colombian Peso
    'PEN': 'https://flagcdn.com/pe.svg', // Peruvian Sol
    'MAD': 'https://flagcdn.com/ma.svg', // Moroccan Dirham
    'DOP': 'https://flagcdn.com/do.svg', // Dominican Peso
    'GTQ': 'https://flagcdn.com/gt.svg', // Guatemalan Quetzal
    'PAB': 'https://flagcdn.com/pa.svg', // Panamanian Balboa
  };

  Future<void> convertCurrency() async {
    String from = fromCurrency!;
    String to = toCurrency!;
    double amount = double.parse(amountController.text);

    String url =
        'https://v6.exchangerate-api.com/v6/$CONVERTOR_API_KEY/pair/$from/$to/$amount';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          convertedAmount = data['conversion_result'];
          exchangeRateMessage = '1 $from = ${data['conversion_rate']} $to';
        });
      } else {
        throw Exception('Failed to load conversion rate');
      }
    } catch (e) {
      setState(() {
        exchangeRateMessage = 'Error fetching exchange rate';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Currency Converter',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Text(
              'Check live rates, set rate alerts, receive notifications and more.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.network(
                        currencyFlags[fromCurrency]!,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<String>(
                          value: fromCurrency,
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              fromCurrency = newValue;
                            });
                          },
                          items: currencies
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Amount',
                      labelStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFF456EFE), width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.swap_vert,
                        size: 32,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        setState(() {
                          String? temp = fromCurrency;
                          fromCurrency = toCurrency;
                          toCurrency = temp;
                        });
                        await convertCurrency();
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.network(
                        currencyFlags[toCurrency]!,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<String>(
                          value: toCurrency,
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              toCurrency = newValue;
                            });
                          },
                          items: currencies
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      convertedAmount.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              'Indicative Exchange Rate',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              exchangeRateMessage,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            SimpleButton(
              data: 'Convert',
              onPressed: () async {
                await convertCurrency();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton getAndroidDropDown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem =
      new DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          fetchData();
        });
      },
    );
  }

  CupertinoPicker getiosPicker(){

    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency=currenciesList[selectedIndex];
        fetchData();
      },
      children: pickerItems,
    );
  }

  String bitcoinValue='?';
  String ethValue='?';
  String ltcValue='?';

  void fetchData() async {
      Map<String,String> data=await CoinData().getData(selectedCurrency);
      setState(() {
        bitcoinValue=data['BTC'];
        ethValue=data['ETH'];
        ltcValue=data['LTC'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children : <Widget>[
              cryptoCard(value: bitcoinValue, selectedCurrency: selectedCurrency, cryptoCurrency : 'BTC'),
              cryptoCard(value: ethValue, selectedCurrency: selectedCurrency, cryptoCurrency : 'ETH'),
              cryptoCard(value: ltcValue, selectedCurrency: selectedCurrency, cryptoCurrency : 'LTC'),
          ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getiosPicker() : getAndroidDropDown(),
          ),
        ],
      ),
    );
  }
}

class cryptoCard extends StatelessWidget {
  const cryptoCard({
    Key key,
    @required this.value,
    @required this.selectedCurrency,
    @required this.cryptoCurrency,
  }) : super(key: key);

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

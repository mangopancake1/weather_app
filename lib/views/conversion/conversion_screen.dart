import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../appdata/app_colors.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Currency conversion
  final List<String> currencies = [
    'IDR',
    'USD',
    'EUR',
    'JPY',
    'GBP',
    'AUD',
    'SGD',
    'CNY'
  ];
  final Map<String, double> rates = {
    'IDR': 1.0,
    'USD': 0.000062,
    'EUR': 0.000058,
    'JPY': 0.0097,
    'GBP': 0.000049,
    'AUD': 0.000094,
    'SGD': 0.000083,
    'CNY': 0.00045,
  };
  String fromCurrency = 'IDR';
  String toCurrency = 'USD';
  double inputAmount = 0.0;
  double convertedAmount = 0.0;

  // Time conversion
  final List<Map<String, dynamic>> timezones = [
    {'label': 'WIB (Jakarta)', 'offset': 7},
    {'label': 'WITA (Makassar)', 'offset': 8},
    {'label': 'WIT (Jayapura)', 'offset': 9},
    {'label': 'London', 'offset': 0},
    {'label': 'New York', 'offset': -4},
    {'label': 'Tokyo', 'offset': 9},
    {'label': 'Sydney', 'offset': 10},
    {'label': 'Dubai', 'offset': 4},
    {'label': 'Paris', 'offset': 2},
    {'label': 'Beijing', 'offset': 8},
  ];
  int fromTimezoneOffset = 7;
  int toTimezoneOffset = 0;
  String fromTimezoneLabel = 'WIB (Jakarta)';
  String toTimezoneLabel = 'London';
  TimeOfDay selectedTime = TimeOfDay.now();
  String convertedTime = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void convertCurrency() {
    setState(() {
      convertedAmount =
          inputAmount * (rates[toCurrency]! / rates[fromCurrency]!);
    });
  }

  void convertTime() {
    final now = DateTime.now().toUtc();
    final base = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    final utcTime = base.subtract(Duration(hours: fromTimezoneOffset));
    final targetTime = utcTime.add(Duration(hours: toTimezoneOffset));
    convertedTime = DateFormat('HH:mm').format(targetTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text('Conversion',
            style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.secondaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.secondaryColor,
          tabs: const [
            Tab(text: 'Uang'),
            Tab(text: 'Waktu'),
          ],
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Currency Conversion Tab
          Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Currency Conversion',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                            fontSize: 18)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              inputAmount = double.tryParse(v) ?? 0.0;
                              convertCurrency();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: fromCurrency,
                          items: currencies
                              .map((c) =>
                                  DropdownMenuItem(value: c, child: Text(c)))
                              .toList(),
                          onChanged: (v) {
                            fromCurrency = v!;
                            convertCurrency();
                          },
                        ),
                        const Icon(Icons.arrow_forward,
                            color: AppColors.secondaryColor),
                        DropdownButton<String>(
                          value: toCurrency,
                          items: currencies
                              .map((c) =>
                                  DropdownMenuItem(value: c, child: Text(c)))
                              .toList(),
                          onChanged: (v) {
                            toCurrency = v!;
                            convertCurrency();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Result: $convertedAmount $toCurrency',
                        style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
          // Time Conversion Tab
          Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Time Zone Conversion',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                            fontSize: 18)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: fromTimezoneLabel,
                            isExpanded: true,
                            items: timezones
                                .map((t) => DropdownMenuItem<String>(
                                    value: t['label'] as String,
                                    child: Text(t['label'] as String)))
                                .toList(),
                            onChanged: (String? v) {
                              final tz =
                                  timezones.firstWhere((t) => t['label'] == v);
                              fromTimezoneLabel = tz['label'];
                              fromTimezoneOffset = tz['offset'];
                              convertTime();
                            },
                          ),
                        ),
                        const Icon(Icons.arrow_forward,
                            color: AppColors.secondaryColor),
                        Expanded(
                          child: DropdownButton<String>(
                            value: toTimezoneLabel,
                            isExpanded: true,
                            items: timezones
                                .map((t) => DropdownMenuItem<String>(
                                    value: t['label'] as String,
                                    child: Text(t['label'] as String)))
                                .toList(),
                            onChanged: (String? v) {
                              final tz =
                                  timezones.firstWhere((t) => t['label'] == v);
                              toTimezoneLabel = tz['label'];
                              toTimezoneOffset = tz['offset'];
                              convertTime();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Time: ${selectedTime.format(context)}',
                            style: const TextStyle(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w500)),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.complementaryColor,
                          ),
                          child: const Text('Pick Time'),
                          onPressed: () async {
                            final picked = await showTimePicker(
                                context: context, initialTime: selectedTime);
                            if (picked != null) {
                              selectedTime = picked;
                              convertTime();
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Converted Time: $convertedTime',
                        style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

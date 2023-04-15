import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final bookProvider = ChangeNotifierProvider((ref) {
  return BookingProvider();
});

class BookingProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _timings = [
    {
      'time': '10:00 - 11:00',
      'zone': 'AM',
      '24h': '11',
      'active': false,
      'selected': false
    },
    {
      'time': '11:00 - 12:00',
      'zone': 'AM',
      '24h': '12',
      'active': false,
      'selected': false
    },
    {
      'time': '12:00 - 01:00',
      'zone': 'PM',
      '24h': '13',
      'active': false,
      'selected': false
    },
    {
      'time': '01:00 - 02:00',
      'zone': 'PM',
      '24h': '14',
      'active': false,
      'selected': false
    },
    {
      'time': '02:00 - 03:00',
      'zone': 'PM',
      '24h': '15',
      'active': false,
      'selected': false
    },
    {
      'time': '03:00 - 04:00',
      'zone': 'PM',
      '24h': '16',
      'active': false,
      'selected': false
    },
    {
      'time': '04:00 - 05:00',
      'zone': 'PM',
      '24h': '17',
      'active': false,
      'selected': false
    },
    {
      'time': '05:00 - 06:00',
      'zone': 'PM',
      '24h': '18',
      'active': false,
      'selected': false
    },
    {
      'time': '06:00 - 07:00',
      'zone': 'PM',
      '24h': '19',
      'active': false,
      'selected': false
    }
  ];

  List<Map<String, dynamic>> get timings => _timings;

  List newFiltered = [];
  List filtered = [];

  getFiltered(DateTime dateTim) {
    filtered.clear();
    //DateTime now = DateTime.now();
    DateTime dateTime = DateTime.now();

    if (dateTime.compareTo(dateTim) < 0) {
      log("came here new day");
      for (var i = 0; i < _timings.length; i++) {
        _timings[i]['active'] = true;
        filtered.add(_timings[i]);
      }
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
    } else {
      log("came here same day");
      String formattedTime = DateFormat('HH:mm').format(dateTime);
      log(formattedTime);
      for (var i = 0; i < _timings.length; i++) {
        _timings[i]['active'] = false;
      }
      for (var i = 0; i < _timings.length; i++) {
        if (int.parse(_timings[i]['24h'].toString()) >
            int.parse(formattedTime.split(':').first)) {
          _timings[i]['active'] = true;
          filtered.add(_timings[i]);
        }
      }
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
      // log("Not other day");
    }

    log(filtered.toString());
  }

  selectSlot(int ii) {
    for (var i = 0; i < _timings.length; i++) {
      _timings[i]['selected'] = false;
    }
    _timings[ii]['selected'] = true;
    notifyListeners();
  }
}

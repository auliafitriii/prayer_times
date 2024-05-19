import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_prayer_times/notification.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;



class jadwal extends StatefulWidget {
  const jadwal({super.key});

  @override
  State<jadwal> createState() => _jadwalState();
}

class _jadwalState extends State<jadwal> with SingleTickerProviderStateMixin {

  String Shubuh = '';
  String Dzuhur = '';
  String Ashar = '';
  String Maghrib = '';
  String Isya = '';
  
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    getPrayerTimes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  
  void getPrayerTimes()async{
    // ignore: unused_local_variable
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    double latitude = position.latitude;
    double longtitude = position.longitude;
    print(latitude);
    print(longtitude);

    tz.initializeTimeZones();
    String tzs = tzmap.latLngToTimezoneString(latitude, longtitude);
    print(tzs);
    final location = tz.getLocation(tzs);

    DateTime date = tz.TZDateTime.from(DateTime.now(), location);
    Coordinates coordinates = Coordinates(latitude, longtitude);
    CalculationParameters params = CalculationMethod.Singapore();
    params.madhab = Madhab.Hanafi;
    PrayerTimes prayerTimes= PrayerTimes(coordinates, date, params);

    setState(() {
      if(mounted){
      Shubuh = DateFormat('HH:mm').format(tz.TZDateTime.from(prayerTimes.fajr!, location)).toString();
      Dzuhur = DateFormat('HH:mm').format(tz.TZDateTime.from(prayerTimes.dhuhr!, location)).toString();
      Ashar = DateFormat('HH:mm').format(tz.TZDateTime.from(prayerTimes.asr!, location)).toString();
      Maghrib = DateFormat('HH:mm').format(tz.TZDateTime.from(prayerTimes.maghrib!, location)).toString();
      Isya = DateFormat('HH:mm').format(tz.TZDateTime.from(prayerTimes.isha!, location)).toString();
  }
  });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        title: Text('Jadwal Shalat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shubuh',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
      
                Text(
                  Shubuh,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 1,
              color: Colors.black,
            ),

            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dzuhur',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
      
                Text(
                  Dzuhur,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 1,
              color: Colors.black,
            ),

             SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ashar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
      
                Text(
                  Ashar,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 1,
              color: Colors.black,
            ),

             SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Maghrib',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
      
                Text(
                  Maghrib,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 1,
              color: Colors.black,
            ),

             SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Isya',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
      
                Text(
                  Isya,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 1,
              color: Colors.black,
            ),

             SizedBox(height: 15,),

             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                onPressed: (){
                  notification.showNotification(title: 'Waktu Shalat', body:'Adzan', payload: 'Aplikasi Shalat');
                }, 
                child: Text('Waktu Shalat')),
              ],
             )
          ],
        ),
      ),
    );
  }
}
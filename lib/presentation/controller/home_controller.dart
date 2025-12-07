import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_events_2025/data/models/sources/remote_sourses.dart';
import '../../data/models/event_model.dart';


class HomeController extends GetxController {

  var eventList = <EventModel>[].obs;
  
  
  var isLoading = true.obs;


  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  @override
  void onInit() {
    super.onInit();
  
    fetchEvents(); 
  }


  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
    
      final data = await _remoteDataSource.getEvents();
      
      final List<EventModel> loadedEvents = [];
      for (var item in data) {
        loadedEvents.add(EventModel.fromJson(item));
      }

      eventList.assignAll(loadedEvents);
    } catch (e) {
      Get.snackbar("Error", "Events loading failed: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
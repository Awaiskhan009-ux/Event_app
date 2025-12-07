import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_events_2025/core/constant/app_colors.dart';
import 'package:my_events_2025/presentation/controller/home_controller.dart';
import 'package:my_events_2025/presentation/controller/auth_controller.dart';
import 'package:my_events_2025/presentation/pages/event_detail_page.dart'; 



import '../../core/utils/dimensions.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Upcoming Events", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Logout button: AuthController se call karein
              Get.find<AuthController>().logout(); 
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.white),
            onPressed: () {
              // Yahan Create Event page par jayenge
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Task requirement: Loading state (Skeleton Cards yahan lagenge)
          return const Center(child: CircularProgressIndicator()); 
        }

        if (controller.eventList.isEmpty) {
          return const Center(child: Text("No events found"));
        }
        
        return ListView.builder(
          padding: EdgeInsets.all(Dimensions.width10),
          itemCount: controller.eventList.length,
          itemBuilder: (context, index) {
            final event = controller.eventList[index]; 
            
            return GestureDetector( 
              onTap: () {
              
                Get.to(() => EventDetailPage(event: event));
              },
              child: Card( 
                margin: EdgeInsets.only(bottom: Dimensions.height15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Event Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radius15)),
                      child: CachedNetworkImage(
                        imageUrl: event.imageUrl,
                        height: Dimensions.height10 * 15, 
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          height: Dimensions.height10 * 15,
                          child: const Center(child: Icon(Icons.image)),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          height: Dimensions.height10 * 15,
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                    
                    
                    Padding(
                      padding: EdgeInsets.all(Dimensions.width15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10 / 2),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: Dimensions.font16, color: Colors.grey),
                              SizedBox(width: 5),
                              Text(
                                event.location,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const Spacer(),
                              Icon(Icons.calendar_today, size: Dimensions.font16, color: AppColors.primary),
                              SizedBox(width: 5),
                              Text(
                                event.date.toString().split(' ')[0],
                                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
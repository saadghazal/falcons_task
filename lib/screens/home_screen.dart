import 'package:falcons_task/controllers/items_controller.dart';
import 'package:falcons_task/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 120),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GetBuilder<ItemsController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        controller.refreshData();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.refresh,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<ItemsController>(
                  builder: (controller) {
                    return SearchField(
                      onSubmitted: (value) {
                        controller.search(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<ItemsController>(
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.refreshData();
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilterWidget(
                          onTap: () {
                            controller.filterDescending();
                          },
                          isSelected: controller.filter == SelectedFilter.descending,
                          label: "الاكثر كمية",
                        ),
                        FilterWidget(
                          onTap: () {
                            controller.filterAscending();
                          },
                          label: "الاقل كمية",
                          isSelected: controller.filter == SelectedFilter.ascending,
                        ),
                        FilterWidget(
                          onTap: () {
                            controller.clearFilter();
                          },
                          isSelected: controller.filter == SelectedFilter.all,
                          label: "الكل",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Builder(
                    builder: (context) {
                      if (controller.state == FetchStatus.loading) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (controller.state == FetchStatus.error) {
                        return Expanded(child: Center(child: Text(controller.errorMessage)));
                      } else {
                        return controller.showedItems.isEmpty
                            ? const Expanded(
                                child: Center(
                                child: Text("No Items Found!"),
                              ))
                            : Expanded(
                                child: ListView.separated(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    var item = controller.showedItems[index];
                                    return ListTile(
                                      leading: Text(
                                        'الكمية: ${item.quantity.ceil()}',
                                        style: TextStyle(
                                            color: item.quantity.ceil() < 5
                                                ? Colors.red
                                                : Colors.grey),
                                      ),
                                      trailing: Text(
                                        item.itemName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: controller.showedItems.length,
                                ),
                              );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

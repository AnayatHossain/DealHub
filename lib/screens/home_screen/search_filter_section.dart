import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/data.dart';
import '../../theme/theme.dart';


void showFilterBottomSheet(BuildContext context) {
  // Define state variables for the bottom sheet
  RangeValues _priceRange = const RangeValues(0, 1000);
  final List<String> _selectedBrands = [];
  final List<String> _selectedSizes = [];


  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Header section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Clear all filters
                            setState(() {
                              _priceRange = const RangeValues(0, 1000);
                              _selectedBrands.clear();
                              _selectedSizes.clear();
                            });
                          },
                          child: Text("Clear All"),
                        ),
                         Text(
                          "Filters",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child:  Text("Apply"),
                        ),
                      ],
                    ),
                  ),
                  // Scrollable content
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding:  EdgeInsets.all(16),
                      children: [
                        // Price Range Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "Price Range",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Replace with your theme color
                              ),
                            ),
                             SizedBox(height: 16),
                            RangeSlider(
                              values: _priceRange,
                              min: 0,
                              max: 1000,
                              divisions: 100,
                              labels: RangeLabels(
                                '\$${_priceRange.start.round()}',
                                '\$${_priceRange.end.round()}',
                              ),
                              activeColor: AppTheme.primaryColor, // Replace with your theme color
                              inactiveColor: AppTheme.primaryColor.withOpacity(0.2),
                              onChanged: (values) {
                                setState(() {
                                  _priceRange = values;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${_priceRange.start.round()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey, // Replace with your theme color
                                  ),
                                ),
                                Text(
                                  '\$${_priceRange.end.round()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey, // Replace with your theme color
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        // Brands Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Brands",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Replace with your theme color
                              ),
                            ),
                            SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: brands.map((brand) {
                                final isSelected = _selectedBrands.contains(brand);
                                return FilterChip(
                                  selected: isSelected,
                                  label: Text(brand),
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedBrands.add(brand);
                                      } else {
                                        _selectedBrands.remove(brand);
                                      }
                                    });
                                  },
                                  selectedColor: Colors.blue.withOpacity(0.2),
                                  checkmarkColor: Colors.blue,
                                  labelStyle: TextStyle(
                                    color: isSelected ? Colors.blue : Colors.black,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Divider(height: 32),
                        // Sizes Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sizes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Replace with your theme color
                              ),
                            ),
                            SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: sizes.map((size) {
                                final isSelected = _selectedSizes.contains(size);
                                return FilterChip(
                                  selected: isSelected,
                                  label: Text(size),
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedSizes.add(size);
                                      } else {
                                        _selectedSizes.remove(size);
                                      }
                                    });
                                  },
                                  selectedColor: Colors.blue.withOpacity(0.2),
                                  checkmarkColor: Colors.blue,
                                  labelStyle: TextStyle(
                                    color: isSelected ? Colors.blue : Colors.black,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                         Divider(height: 32),
                        // Colors Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "Colors",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Replace with your theme color
                              ),
                            ),
                            SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: colors.map((color) {
                                return GestureDetector(
                                  onTap: () {
                                    // Handle color selection
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
  );
}
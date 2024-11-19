import 'package:drivado_test_app/models/company.dart';
import 'package:drivado_test_app/widgets/details_widget.dart';
import 'package:flutter/material.dart';

class CompanyDetailsScreen extends StatelessWidget {
  final Company company;

  const CompanyDetailsScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          backgroundColor: Colors.black,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Test Drivado",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "test@drivado.com",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Image.asset(
                          'assets/images/profile.png',
                          color: Colors.black,
                          width: 34,
                          height: 34,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image not found!',
                                style: TextStyle(color: Colors.white));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Company Details',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Deactivate', // Before the toggle
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value: true,
                                    onChanged: (bool newValue) {},
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 34,
                              backgroundImage: NetworkImage(company.logo ?? ""),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    company.companyName ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text(company.email ?? ''),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            const ItemRow(
                              icon: Icons.link_outlined,
                              title: 'Website',
                              text: "drivado.com",
                            ),
                            ItemRow(
                              icon: Icons.phone,
                              title: 'Mob. number',
                              text: company.mobileNumber ?? '',
                            ),
                            const ItemRow(
                              icon: Icons.money_outlined,
                              title: 'GST/VAT',
                              text: "Undefined",
                            ),
                            ItemRow(
                              icon: Icons.location_on_outlined,
                              title: 'Address',
                              text: company.mobileNumber ?? '',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Credit Limit',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        CreditLimit(
                          title: "Total unpaid booking",
                          text: company.totalUnpaidBooking ?? "",
                        ),
                        CreditLimit(
                          title: "Available credit Limit",
                          text: company.totalUnpaidBooking ?? "",
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreditLimit extends StatelessWidget {
  final String title; // Title text
  final String text;
  const CreditLimit({
    required this.title,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListTile(
            dense: true,
            leading: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Text(
              "USD ${text}",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}

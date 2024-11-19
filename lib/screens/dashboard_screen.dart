import 'package:drivado_test_app/screens/company_details_screen.dart';
import 'package:drivado_test_app/screens/user_details_screen.dart';
import 'package:drivado_test_app/services/company_services.dart';
import 'package:drivado_test_app/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Expandable Item ',
      'children': ['Child 1', 'Child 2', 'Child 3'],
    },
    {
      'title': 'Expandable Item ',
      'children': ['Child 1', 'Child 2'],
    },
    {
      'title': 'Expandable Item ',
      'children': ['Child 1', 'Child 2', 'Child 3', 'Child 4'],
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final companyProvider =
          Provider.of<CompanyProvider>(context, listen: false);
      userProvider.fetchUsers();
      companyProvider.fetchCompany(); // Trigger API call or data update
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
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
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade900,
              child: Stack(
                clipBehavior: Clip.none, // To allow the dot to overflow
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_on_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10, // Size of the dot
                      height: 10, // Size of the dot
                      decoration: const BoxDecoration(
                        color: Colors.red, // Red dot color
                        shape: BoxShape.circle, // Circular shape
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Red background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  padding: const EdgeInsets.all(
                      4), // Optional padding inside the box
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/filter.png',
                      color: Colors.black,
                      width: 34,
                      height: 34,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Image not found!',
                            style: TextStyle(color: Colors.white));
                      },
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildTabButton("Users", 0),
                  _buildTabButton("Sub-company", 1),
                ],
              ),
            ),
            if (_selectedTab == 0)
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userProvider.users.length,
                    itemBuilder: (context, index) {
                      final user = userProvider.users[index];
                      return ListTile(
                        leading: const Icon(Icons.person_3_outlined,
                            color: Colors.black),
                        title: Text(userProvider.users[index].name ?? ""),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsScreen(
                                user: user,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            if (_selectedTab == 1)
              Consumer<CompanyProvider>(
                builder: (context, companyProvider, child) {
                  if (companyProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: companyProvider.company.length,
                    itemBuilder: (context, index) {
                      final company = companyProvider.company[index];

                      // Use a fallback list if company.email is null or empty
                      List<String> emails = company.email != null &&
                              company.email!.isNotEmpty
                          ? [company.email!] // If email exists, add to the list
                          : [
                              'example@domain.com',
                              'contact@company.com'
                            ]; // Sample emails for demonstration

                      return ExpansionTile(
                        title: ListTile(
                          leading: const Icon(Icons.apartment_outlined,
                              color: Colors.black),
                          title: Text(company.companyName ?? ""),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompanyDetailsScreen(
                                  company: company,
                                ),
                              ),
                            );
                          },
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add functionality to add an email
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        String newEmail = '';
                                        return AlertDialog(
                                          title: const Text('Add Email'),
                                          content: TextField(
                                            onChanged: (value) {
                                              newEmail = value;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Enter email',
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (newEmail.isNotEmpty) {
                                                  emails.add(newEmail);
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Add'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.person_add_alt_outlined,
                                    color: Colors.red,
                                  ),
                                  label: const Text(
                                    'Add Email',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                for (String email
                                    in emails) // Iterate through emails
                                  ListTile(
                                    leading: const Icon(
                                      Icons.email_outlined,
                                      color: Colors.black,
                                    ),
                                    title: Text(email),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          children: [
            Expanded(
              child: _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                label: "Home",
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 1,
                icon: Icons.car_repair_outlined,
                label: "Bookings",
              ),
            ),
            const SizedBox(width: 48), // Space for the FloatingActionButton
            Expanded(
              child: _buildNavItem(
                index: 2,
                icon: Icons.manage_accounts,
                label: "Manage",
              ),
            ),
            Expanded(
              child: _buildNavItem(
                index: 3,
                icon: Icons.person_2_outlined,
                label: "Profile",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTabButton(
    String title,
    int index,
  ) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedTab = index;
          });
        },
        style: TextButton.styleFrom(
            foregroundColor:
                _selectedTab == index ? Colors.black : Colors.grey.shade700,
            backgroundColor:
                _selectedTab == index ? Colors.white : Colors.grey.shade300,
            side: const BorderSide(color: Color.fromARGB(255, 209, 205, 205)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: index == 0 ? const Radius.circular(12) : Radius.zero,
                bottomLeft:
                    index == 0 ? const Radius.circular(12) : Radius.zero,
                topRight: index == 1 ? const Radius.circular(12) : Radius.zero,
                bottomRight:
                    index == 1 ? const Radius.circular(12) : Radius.zero,
              ),
            )),
        child: Text(
          title,
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required int index, required IconData icon, required String label}) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index; // Update selected index
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? Colors.red
                : Colors.grey.shade700, // Active tab is red
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color:
                  isSelected ? Colors.red : Colors.black, // Active tab is red
            ),
          ),
        ],
      ),
    );
  }
}

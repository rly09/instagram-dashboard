import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List profiles = [];
  bool loading = true;
  String searchQuery = '';
  Timer? autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    fetchProfiles();

    // Auto-refresh every 24 hours (can be adjusted)
    autoRefreshTimer = Timer.periodic(const Duration(hours: 24), (_) {
      fetchProfiles();
    });
  }

  @override
  void dispose() {
    autoRefreshTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchProfiles() async {
    setState(() {
      loading = true;
    });
    const url = 'http://127.0.0.1:8000/profiles';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          profiles = data;
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        throw Exception('Failed to load profiles');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('Error fetching profiles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter profiles based on search
    final filteredProfiles = profiles.where((p) {
      final username = p['username']?.toString().toLowerCase() ?? '';
      final query = searchQuery.toLowerCase();
      return username.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram Dashboard"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search by username...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: loading
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        Colors.grey.shade700),
                    headingTextStyle:
                    const TextStyle(color: Colors.white),
                    dataTextStyle:
                    const TextStyle(color: Colors.white),
                    columns: const [
                      DataColumn(label: Text("Rank")),
                      DataColumn(label: Text("Username")),
                      DataColumn(label: Text("Full Name")),
                      DataColumn(label: Text("Followers")),
                      DataColumn(label: Text("Following")),
                      DataColumn(label: Text("Posts")),
                    ],
                    rows: List<DataRow>.generate(
                      filteredProfiles.length,
                          (index) {
                        final p = filteredProfiles[index];
                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(p['username'] ?? '-')),
                            DataCell(Text(p['full_name'] ?? '-')),
                            DataCell(Text(p['followers'].toString())),
                            DataCell(Text(p['following'].toString())),
                            DataCell(Text(p['posts'].toString())),
                          ],
                          color: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (index % 2 == 0) {
                                return Colors.white.withOpacity(0.1);
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
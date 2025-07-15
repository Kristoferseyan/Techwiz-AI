import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwiz/utils/theme_manager.dart';
import 'package:techwiz/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:techwiz/features/auth/presentation/cubits/auth_state.dart';
import '../cubits/dashboard_cubit.dart';
import '../cubits/dashboard_state.dart';
import '../../domain/entities/issue.dart';
import 'solutions_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthCubit>().state;
      String? token;
      if (authState is AuthSuccess) {
        token = authState.session.token;
      }
      context.read<DashboardCubit>().loadDashboard(token: token);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.computer, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'TechWiz',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          const ThemeToggleButton(),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  Icons.person_outline,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed: () {
                  if (state is AuthSuccess) {
                    _showUserProfile(context, state.session.username);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading || state is DashboardCategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final authState = context.read<AuthCubit>().state;
                      String? token;
                      if (authState is AuthSuccess) {
                        token = authState.session.token;
                      }
                      context.read<DashboardCubit>().loadDashboard(
                        token: token,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is DashboardLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 32),
                  _buildCategories(state.categories),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
        icon: const Icon(Icons.emergency),
        label: const Text('Emergency Help'),
      ),
    );
  }

  Widget _buildSearchBar() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: 'Search for computer issues...',
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          prefixIcon: Icon(Icons.search, color: colorScheme.primary),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.mic, color: colorScheme.onSurfaceVariant),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.clear, color: colorScheme.onSurfaceVariant),
                onPressed: () {
                  _searchController.clear();
                },
              ),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onSubmitted: (query) {
          if (query.trim().isNotEmpty) {
            final authState = context.read<AuthCubit>().state;
            String? token;
            if (authState is AuthSuccess) {
              token = authState.session.token;
            }
            context.read<DashboardCubit>().search(query, token: token);
          }
        },
      ),
    );
  }

  Widget _buildCategories(List<String> categories) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (categories.isEmpty) {
      categories = [
        'All',
        'Hardware Issues',
        'Software Problems',
        'Network Issues',
        'Security',
        'Performance',
      ];
    }

    final filteredCategories = categories.where((cat) => cat != 'All').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse by Category',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),

        _buildViewAllCard(),
        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            final category = filteredCategories[index];
            return _buildCategoryCard(category, index);
          },
        ),
      ],
    );
  }

  void _showUserProfile(BuildContext context, String username) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colorScheme.primary,
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : 'U',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                username,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: Icon(Icons.settings, color: colorScheme.primary),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline, color: colorScheme.primary),
                title: const Text('Help & Support'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: colorScheme.error),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildViewAllCard() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showAllProblemsBottomSheet();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.view_module,
                    color: colorScheme.onPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'View All Problems',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.onPrimary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String category, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final categoryData = _getCategoryData(category, index);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showCategoryBottomSheet(category);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: categoryData['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    categoryData['icon'],
                    color: categoryData['color'],
                    size: 24,
                  ),
                ),
                const Spacer(),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'View issues',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getCategoryData(String category, int index) {
    final categoryMap = {
      'Hardware Issues': {
        'icon': Icons.memory,
        'color': const Color(0xFF2196F3),
      },
      'Software Problems': {
        'icon': Icons.apps,
        'color': const Color(0xFF4CAF50),
      },
      'Internet & Network': {
        'icon': Icons.wifi,
        'color': const Color(0xFFFF9800),
      },
      'Network Issues': {'icon': Icons.wifi, 'color': const Color(0xFFFF9800)},
      'Operating System Errors': {
        'icon': Icons.desktop_windows,
        'color': const Color(0xFF9C27B0),
      },
      'Power & Battery': {
        'icon': Icons.battery_alert,
        'color': const Color(0xFFE91E63),
      },
      'Display & Graphics': {
        'icon': Icons.monitor,
        'color': const Color(0xFF00BCD4),
      },
      'Audio Problems': {
        'icon': Icons.volume_off,
        'color': const Color(0xFFFF5722),
      },
      'Peripheral Devices': {
        'icon': Icons.mouse,
        'color': const Color(0xFF795548),
      },
      'Storage & Disk Issues': {
        'icon': Icons.storage,
        'color': const Color(0xFF607D8B),
      },
      'Performance & Lag': {
        'icon': Icons.speed,
        'color': const Color(0xFF9C27B0),
      },
      'Boot & Startup Issues': {
        'icon': Icons.power_settings_new,
        'color': const Color(0xFFFF9800),
      },
      'Security & Antivirus': {
        'icon': Icons.security,
        'color': const Color(0xFFF44336),
      },

      'Security': {'icon': Icons.security, 'color': const Color(0xFFF44336)},
      'Performance': {'icon': Icons.speed, 'color': const Color(0xFF9C27B0)},
    };

    return categoryMap[category] ??
        {'icon': Icons.help_outline, 'color': const Color(0xFF607D8B)};
  }

  void _showAllProblemsBottomSheet() {
    final authState = context.read<AuthCubit>().state;
    String? token;
    if (authState is AuthSuccess) {
      token = authState.session.token;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return _buildProblemsBottomSheet(
            'All Problems',
            'All',
            token,
            scrollController,
          );
        },
      ),
    );
  }

  void _showCategoryBottomSheet(String category) {
    final authState = context.read<AuthCubit>().state;
    String? token;
    if (authState is AuthSuccess) {
      token = authState.session.token;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return _buildProblemsBottomSheet(
            '$category Issues',
            category,
            token,
            scrollController,
          );
        },
      ),
    );
  }

  Widget _buildProblemsBottomSheet(
    String title,
    String category,
    String? token,
    ScrollController scrollController,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: colorScheme.onSurfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Issue>>(
              future: _fetchCategoryIssues(category, token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading issues',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No issues found',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  );
                }

                final issues = snapshot.data!;
                return ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: issues.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildBottomSheetIssueCard(issues[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetIssueCard(Issue issue) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SolutionsPage(issue: issue),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                issue.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                issue.description,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Issue>> _fetchCategoryIssues(
    String category,
    String? token,
  ) async {
    try {
      final cubit = context.read<DashboardCubit>();
      if (category == 'All') {
        return await cubit.getCommonIssuesData(token: token);
      } else {
        return await cubit.getIssuesByCategoryData(category, token: token);
      }
    } catch (e) {
      throw Exception('Failed to fetch issues: $e');
    }
  }
}

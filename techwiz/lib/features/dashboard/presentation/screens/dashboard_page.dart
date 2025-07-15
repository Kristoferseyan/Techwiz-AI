import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwiz/utils/theme_manager.dart';
import 'package:techwiz/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:techwiz/features/auth/presentation/cubits/auth_state.dart';
import '../cubits/dashboard_cubit.dart';
import '../cubits/dashboard_state.dart';
import '../../../problems/presentation/pages/paginated_issues_page.dart';

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
          if (state is DashboardLoading) {
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
                  _buildCategories(),
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
            // TODO: Implement search functionality with search feature
            // Navigate to search results page or show search dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Search functionality coming soon: "$query"'),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategories() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Static categories for now - these will be managed by the categories feature
    final categories = [
      'Hardware Issues',
      'Software Problems',
      'Network Issues',
      'Security',
      'Performance',
    ];

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
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaginatedIssuesPage(),
              ),
            );
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

  void _showCategoryBottomSheet(String category) {
    // TODO: Implement category bottom sheet with problems feature
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$category issues coming soon')));
  }
}

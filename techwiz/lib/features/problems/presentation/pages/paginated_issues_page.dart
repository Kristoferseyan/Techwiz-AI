import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/issue.dart';
import '../../domain/entities/paginated_response.dart';
import '../cubits/paginated_issues_cubit.dart';
import '../cubits/paginated_issues_state.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../auth/presentation/cubits/auth_state.dart';
import '../../../solutions/presentation/pages/solutions_page.dart';

class PaginatedIssuesPage extends StatefulWidget {
  const PaginatedIssuesPage({super.key});

  @override
  State<PaginatedIssuesPage> createState() => _PaginatedIssuesPageState();
}

class _PaginatedIssuesPageState extends State<PaginatedIssuesPage>
    with TickerProviderStateMixin {
  int currentPage = 0;
  final int pageSize = 10;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _loadPaginatedIssues();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _loadPaginatedIssues() async {
    _fadeController.reset();
    final authState = context.read<AuthCubit>().state;
    String? token;
    if (authState is AuthSuccess) {
      token = authState.session.token;
    }
    context.read<PaginatedIssuesCubit>().loadPaginatedIssues(
      token: token,
      page: currentPage,
      size: pageSize,
    );

    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      _fadeController.forward();
    }
  }

  void _goToNextPage() {
    setState(() {
      currentPage++;
    });
    _loadPaginatedIssues();
  }

  void _goToPreviousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _loadPaginatedIssues();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            title: const Text(
              'All Issues',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary.withOpacity(0.05),
                      colorScheme.secondary.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),

          BlocBuilder<PaginatedIssuesCubit, PaginatedIssuesState>(
            builder: (context, state) {
              if (state is PaginatedIssuesLoading) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: colorScheme.primary,
                          strokeWidth: 3,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading issues...',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is PaginatedIssuesError) {
                return SliverFillRemaining(
                  child: _buildErrorState(state.message, colorScheme),
                );
              }

              if (state is PaginatedIssuesLoaded) {
                final paginatedIssues = state.paginatedIssues;

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < paginatedIssues.content.length) {
                      final issue = paginatedIssues.content[index];
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 16,
                            top: index == 0 ? 20 : 0,
                          ),
                          child: _buildModernIssueCard(issue, colorScheme),
                        ),
                      );
                    } else {
                      return _buildModernPaginationControls(
                        paginatedIssues,
                        colorScheme,
                      );
                    }
                  }, childCount: paginatedIssues.content.length + 1),
                );
              }

              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No issues found',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try refreshing or check back later',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, ColorScheme colorScheme) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.error.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _loadPaginatedIssues,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernIssueCard(Issue issue, ColorScheme colorScheme) {
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
          onTap: () => _navigateToSolutions(context, issue),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.help_outline,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        issue.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
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

                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernPaginationControls(
    PaginatedResponse<Issue> paginatedIssues,
    ColorScheme colorScheme,
  ) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Page ${currentPage + 1} of ${paginatedIssues.totalPages}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${paginatedIssues.totalElements} total issues',
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: paginatedIssues.isFirst ? null : _goToPreviousPage,
                  icon: const Icon(Icons.chevron_left, size: 18),
                  label: const Text('Previous'),
                  style: FilledButton.styleFrom(
                    backgroundColor: paginatedIssues.isFirst
                        ? colorScheme.surfaceVariant
                        : colorScheme.primary,
                    foregroundColor: paginatedIssues.isFirst
                        ? colorScheme.onSurfaceVariant
                        : colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: FilledButton.icon(
                  onPressed: paginatedIssues.isLast ? null : _goToNextPage,
                  label: const Text('Next'),
                  icon: const Icon(Icons.chevron_right, size: 18),
                  style: FilledButton.styleFrom(
                    backgroundColor: paginatedIssues.isLast
                        ? colorScheme.surfaceVariant
                        : colorScheme.primary,
                    foregroundColor: paginatedIssues.isLast
                        ? colorScheme.onSurfaceVariant
                        : colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToSolutions(BuildContext context, Issue issue) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SolutionsPage(issue: issue)),
    );
  }
}

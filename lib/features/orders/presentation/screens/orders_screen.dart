import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import '../cubits/get_orders_history_cubit/get_orders_history_cubit.dart';
import '../widgets/empty_orders.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_error_view.dart';

const double _loadMoreThreshold = 300;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'طلباتي',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: colors.onSurface,
                    ),
                  ),
                ),
                const Expanded(child: _OrdersBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrdersBody extends StatelessWidget {
  const _OrdersBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersHistoryCubit, OrdersHistoryState>(
      builder: (context, state) {
        if (state is OrdersHistoryLoaded) {
          return _OrdersList(state: state);
        }
        if (state is OrdersHistoryInitial || state is OrdersHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrdersHistoryError) {
          return OrdersErrorView(
            message: state.errMessage,
            onRetry: () =>
                context.read<OrdersHistoryCubit>().loadingFirstPage(),
          );
        }

        final loaded = state as OrdersHistoryLoaded;
        if (loaded.orders.isEmpty) return const EmptyOrders();

        return _OrdersList(state: loaded);
      },
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({required this.state});

  final OrdersHistoryLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrdersHistoryCubit>();
    final showFooter = state.hasMore || state.loadMoreFailed;

    return RefreshIndicator(
      onRefresh: () async {
        await cubit.refresh();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final nearEnd = notification.metrics.extentAfter < _loadMoreThreshold;
          if (nearEnd && !state.loadMoreFailed) cubit.loadMore();
          return false;
        },
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: state.orders.length + (showFooter ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == state.orders.length) {
              return _ListFooter(
                failed: state.loadMoreFailed,
                onRetry: cubit.loadMore,
              );
            }
            return OrderCard(order: state.orders[index]);
          },
        ),
      ),
    );
  }
}

class _ListFooter extends StatelessWidget {
  const _ListFooter({required this.failed, required this.onRetry});

  final bool failed;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: failed
            ? TextButton(
                onPressed: onRetry,
                child: Text(
                  'فشل التحميل، إعادة المحاولة',
                  style: TextStyle(fontFamily: fontFamily),
                ),
              )
            : const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rooh/core/const/app_const.dart';
import 'package:rooh/core/injection/service_locator.dart';
import 'package:rooh/features/auth/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:rooh/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:rooh/features/orders/domain/entity/order_item_entity.dart';
import 'package:rooh/features/orders/domain/usecases/generate_order_id_usecase.dart';
import '../../domain/usecases/create_orders_usecase.dart';
import '../cubits/checkout_cubit/checkout_cubit.dart';
import '../cubits/get_orders_history_cubit/get_orders_history_cubit.dart';
import '../widgets/order_success_view.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/shipping_form.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.items,
    this.clearCartOnSuccess = true,
  });

  final List<OrderItemEntity> items;
  final bool clearCartOnSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit(
        getIt<CreateOrderUsecase>(),
        getIt<ClearCartUsecase>(),
        getIt<GenerateOrderIdUsecase>(),
        items,
        clearCartOnSuccess: clearCartOnSuccess,
      ),
      child: _CheckoutView(items: items),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView({required this.items});

  final List<OrderItemEntity> items;

  void _onStateChanged(BuildContext context, CheckoutState state) {
    if (state is CheckoutFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.errorMessage,
            style: TextStyle(fontFamily: fontFamily),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (state is CheckoutSuccess &&
        context.read<AuthCubit>().state is Authenticated) {
      context.read<OrdersHistoryCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: _onStateChanged,
      builder: (context, state) {
        if (state is CheckoutSuccess) {
          return OrderSuccessView(orderId: state.orderId);
        }

        final isSubmitting = state is CheckoutSubmitting;

        return PopScope(
          canPop: !isSubmitting,
          child: Scaffold(
            backgroundColor: colors.surface,
            appBar: AppBar(
              title: Text(
                'إتمام الطلب',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: colors.surface,
              foregroundColor: colors.onSurface,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
            body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OrderSummaryCard(items: items),
                        const SizedBox(height: 24),
                        ShippingForm(
                          isSubmitting: isSubmitting,
                          onSubmit: (shipping) =>
                              context.read<CheckoutCubit>().submit(shipping),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

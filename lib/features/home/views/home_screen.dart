import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:reliance/core/theme/ap_colors.dart';
import 'package:reliance/l10n/app_localizations.dart';
import '../controllers/home_controller.dart';
import '../../auth/controllers/auth_viewmodel.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).fetchAccountData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final HomeController homeController = context.watch<HomeController>();
    final AuthViewModel authViewModel = context.read<AuthViewModel>();

    final currencyFormatter = NumberFormat.currency(
      locale: Localizations.localeOf(context).toString(),
      symbol: '\₵',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: homeController.fetchAccountData,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.logout();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed('settings');
            },
          ),
        ],
      ),
      body: homeController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : homeController.errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Theme.of(context).colorScheme.error,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${localizations.errorTitle} ${homeController.errorMessage}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: homeController.fetchAccountData,
                      child: Text(localizations.retryButton),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            localizations.currentBalance,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currencyFormatter.format(
                              homeController.account?.balance ?? 0.0,
                            ),
                            style: AppTextStyles.headlineLargeLight.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              localizations.updatedJustNow,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      localizations.recentTransactions,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: homeController.transactions.isEmpty
                      ? Center(
                          child: Text(
                            localizations.noTransactions,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: homeController.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction =
                                homeController.transactions[index];
                            final isCredit = transaction.type == 'credit';
                            final transactionColor = isCredit
                                ? (Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.credit
                                      : AppColors.creditDark)
                                : (Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.debit
                                      : AppColors.debitDark);
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ListTile(
                                leading: Icon(
                                  isCredit
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  color: transactionColor,
                                ),
                                title: Text(
                                  transaction.description,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                subtitle: Text(
                                  DateFormat.yMMMd(
                                    Localizations.localeOf(context).toString(),
                                  ).format(transaction.date),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: Text(
                                  '${isCredit ? '+' : '-'}${currencyFormatter.format(transaction.amount)}',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: transactionColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed('payment');
        },
        label: Text(localizations.makePaymentButton),
        icon: const Icon(Icons.send),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

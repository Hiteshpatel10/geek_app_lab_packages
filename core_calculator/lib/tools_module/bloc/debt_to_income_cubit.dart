import 'package:bloc/bloc.dart';
import 'package:core_utility/core_model/core_key_value_pair_model.dart';
import 'package:meta/meta.dart';

part 'debt_to_income_state.dart';

class DebtToIncomeCubit extends Cubit<DebtToIncomeState> {
  double salary = 0.0;
  double freelanceIncome = 0.0;
  double rentalIncome = 0.0;
  double businessIncome = 0.0;

  double homeLoan = 0.0;
  double carLoan = 0.0;
  double personalLoan = 0.0;
  double creditCard = 0.0;
  double otherDebts = 0.0;
  double dtiRatio = 0.0;


  DebtToIncomeCubit() : super(DebtToIncomeInitial());


  List<CoreKeyValuePairModel<String, double, void>> get incomeList => [
    CoreKeyValuePairModel(key: "Salary", value: salary),
    CoreKeyValuePairModel(key: "Freelance Income", value: freelanceIncome),
    CoreKeyValuePairModel(key: "Rental Income", value: rentalIncome),
    CoreKeyValuePairModel(key: "Business Income", value: businessIncome),
  ];

  List<CoreKeyValuePairModel<String, double, void>> get debtList => [
    CoreKeyValuePairModel(key: "Home Loan", value: homeLoan),
    CoreKeyValuePairModel(key: "Car Loan", value: carLoan),
    CoreKeyValuePairModel(key: "Personal Loan", value: personalLoan),
    CoreKeyValuePairModel(key: "Credit Card Debt", value: creditCard),
    CoreKeyValuePairModel(key: "Other Debts", value: otherDebts),
  ];

  double get totalIncome => incomeList.fold(0, (sum, item) => sum + item.value);
  double get totalDebt => debtList.fold(0, (sum, item) => sum + item.value);

  void updateIncome({
    double? salary,
    double? freelance,
    double? rental,
    double? business,
  }) {
    if (salary != null) this.salary = salary;
    if (freelance != null) freelanceIncome = freelance;
    if (rental != null) rentalIncome = rental;
    if (business != null) businessIncome = business;
  }

  void updateDebt({
    double? homeLoan,
    double? carLoan,
    double? personalLoan,
    double? creditCard,
    double? otherDebts,
  }) {
    if (homeLoan != null) this.homeLoan = homeLoan;
    if (carLoan != null) this.carLoan = carLoan;
    if (personalLoan != null) this.personalLoan = personalLoan;
    if (creditCard != null) this.creditCard = creditCard;
    if (otherDebts != null) this.otherDebts = otherDebts;
  }

  void calculateDebtToIncomeRatio() {
    double totalIncome = salary + freelanceIncome + rentalIncome + businessIncome;
    double totalDebt = homeLoan + carLoan + personalLoan + creditCard + otherDebts;

    if (totalIncome == 0) {
      emit(DebtToIncomeCalculated(0.0));
      return;
    }

    double ratio = (totalDebt / totalIncome) * 100;
    dtiRatio = ratio;
    emit(DebtToIncomeCalculated(ratio));
  }
}

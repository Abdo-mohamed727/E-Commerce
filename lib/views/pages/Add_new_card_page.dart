import 'package:ecommerce_new/view_models/AddNewCard_cubit/Paymentmethod_cubit.dart';
import 'package:ecommerce_new/widgets/label_with_textfield_new_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentmethodCubit>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Add New Card',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _FormKey,
          child: Column(
            children: [
              LabelWithTextfield(
                label: 'Card Number',
                controler: _cardNumberController,
                prefixicon: Icons.credit_card,
                hinttext: 'Add Card Number',
              ),
              const SizedBox(height: 20),
              LabelWithTextfield(
                label: 'Card Holder Name',
                controler: _cardHolderNameController,
                prefixicon: Icons.person,
                hinttext: 'Enter Card Holder Name',
              ),
              const SizedBox(height: 20),
              LabelWithTextfield(
                label: 'Expiry Date',
                controler: _expiryDateController,
                prefixicon: Icons.date_range,
                hinttext: 'Enter Expire Date',
              ),
              const SizedBox(height: 20),
              LabelWithTextfield(
                label: 'CVV',
                controler: _cvvController,
                prefixicon: Icons.password,
                hinttext: 'Enter CVV',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: BlocConsumer<PaymentmethodCubit, PaymentMethodState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is Addnewcardlodding ||
                      current is AddNewCardSuccess ||
                      current is AddNewCardFailure,
                  listenWhen: (previous, current) =>
                      current is AddNewCardSuccess ||
                      current is AddNewCardFailure,
                  listener: (context, state) {
                    if (state is AddNewCardSuccess) {
                      Navigator.pop(context);
                    } else if (state is AddNewCardFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is Addnewcardlodding) {
                      return ElevatedButton(
                        onPressed: null,
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_FormKey.currentState!.validate()) {
                          cubit.Setcard(
                            _cardNumberController.text,
                            _cardHolderNameController.text,
                            _expiryDateController.text,
                            _cvvController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Text('Add Card'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

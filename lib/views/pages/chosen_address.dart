import 'package:ecommerce_new/view_models/chosen_location/chosen_location_cubit.dart';
import 'package:ecommerce_new/widgets/location_item_widget.dart';
import 'package:ecommerce_new/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChosenAddressPage extends StatefulWidget {
  const ChosenAddressPage({super.key});

  @override
  State<ChosenAddressPage> createState() => _ChosenAddressPageState();
}

class _ChosenAddressPageState extends State<ChosenAddressPage> {
  final TextEditingController lcationcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChosenLocationCubit>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Address')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chosse Your Location',
                  style: theme.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Let\'s find an unforgettable event. Chosse a location below to get started',
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: lcationcontroler,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon:
                        BlocConsumer<ChosenLocationCubit, ChosenLocationState>(
                      listenWhen: (previuos, current) =>
                          current is AddedLocation ||
                          current is ConfirmlocationSuccess,
                      listener: (context, state) {
                        if (state is AddedLocation) {
                          lcationcontroler.clear();
                        } else if (state is ConfirmlocationSuccess) {
                          Navigator.of(context).pop();
                        }
                      },
                      bloc: cubit,
                      buildWhen: (previous, current) =>
                          current is AddingLocation ||
                          current is AddedLocation ||
                          current is AddingLocayionfailure,
                      builder: (context, state) {
                        if (state is AddingLocation) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return IconButton(
                          onPressed: () {
                            if (lcationcontroler.text.isNotEmpty) {
                              cubit.addlocation(lcationcontroler.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Enter your location!'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.add),
                        );
                      },
                    ),
                    hintText: 'Add your location',
                    prefixIconColor: theme.iconTheme.color,
                    suffixIconColor: theme.iconTheme.color,
                    fillColor: theme.colorScheme.surfaceVariant,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          BorderSide(color: theme.dividerColor, width: 1.2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: theme.colorScheme.error, width: 1.2),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Select Location',
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                BlocBuilder<ChosenLocationCubit, ChosenLocationState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is Fetchedlocation ||
                      current is Fetchinglocation ||
                      current is FetchinglocationFailure,
                  builder: (context, state) {
                    if (state is Fetchinglocation) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is Fetchedlocation) {
                      final locations = state.locations;
                      return ListView.builder(
                        itemCount: locations.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: BlocBuilder<ChosenLocationCubit,
                                ChosenLocationState>(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is Locationchosen,
                              builder: (context, state) {
                                if (state is Locationchosen) {
                                  final chosenlocation = state.location;
                                  return LocationItemWidget(
                                    ontap: () {
                                      cubit.Selectedocation(location.id);
                                    },
                                    location: location,
                                    bordercolor:
                                        chosenlocation.id == location.id
                                            ? theme.colorScheme.primary
                                            : theme.dividerColor,
                                  );
                                }
                                return LocationItemWidget(
                                  ontap: () {
                                    cubit.Selectedocation(location.id);
                                  },
                                  location: location,
                                  bordercolor: theme.dividerColor,
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is FetchinglocationFailure) {
                      return Center(
                        child: Text(state.errormessage,
                            style: theme.textTheme.bodyMedium),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<ChosenLocationCubit, ChosenLocationState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is ConfirmlocationSuccess ||
                      current is ConfirmlocationLooding ||
                      current is Confirmlocationfailure,
                  builder: (context, state) {
                    if (state is ConfirmlocationLooding) {
                      return MainButton(islooding: true);
                    }
                    return MainButton(
                      title: 'Confirm',
                      ontap: () {
                        cubit.confirmlocation();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

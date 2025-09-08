import 'package:ecommerce_new/utils/app_colors.dart';
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
    final size = MediaQuery.of(context).size;

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
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * .01),
                Text(
                  'Let\'s find an unforgettable event. Chosse a location below to get started',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Appcolors.grey),
                ),
                SizedBox(height: size.height * .04),
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
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Appcolors.grey, width: 1.2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Appcolors.grey, width: 1.2),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .04),
                Text(
                  'Select Location',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
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
                                            ? Appcolors.primary
                                            : Appcolors.grey,
                                  );
                                }
                                return LocationItemWidget(
                                  ontap: () {
                                    cubit.Selectedocation(location.id);
                                  },
                                  location: location,
                                  bordercolor: Appcolors.grey,
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is FetchinglocationFailure) {
                      return Center(
                        child: Text(state.errormessage,
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(height: size.height * .02),
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

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/step.dart' as step;
import '../../widgets/hint_card.dart';
import '../step_managing/step_managing.dart';
import 'creating_recipe_cubit.dart';

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  Widget _body(CreatingRecipeState state) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Steps:',
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // ignore: omit_local_variable_types
                      step.Step? nextStep = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StepManaging(),
                        ),
                      );
                      if (nextStep != null) {
                        context.read<CreatingRecipeCubit>().addStep(nextStep);
                      }
                    },
                    child: Container(
                      height: 24,
                      width: 128,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: const Center(
                        child: Text(
                          'add step',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (state.steps.isEmpty)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const HintCard(
                    text: 'Empty steps! \nAdd at least one to create a recipe!',
                  ),
                ),
              if (state.steps.isNotEmpty)
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.7,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    initialPage: state.currentStep,
                    onPageChanged: (index, _) => context
                        .read<CreatingRecipeCubit>()
                        .changeCurrentStep(index),
                  ),
                  items: state.steps.map(
                    (step) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 24,
                              bottom: 24,
                            ),
                            width: 256,
                            height: 256,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(24),
                              image: step.image
                                      .startsWith('https://firebasestorage')
                                  ? DecorationImage(
                                      image: NetworkImage(step.image),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: FileImage(
                                        File(
                                          step.image,
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
              const SizedBox(
                height: 24,
              ),
              if (state.steps.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    '${state.currentStep + 1}: ${state.steps[state.currentStep].description}',
                  ),
                ),
              if (state.isCreating)
                const CircularProgressIndicator(
                  color: Colors.grey,
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons(CreatingRecipeState state) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          left: 32.0,
          child: _backButton(),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: _forwardButton(state),
        ),
      ],
    );
  }

  Widget _backButton() {
    return FloatingActionButton(
      elevation: 16,
      onPressed: () {
        context.read<CreatingRecipeCubit>().previousStage();
      },
      backgroundColor: accentColor,
      child: const Center(
        child: Icon(
          Icons.arrow_back,
          size: 32,
        ),
      ),
    );
  }

  Widget _forwardButton(CreatingRecipeState state) {
    return FloatingActionButton(
      elevation: 16,
      onPressed: () async {
        if (state.steps.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Recipe must have at least one step!',
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.grey[800],
            ),
          );
        } else {
          await context.read<CreatingRecipeCubit>().createRecipe();
          context.read<CreatingRecipeCubit>().reset();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recipe is created successfully!'),
              duration: Duration(seconds: 1),
            ),
          );
          Navigator.pop(context);
        }
      },
      backgroundColor: accentColor,
      child: const Center(
        child: Icon(
          Icons.check,
          size: 32,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatingRecipeCubit, CreatingRecipeState>(
      builder: (_, state) {
        return Scaffold(
          body: _body(state),
          floatingActionButton: _buttons(state),
        );
      },
    );
  }
}

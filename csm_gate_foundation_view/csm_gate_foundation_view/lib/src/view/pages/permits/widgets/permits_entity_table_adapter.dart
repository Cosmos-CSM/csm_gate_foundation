import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Action;
import 'package:flutter/widgets.dart' hide Router, Action;

/// {adapter} class.
///
/// Implements the [GateFoundationEntityTableAdapterBase] for [PermitsEntityTable] {widget}.
final class PermitsEntityTableAdapter extends GateFoundationEntityTableAdapterBase<Permit> {

  /// Creates a new [PermitsEntityTableAdapter] instance.
  PermitsEntityTableAdapter();

  @override
  Widget composeViewer(BuildContext buildContext, Permit entity) {
    return EntityTableViewer(
      children: <Widget>[

        /// --> Timestamp
        PropertyViewer<String>(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
        ),

        /// --> Reference
        PropertyViewer<String>(
          label: 'Reference code',
          value: entity.reference,
        ),

        /// --> Name
        PropertyViewer<String>(
          label: 'Name',
          value: entity.name,
        ),

        /// --> Description
        PropertyViewer<String>(
          label: 'Description',
          value: entity.description ?? '---',
        ),

        /// --> Email
        PropertyViewer<String>(
          label: 'Enabled',
          value: entity.isEnabled? 'Yes' : 'No',
        ),

        /// --> Solution 
        PropertyViewer<String>(
          label: 'Solution',
          value: entity.solution.name,
        ),

        SectionDivider(text: 'Feature details'),

        /// --> Feature name 
        PropertyViewer<String>(
          label: 'Feature',
          value: entity.feature.name,
        ),

        /// --> Feature enabled status
        PropertyViewer<String>(
          label: 'Feature enabled',
          value: entity.feature.enabled? 'Yes' : 'No',
        ),

        SectionDivider(text: 'Action details'),

        /// --> Action name 
        PropertyViewer<String>(
          label: 'Action',
          value: entity.action.name,
        ),

        /// --> Action enabled status
        PropertyViewer<String>(
          label: 'Action enabled',
          value: entity.action.isEnabled? 'Yes' : 'No',
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Permit>? composeEditor() {

    return EntityTableAdapterEditor<Permit>(
      onUpdate: (EntityTableAdapterEditorData<Permit> data) {
        final Router router = InjectorUtils.get();

        showDialog(
          context: data.context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(data.entity, router, context),
        );
      },

      formBuilder:(EntityTableAdapterEditorData<Permit> data) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              const SectionDivider(text: 'Permit details'),
              TextInput(
                width: double.infinity,
                label: 'Timestamp',
                isEnabled: false,
                controller: TextEditingController(
                  text: data.entity.timestamp.fullDate,
                ),
              ),
              OptionsSelector<bool>(
                title: 'Enabled',
                preSelected: <bool>[data.entity.enabled],
                options:  <OptionsSelectorOption<bool>>[
                  OptionsSelectorOption<bool>(
                    title: 'Yes',
                    value: true,
                  ),
                  OptionsSelectorOption<bool>(
                    title: 'No',
                    value: false,
                  ),
                ],
                onSelect: (List<bool> selected) {
                  data.entity.enabled = selected.firstOrNull ?? false;
                },
              ),
              TextInput(
                width: double.infinity,
                label: '*Reference code',
                maxLength: 8,
                isFixedLength: true,
                controller: TextEditingController(
                  text: data.entity.reference,
                ),
                onChanged: (String text) {
                  data.entity.reference = text;
                },
              ),
              TextInput(
                width: double.infinity,
                label: '*Name',
                maxLength: 100,
                controller: TextEditingController(
                  text: data.entity.name,
                ),
                onChanged: (String text) {
                  data.entity.name = text;
                },
              ),
              TextInput(
                width: double.infinity,
                label: 'Description',
                maxLength: 200,
                controller: TextEditingController(
                  text: data.entity.description,
                ),
                onChanged: (String text) {
                  data.entity.description = text.;
                },
              ),
              EntityFinderSelector<Solution, SolutionsServiceI>(
                entityBuilder: () => Solution(),
                label: '*Select a Solution...',
                initialValue: data.entity.solution,
                textBuilder: (Solution solution) {
                  return solution.name;
                },
                onSelected: (Solution? solution) {
                  data.entity.solution = solution ?? Solution();
                },
              ),
              EntityFinderSelector<Feature, FeaturesServiceI>(
                entityBuilder: () => Feature(),
                label: '*Select a Feature...',
                initialValue: data.entity.feature,
                textBuilder: (Feature feature) {
                  return feature.name;
                },
                onSelected: (Feature? feature) {
                  data.entity.feature = feature ?? Feature();
                },
              ),
              EntityFinderSelector<Action, IActionsService>(
                entityBuilder: () => Action(),
                label: '*Select an Action...',
                initialValue: data.entity.action,
                textBuilder: (Action action) {
                  return action.name;
                },
                onSelected: (Action? action) {
                  data.entity.action = action ?? Action();
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(Permit entity, Router router, BuildContext context) async {
    IPermitsService permitsService = InjectorUtils.get();

    List<EntityErrors<Permit>> invalidations = entity.evaluate(<EntityErrors<Permit>>[]);

    if(invalidations.isNotEmpty){
      await showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InvalidatingDialog(
            title: 'Invalid Values',
            invalidations: invalidations,
            router: router,
            context: context,
          );
        },
      );
      return;
    }

    String authToken = await composeAuth();

    ResponseResolverBase<UpdateOutput<Permit>> resResolver = await permitsService.update(
      UpdateInput<Permit>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      factory:
          () => UpdateOutput<Permit>(
            () => Permit(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Permit>> success) {
        refresh();
      },
      onFailure: (FailureFrame failure, int status) {
        errMessage = failure.content.advise;
      },
      onException: (TracedException exception) {
        errMessage = FoundationMessages.unknownServerException;
      },
      onConnectionFailure: () {
        errMessage = FoundationMessages.connectionError;
      },
      onFinally: () {
        Navigator.of(context).pop();
        if (errMessage == null) return;

        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              showCancelButton: false,
              title: 'Error Updating contact',
              content: Text(
                errMessage as String,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              theming: ThemingUtils.get<FoundationThemeB>(context).controlError,
              onAccept: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildUpdateDialog(Permit entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Permit update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Reference code',
          value: entity.reference,
        ),
        TextLabel(
          title: 'Name',
          value: entity.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Description',
          value: entity.description.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Enabled',
          value: entity.enabled? 'Yes' : 'No',
        ),
        TextLabel(
          title: 'Solution',
          value: entity.solution.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Feature',
          value: entity.feature.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Action',
          value: entity.action.name.cleaned ?? '---',
        ),
      ],
    );
  }
}
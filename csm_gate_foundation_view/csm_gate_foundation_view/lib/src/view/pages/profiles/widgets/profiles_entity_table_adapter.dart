import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router;

/// {adapter} class.
///
/// Implements the [GateFoundationEntityTableAdapterBase] for [ProfilesEntityTable] {widget}.
final class ProfilesEntityTableAdapter extends GateFoundationEntityTableAdapterBase<Profile> {
  
  /// Creates a new [ProfilesEntityTableAdapter] instance.
  ProfilesEntityTableAdapter();

  @override
  Widget composeViewer(BuildContext buildContext, Profile entity) {
    return EntityTableViewer(
      children: <Widget>[

        /// --> Timestamp
        PropertyViewer<String>(
          label: 'Timestamp',
          value: entity.timestamp.fullDate,
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

        const SectionDivider(text: 'Associated Permits'),

        ListViewer<Permit>(
          title: 'Permits',
          tilesContent: entity.permits,
          tileTitle:(Permit permit) => '${permit.solution} - ${permit.name}',
        ),
      ],
    );
  }

 @override
  EntityTableAdapterEditor<Profile>? composeEditor() {

    return EntityTableAdapterEditor<Profile>(
      onUpdate: (EntityTableAdapterEditorData<Profile> data) {
        final Router router = InjectorUtils.get();

        showDialog(
          context: data.context,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(data.entity, router, context),
        );
      },

      formBuilder:(EntityTableAdapterEditorData<Profile> data) {
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
                  data.entity.description = text.cleaned;
                },
              ),
              SelectableListAsync<Permit, PermitsServiceI>(
                title: 'Available Permits',
                entityBuilder: () => Permit(),
                initialValues: data.entity.permits,
                tileTitle:(Permit permit) => '${permit.solution.name} - ${permit.name}',
                onSelect:(bool selected, Permit item) {
                  if(selected){
                    if(data.entity.permits.contains(item)) return;
                    data.entity.permits.add(item);
                    return;
                  }
                  data.entity.permits.remove(item);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _onUpdate(Profile entity, Router router, BuildContext context) async {
    IProfilesService profilesService = InjectorUtils.get();

    List<EntityErrors<Profile>> invalidations = entity.evaluate(<EntityErrors<Profile>>[]);

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

    ResponseResolverBase<UpdateOutput<Profile>> resResolver = await profilesService.update(
      UpdateInput<Profile>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      factory:
          () => UpdateOutput<Profile>(
            () => Profile(),
          ),
      onSuccess: (SuccessFrame<UpdateOutput<Profile>> success) {
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

  Widget _buildUpdateDialog(Profile entity, Router router, BuildContext context){
    return ResumeDialog(
      title: 'Confirm Permit update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Name',
          value: entity.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Description',
          value: entity.description.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Assigned permits',
          value: entity.permits.length.toString(),
        ),
        for(int i = 0; i > entity.permits.length; i++)
        TextLabel(
          title: 'Permit #$i',
            value: '${entity.permits[i].solution} - ${entity.permits[i].name}',
          ),
      ],
    );
  }
}
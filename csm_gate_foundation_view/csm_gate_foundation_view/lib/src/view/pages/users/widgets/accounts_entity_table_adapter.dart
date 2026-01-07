import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';
import 'package:csm_gate_foundation_view/csm_gate_foundation_view.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

///
final class UsersEntityTableAdatper extends GateFoundationEntityTableAdapterBase<User> {
  /// Creates a new instance.
  UsersEntityTableAdatper();

  @override
  Widget composeViewer(BuildContext buildContext, User entity) {
    return EntityTableViewer(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: <Widget>[
            PropertyViewer<String>(
              label: 'Username',
              value: entity.username,
            ),
            PropertyViewer<String>(
              label: 'Password',
              value: '*****',
            ),
          ],
        ),
      ],
    );
  }

  @override
  EntityTableAdapterEditor<User>? composeEditor() {
    return EntityTableAdapterEditor<User>(
      onUpdate: (BuildContext buildContext, User entity) {
        IRouter router = InjectorUtils.get();

        showDialog(
          context: buildContext,
          useRootNavigator: true,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildUpdateDialog(entity, router, context),
        );
      },

      formBuilder: (BuildContext buildContext, User entity) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            spacing: 20,
            children: <Widget>[
              TextInput(
                width: double.infinity,
                label: 'Timestamp',
                isEnabled: false,
                controller: TextEditingController(
                  text: entity.timestamp.toString(),
                ),
              ),

              TextInput(
                width: double.infinity,
                label: '*Username',
                maxLength: 50,
                controller: TextEditingController(
                  text: entity.username,
                ),
                onChanged: (String text) {
                  entity.username = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Password',
                controller: TextEditingController(
                  text: entity.password,
                ),
                onChanged: (String text) {
                  entity.password = text;
                },
              ),

              OptionsSelector<bool>(
                title: 'Wildcard',
                preSelected: <bool>[entity.wildcard],
                options: <OptionsSelectorOption<bool>>[
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
                  entity.wildcard = selected.isNotEmpty ? selected.first : false;
                },
              ),

              /// --> Contact details
              const SectionDivider(
                text: 'Contact details',
              ),

              TextInput(
                width: double.infinity,
                label: '*Name',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.contact.name,
                ),
                onChanged: (String text) {
                  entity.contact.name = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Lastname',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.contact.lastName,
                ),
                onChanged: (String text) {
                  entity.contact.lastName = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Email',
                maxLength: 100,
                controller: TextEditingController(
                  text: entity.contact.eMail,
                ),
                onChanged: (String text) {
                  entity.contact.eMail = text;
                },
              ),

              TextInput(
                width: double.infinity,
                label: '*Phone',
                maxLength: 14,
                controller: TextEditingController(
                  text: entity.contact.phone,
                ),
                onChanged: (String text) {
                  entity.contact.phone = text;
                },
              ),

              /// --> Security access level
              const SectionDivider(
                text: 'Security access details',
              ),

              SelectableList<Profile, ProfilesServiceI>(
                heigth: 350,
                title: 'Available Profiles',
                entityBuilder: () => Profile(),
                initialValues: entity.profiles,
                tileTitle: (Profile profile) => profile.name,
                onSelect: (bool selected, Profile item) {},
              ),

              SelectableList<Permit, PermitsServiceI>(
                heigth: 350,
                title: 'Available Permits',
                entityBuilder: () => Permit(),
                initialValues: entity.permits,
                tileTitle: (Permit permit) => '${permit.solution.name} - ${permit.name}',
                onSelect: (bool selected, Permit item) {},
              ),
            ],
          ),
        );
      },
    );
  }

  void _onUpdate(User entity, IRouter router, BuildContext context) async {
    AccountServiceI accountsService = Injector.get();

    List<EntityInvalidation<Account>> invalidations = entity.evaluate();

    if (invalidations.isNotEmpty) {
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

    FoundationResponseResolver<UpdateOutput<Account>> resResolver = await accountsService.update(
      UpdateInput<Account>(entity),
      authToken,
    );

    String? errMessage;
    resResolver.resolve(
      objectBuilder: () => UpdateOutput<Account>(
        () => Account(),
      ),
      onSuccess: (SuccessFrame<UpdateOutput<Account>> success) {
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
        router.pop();
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
              theming: Theming.get<FoundationThemeB>(context).error,
              onAccept: () {
                router.pop();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildUpdateDialog(User entity, IRouter router, BuildContext context) {
    return ResumeDialog(
      title: 'Confirm Account update',
      router: router,
      context: context,
      acceptLabel: 'Update',
      onAccept: () => _onUpdate(entity, router, context),
      values: <TextLabel>[
        TextLabel(
          title: 'Username',
          value: entity.user.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Password',
          value: entity.password.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Wildcard',
          value: entity.wildcard ? 'Yes' : 'No',
        ),
        TextLabel(
          title: 'Name',
          value: entity.contact.name.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Lastname',
          value: entity.contact.lastName.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Email',
          value: entity.contact.eMail.cleaned ?? '---',
        ),
        TextLabel(
          title: 'Phone',
          value: entity.contact.phone.cleaned ?? '---',
        ),

        for (int i = 0; i < entity.profiles.length; i++)
          TextLabel(
            title: 'Profile #${i + 1}',
            value: entity.profiles[i].name,
          ),

        for (int i = 0; i < entity.permits.length; i++)
          TextLabel(
            title: 'Permit #${i + 1}',
            value: entity.permits[i].name,
          ),
      ],
    );
  }
}

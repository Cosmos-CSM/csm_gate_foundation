
import 'package:csm_gate_foundation_client/csm_gate_foundation_client.dart';


/// Types of vendors available in the system.
enum VendorType {
  owner,
  supplier,
  contractor,
  subcontractor,
  serviceProvider,
  consultant,
  partner,
  subtenent,
}

/// Defines a security entity that stores the data for vendors.
final class Vendor extends CatalogEntityBase<Vendor> {
  /// [Vendor.vendors] property key for [DataMap].
  static const String kVendors = 'vendors';

  /// [User]s collection related to this vendor.
  List<User> users = <User>[];
  
  /// Generates a new [Vendor] instance from mandatory values.
  Vendor();

  @override
  void decode(DataMap encode) {
    super.decode(encode);
    List<DataMap> vendorsMaps = encode.getList(kVendors);
    if (vendorsMaps.isNotEmpty) {
      users = vendorsMaps.map<User>(
        (DataMap e) {
          User account = User();
          account.decode(e);
          return account;
        },
      ).toList();
    }
  }
  
  @override
  DataMap encode([DataMap? entityObject]) {
    return super.encode(
      <String, Object?>{
        Vendor.kVendors: users.map((User e) => e.encode()).toList(),
      },
    );
  }
  
  @override
  List<EntityErrors<Vendor>> evaluate(List<EntityErrors<Vendor>> errors) {
     //TODO Add trim and lenght validator to evaluate base methods for string values -> (name.trim().isEmpty || name.length > 100) 
     //! maybe description evaluation too?

    errors = super.evaluate(errors);
    if (id < BigInt.zero) {
      errors.add(
        EntityErrors<Vendor>(
          this,
          PropertyInfo(CorePropertiesConsts.id, int, id),
          'Pointer: $id, cannot be less than 0.',
          '$id < 0',
        ),
      );
    }
    
    if (description != null) {
      if (description!.trim().isEmpty || description!.length > 200) {
        errors.add(
          EntityErrors<Vendor>(
            this,
            PropertyInfo(CorePropertiesConsts.description, String, description),
            "Lenght: ${description!.length}, less than 200 characters or empty.",
            "201 > length",
          ),
        );
      }
    }
    if (reference.length != 8) {
      errors.add(
        EntityErrors<Vendor>(
          this,
          PropertyInfo(CorePropertiesConsts.reference, String, reference),
          "Reference value must contain 8 characters",
          "strictLength(8)",
        ),
      );
    }
    return errors;
  }
  
  @override
  List<ObjectDifference> compare(Vendor ref, [List<ObjectDifference>? aggregated]) {
    aggregated = super.compare(ref, aggregated);

    return aggregated;
  }

}

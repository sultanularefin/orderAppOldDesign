
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';

class OneOrderFirebase {

  CustomerInformation       oneCustomer;
  List<OrderedItem>         orderedItems;
  String                    orderBy;
  String                    paidStatus;
  String                    paidType;
  double                    totalPrice;
  String                    contact;
  String                    driverName;
  DateTime                  endDate;
  DateTime                  startDate;
  String                    formattedOrderPlacementDate;
  String                    formattedOrderPlacementDatesTimeOnly;
  String                    orderStatus;
  String                    tableNo;
  String                    orderType;
  String                    documentId;
  int                    orderProductionTime;

  OneOrderFirebase(
      {
        this.oneCustomer,
        this.orderedItems,
        this.orderBy,
        this.paidStatus,
        this.paidType,
        this.totalPrice,
        this.contact,
        this.driverName,
        this.endDate,
        this.startDate,
        this.formattedOrderPlacementDate,
        this.formattedOrderPlacementDatesTimeOnly,
        this.orderStatus,
        this.tableNo,
        this.orderType,
        this.documentId,
        this.orderProductionTime, //  int minutes3 =minutes2.ceil(); // no need to have double
      }
      );



}

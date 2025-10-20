@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_CUST_DASHBOARD'
@Metadata.allowExtensions: true
define root view entity ZC_CUST_DASHBOARD
  as select from ZI_CUST_DASHBOARD
{
  key MaterialBaseUnit,
  key Material,
      Product,
      ProductType,
      MaterialTypeName,
      ProductDescription,
      Plant,
      PlantName,
      ProductionOrderType,
      ProductionOrderTypeName,
      GoodsMovementType,
      //      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      //      @DefaultAggregation: #SUM
      //      QuantityInBaseUnit,
      Qty,
      PostingDate,
      OrderID
}

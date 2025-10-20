@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_CUST_DASHBOARD'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_CUST_DASHBOARD
  as select from    I_MaterialDocumentItem_2  as MatDoc
    inner join      I_Plant                   as PlantData       on MatDoc.Plant = PlantData.Plant
    inner join      Zmatdec                   as ProdDes         on MatDoc.Material = ProdDes.Product
    inner join      I_Product                 as Prod            on MatDoc.Material = Prod.Product
    left outer join I_ProductionOrder         as ProdOrd         on MatDoc.OrderID = ProdOrd.ProductionOrder
    left outer join I_ProductTypeText         as ProdTypeText    on  Prod.ProductType      = ProdTypeText.ProductType
                                                                 and ProdTypeText.Language = $session.system_language
    left outer join I_ProductionOrderTypeText as ProdOrdTypeText on  ProdOrd.ProductionOrderType = ProdOrdTypeText.ProductionOrderType
                                                                 and ProdOrdTypeText.Language    = $session.system_language
{
  key MatDoc.MaterialBaseUnit,
  key MatDoc.Material,

      Prod.Product as Product,
      Prod.ProductType,
      ProdTypeText.MaterialTypeName,
      ProdDes.ProductDescription,
      MatDoc.Plant,
      PlantData.PlantName,
      ProdOrd.ProductionOrderType,
      ProdOrdTypeText.ProductionOrderTypeName,
      MatDoc.GoodsMovementType,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #SUM
      
      cast(
        case
          when MatDoc.GoodsMovementType = '101' then MatDoc.QuantityInBaseUnit
          when MatDoc.GoodsMovementType = '102' then ( MatDoc.QuantityInBaseUnit * -1 )
          else 0
        end as abap.quan(13,3)
      )            as Qty,


      MatDoc.PostingDate,
      MatDoc.OrderID
}
where
  (
       MatDoc.GoodsMovementType = '101'
    or MatDoc.GoodsMovementType = '102'
  )

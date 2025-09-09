declare @ProductID varchar(MAX) = '<ALL>',
    @decMarkup decimal(19,5) = 0.1;

select a.*,b.curXLftPricePerLF, iif(cur10ftPricePerLF = 0, 1,(curXLftPricePerLF-cur10ftPricePerLF)/cur10ftPricePerLF) as decXLMarkupPerLF
from (
    select ic.strProductID, ic.memDescription, ic.curSalesPrice/iif(um.decDefLinearMeasurement1+(decDefLinearMeasurement2/12) =0, 10, (um.decDefLinearMeasurement1+(decDefLinearMeasurement2/12))) as cur10ftPricePerLF, left(ic.strProductID, len(ic.strproductID)-2) as strBaseID
    from tblICInventory ic
    inner join tblICInventoryUnitMeasure um on um.strProductID = ic.strProductID and um.strUnitMeasure = ic.strUnitMeasure
    where strCategory = 'trim' and ysnAssembly = 0 and right(ic.strProductID,
     2) in ('10') and (@ProductID = '<ALL>' or ic.strProductID in (select item from dbo.funcSplitList(@ProductID, ',')))
) as a
inner join (
    select ic.strProductID,ic.memDescription,ic.curSalesPrice as curXLftPricePerLF, left(ic.strProductID,len(ic.strproductID)-2) as strBaseID
    from tblICInventory ic
    inner join tblICInventoryUnitMeasure um on um.strProductID = ic.strProductID and um.strUnitMeasure = ic.strUnitMeasure
    where strCategory = 'trim' and ysnAssembly = 0 and right(ic.strProductID, 2) in ('XL') and (@ProductID = '<ALL>' or ic.strProductID in (select item from dbo.funcSplitList(@ProductID, ',')))
) as b on b.strBaseID = a.strBaseID
where iif(cur10ftPricePerLF = 0, 1,(curXLftPricePerLF-cur10ftPricePerLF)/cur10ftPricePerLF) <= @decMarkup order by decXLMarkupPerLF


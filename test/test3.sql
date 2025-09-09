select * 
--update i set strItemClass = ''
from tblICInventory i 

select *
from tblICItemClass c

--NON STOCK TRIM & PANELS
select i.strProductID,i.memDescription,strCategory,strSubCategory,intAssemblyType,i.strItemClass,ic2.strItemClass
--update i set strItemCLass = ic2.strItemClass,strCOGSAccountID=ic2.strCOGSAccountID,strInventoryAccountID=ic2.strInventoryAccountID,strSalesAccountID= ic2.strSalesAccountID,ysnTrackStock = ic2.ysnInventory
from tblICInventory i left join tblICItemClass ic on ic.strItemClass = i.strItemClass left join tblICItemClass ic2 on ic2.strItemClass = 'Non-Stock Manufactured Metal'
where ic.strItemClass is null and i.ysnTrackStock = 0 and i.strCategory in ('Trim','Panels')

--STOCK TRIM & PANELS
select i.strProductID,i.memDescription,strCategory,strSubCategory,intAssemblyType,i.strItemClass,ic2.strItemClass
--update i set strItemCLass = ic2.strItemClass,strCOGSAccountID=ic2.strCOGSAccountID,strInventoryAccountID=ic2.strInventoryAccountID,strSalesAccountID= ic2.strSalesAccountID,ysnTrackStock = ic2.ysnInventory
from tblICInventory i left join tblICItemClass ic on ic.strItemClass = i.strItemClass left join tblICItemClass ic2 on ic2.strItemClass = 'Stock Manufactured Metal'
where ic.strItemClass is null and i.ysnTrackStock = 1 and i.strCategory in ('Trim','Panels')

--NON STOCK COILS
select i.strProductID,i.memDescription,strCategory,strSubCategory,intAssemblyType,i.strItemClass,ic2.strItemClass
--update i set strItemCLass = ic2.strItemClass,strCOGSAccountID=ic2.strCOGSAccountID,strInventoryAccountID=ic2.strInventoryAccountID,strSalesAccountID= ic2.strSalesAccountID,ysnTrackStock = ic2.ysnInventory
from tblICInventory i left join tblICItemClass ic on ic.strItemClass = i.strItemClass left join tblICItemClass ic2 on ic2.strItemClass = 'Non-Stock Coils'
where ic.strItemClass is null and i.ysnTrackStock = 0 and i.strCategory in ('Coils')

--STOCK COILS
select i.strProductID,i.memDescription,strCategory,strSubCategory,intAssemblyType,i.strItemClass,ic2.strItemClass
--update i set strItemCLass = ic2.strItemClass,strCOGSAccountID=ic2.strCOGSAccountID,strInventoryAccountID=ic2.strInventoryAccountID,strSalesAccountID= ic2.strSalesAccountID,ysnTrackStock = ic2.ysnInventory
from tblICInventory i left join tblICItemClass ic on ic.strItemClass = i.strItemClass left join tblICItemClass ic2 on ic2.strItemClass = 'Stock Coils'
where ic.strItemClass is null and i.ysnTrackStock = 1 and i.strCategory in ('Coils')

--MISC NON STOCK ITEMS
select i.strProductID,i.memDescription,strCategory,strSubCategory,intAssemblyType,i.strItemClass,ic2.strItemClass
--update i set strItemCLass = ic2.strItemClass,strCOGSAccountID=ic2.strCOGSAccountID,strInventoryAccountID=ic2.strInventoryAccountID,strSalesAccountID= ic2.strSalesAccountID,ysnTrackStock = ic2.ysnInventory
from tblICInventory i left join tblICItemClass ic on ic.strItemClass = i.strItemClass left join tblICItemClass ic2 on ic2.strItemClass = 'Non-Stock Other'
where ic.strItemClass is null and i.ysnTrackStock = 0 and i.strCategory in ('MISC')



select i.strProductID,i.memDescription,strCategory,strSubCategory,intAssemblyType,i.strItemClass,ic2.strItemClass
--select distinct strCategory
--update i set strItemCLass = ic2.strItemClass,strCOGSAccountID=ic2.strCOGSAccountID,strInventoryAccountID=ic2.strInventoryAccountID,strSalesAccountID= ic2.strSalesAccountID,ysnTrackStock = ic2.ysnInventory
from tblICInventory i
left join tblICItemClass ic on ic.strItemClass = i.strItemClass
left join tblICItemClass ic2 on ic2.strItemClass = 'Stock Resale'
where ic.strItemClass is null 
--and i.ysnTrackStock = 0
--and i.strCategory ='Flashings' 
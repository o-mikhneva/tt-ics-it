if  object_id('dbo.vw_SKUPrice') is not null
	drop view dbo.vw_SKUPrice; 
go

create view dbo.vw_SKUPrice
as
select
	ID
	,Code
	,Name
	,dbo.udf_GetSKUPrice(ID) as Price
from dbo.SKU;

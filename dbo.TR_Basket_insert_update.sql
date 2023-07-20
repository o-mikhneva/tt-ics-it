if  object_id('dbo.TR_Basket_insert_update', 'TR') is not null
	drop trigger dbo.TR_Basket_insert_update; 
go

create trigger dbo.TR_Basket_insert_update 
on dbo.Basket 
after insert
as
update dbo.Basket
	set DiscountValue = Value * 0.05
	where ID_SKU in (select ID_SKU
					 from inserted
					 group by ID_SKU
					 having count(ID_SKU) >= 2);

go

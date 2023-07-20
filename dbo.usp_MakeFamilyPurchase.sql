if  object_id('dbo.usp_MakeFamilyPurchase', 'P') is not null
	drop proc dbo.usp_MakeFamilyPurchase; 
go

create proc dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
declare @IDFamily INT;
declare @SumValue money;

select 
	@IDFamily = ID
from dbo.Family
where SurName = @FamilySurName;

select
	@SumValue = sum(Value)
from dbo.Basket
where ID_Family = @IDFamily;

begin try
	update dbo.Family
		set BudgetValue -= @SumValue
		where SurName = @FamilySurName;
end try

begin catch
	print('Такой семьи нет')
end catch;

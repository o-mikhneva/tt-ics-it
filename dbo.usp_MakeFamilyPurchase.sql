--Создать процедуру (на выходе: файл в репозитории dbo.usp_MakeFamilyPurchase в ветке Procedures
--5.1 Входной параметр (@FamilySurName varchar(255)) одно из значений атрибута SurName таблицы dbo.Family
--5.2 Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике
--   5.2.1 dbo.Family.BudgetValue - sum(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи
--   5.2.2 При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет

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
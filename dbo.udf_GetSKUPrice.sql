--Создать функцию (на выходе: файл в репозитории dbo.udf_GetSKUPrice.sql в ветке Functions)
--3.1 Входной параметр @ID_SKU
--3.2 Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле
--   3.1.1 сумма Value по переданному SKU / сумма Quantity по переданному SKU
--3.3 На выходе значение типа decimal(18, 2)

if object_id('dbo.udf_GetSKUPrice') is not null
	drop function dbo.udf_GetSKUPrice;
go

-- Transact-SQL Scalar Function Syntax
create function dbo.udf_GetSKUPrice
( 
	@ID_SKU int
)
	returns decimal(18, 2)
	begin
		declare @SumValue money
				,@SumQuantity numeric(10,3)
				,@Price decimal(18, 2)
		select
			@SumValue = SUM(Value)
			,@SumQuantity = SUM(Quantity) 
		from dbo.Basket
		where ID_SKU = @ID_SKU
		set @Price = @SumValue / @SumQuantity
		return @Price
	end;
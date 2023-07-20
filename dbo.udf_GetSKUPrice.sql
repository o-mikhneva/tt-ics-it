if object_id('dbo.udf_GetSKUPrice') is not null
	drop function dbo.udf_GetSKUPrice;
go

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

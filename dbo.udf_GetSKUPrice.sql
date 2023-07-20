--������� ������� (�� ������: ���� � ����������� dbo.udf_GetSKUPrice.sql � ����� Functions)
--3.1 ������� �������� @ID_SKU
--3.2 ������������ ��������� ������������� �������� �� ������� dbo.Basket �� �������
--   3.1.1 ����� Value �� ����������� SKU / ����� Quantity �� ����������� SKU
--3.3 �� ������ �������� ���� decimal(18, 2)

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
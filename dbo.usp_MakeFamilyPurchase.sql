--������� ��������� (�� ������: ���� � ����������� dbo.usp_MakeFamilyPurchase � ����� Procedures
--5.1 ������� �������� (@FamilySurName varchar(255)) ���� �� �������� �������� SurName ������� dbo.Family
--5.2 ��������� ��� ������ ��������� ������ � ������� dbo.Family � ���� BudgetValue �� ������
--   5.2.1 dbo.Family.BudgetValue - sum(dbo.Basket.Value), ��� dbo.Basket.Value ������� ��� ���������� � ��������� �����
--   5.2.2 ��� �������� ��������������� dbo.Family.SurName ������������ �������� ������, ��� ����� ����� ���

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
	print('����� ����� ���')
end catch;
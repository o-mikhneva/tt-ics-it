--������� ������� (�� ������: ���� � ����������� CreateStructure.sql � ����� Tables)
--2.1 dbo.SKU (ID identity, Code, Name)
--   2.1.1 ����������� �� ������������ ���� Code
--   2.1.2 ���� Code �����������: "s" + ID

if object_id('dbo.SKU', 'U') is not null
	drop table dbo.SKU;

create table dbo.SKU
(
	ID int not null identity
	,Code as concat('s', ID)
	,Name varchar(50)
	,constraint PK_SKU primary key(ID)
	,constraint UNQ_SKU_Code unique(Code)  
);

--2.2 dbo.Family (ID identity, SurName, BudgetValue)

if object_id('dbo.Family', 'U') is not null
	drop table dbo.Family;

create table dbo.Family
(
	ID int not null identity
	,SurName varchar(255)
	,BudgetValue money
	,constraint PK_Family primary key(ID)
);

--2.3 dbo.Basket (ID identity, ID_SKU (������� ���� �� ������� dbo.SKU), ID_Family (������� ���� �� ������� dbo.Family) Quantity, Value, PurchaseDate, DiscountValue)
--   2.3.1 �����������, ��� ���� Quantity � Value �� ����� ���� ������ 0
--  2.3.2 �������� �������� �� ��������� ��� ���� PurchaseDate: ���� ���������� ������ (������� ����)

if object_id('dbo.Basket', 'U') is not null
	drop table dbo.Basket;

create table dbo.Basket
(
	ID int not null identity
	,ID_SKU int not null
	,ID_Family int not null
	,Quantity numeric(6,3) not null
	,Value money not null
	,PurchaseDate date not null
		constraint DFT_Basket_PurchaseDate default(convert (date, getdate()))
	,DiscountValue money
	,constraint PK_Basket primary key(ID)
	,constraint FK_Basket_SKU foreign key(ID_SKU)
		references dbo.SKU(ID)
	,constraint FK_Basket_Family foreign key(ID_Family)
		references dbo.Family(ID)
	,constraint CHK_qty  CHECK (Quantity > 0)
	,constraint CHK_val  CHECK (Value > 0)
);

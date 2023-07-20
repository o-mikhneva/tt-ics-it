# Задание от ICS-IT

1. Git
    1. Cоздать репозиторий на GitHub
    2. Каждый последующий пункт должен располагаться в отдельной ветке (в ветках не должно быть кода, который не относится к пункту)
2. Создать таблицы (на выходе: файл в репозитории CreateStructure.sql в ветке Tables)
    1. dbo.SKU (ID identity, Code, Name)
        * Ограничение на уникальность поля Code
        * Поле Code вычисляемое: "s" + ID
    2. dbo.Family (ID identity, SurName, BudgetValue)
    3. dbo.Basket (ID identity, ID_SKU (внешний ключ на таблицу dbo.SKU), ID_Family (внешний ключ на таблицу dbo.Family) Quantity, Value, PurchaseDate, DiscountValue)
        * Ограничение, что поле Quantity и Value не могут быть меньше 0
        * Добавить значение по умолчанию для поля PurchaseDate: дата добавления записи (текущая дата)
3. Создать функцию (на выходе: файл в репозитории dbo.udf_GetSKUPrice.sql в ветке Functions)
    1. Входной параметр @ID_SKU
    2. Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле
        * Cумма Value по переданному ID_SKU / сумма Quantity по переданному ID_SKU
    3. На выходе значение типа decimal(18, 2)
4. Создать представление (на выходе: файл в репозитории dbo.vw_SKUPrice в ветке Views)
    1. Возвращает все атрибуты продуктов из таблицы dbo.SKU и расчетный атрибут со стоимостью одного продукта (используя функцию dbo.udf_GetSKUPrice)
5. Создать процедуру (на выходе: файл в репозитории dbo.usp_MakeFamilyPurchase в ветке Procedures)
    1. Входной параметр (@FamilySurName varchar(255)) одно из значений атрибута SurName таблицы dbo.Family
    2. Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике
        * dbo.Family.BudgetValue - SUM(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи
        * При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет
6. Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в ветке Triggers)
    1. Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение в поле DiscountValue для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0

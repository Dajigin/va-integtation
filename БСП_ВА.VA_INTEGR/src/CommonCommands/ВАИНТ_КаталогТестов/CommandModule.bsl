#Область ОбработчикиСобытий
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("НастройкаТестирования", 
								ПредопределенноеЗначение("Перечисление.ВАИНТ_НастройкиТестирования.ПутьККаталогуТестов"));
								
	ОткрытьФорму("РегистрСведений.ВАИНТ_НастройкиТестирования.ФормаЗаписи", ПараметрыОткрытия);
КонецПроцедуры
#КонецОбласти
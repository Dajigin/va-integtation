//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВыражениеВнутреннегоЯзыкаИстинно(Парам01)","ВыражениеВнутреннегоЯзыкаИстинно","И выражение внутреннего языка 'Выражение' Истинно","Позволяет проверить произвольное выражение встроенного языка.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВыражениеВнутреннегоЯзыкаИмеетЗначение(Парам01,Парам02)","ВыражениеВнутреннегоЯзыкаИмеетЗначение","И выражение внутреннего языка 'Выражение' имеет значение 'Значение'","Позволяет проверить произвольное выражение встроенного языка.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюЗначениеВыраженияВПеременную(Парам01,Парам02)","ЯЗапоминаюЗначениеВыраженияВПеременную","И Я запоминаю значение выражения 'ВыражениеВстроенногоЯзыка' в переменную ""ИмяПеременной""","Позволяет сохранить в переменную произвольное выражение встроенного языка. Обращение к созданной переменной в других шагах должно происходить так: $ИмяПеременной$.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально(Парам01,Парам02)","ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально","И Я запоминаю значение выражения 'ВыражениеВстроенногоЯзыка' в переменную ""ИмяПеременной"" глобально","Позволяет сохранить в переменную КонтекстСохраняемый произвольное выражение встроенного языка.","Встроенный язык.Устаревшее");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЗатемЯВыполняюКодВстроенногоЯзыка(ТабПарам)","ЗатемЯВыполняюКодВстроенногоЯзыка","И затем я выполняю код встроенного языка" + Символы.ПС + "	| 'Сообщить(""Hellow world."")' |");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыполняюКодВстроенногоЯзыка(ТабПарам)","ЯВыполняюКодВстроенногоЯзыка","И я выполняю код встроенного языка" + Символы.ПС + """""""bsl" + Символы.ПС + "	Сообщить(""Hellow world."")" + Символы.ПС + """""""","Позволяет выполнить произвольный код на встроенном языке. Код передаётся через таблицу Gherkin.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыполняюКодВстроенногоЯзыкаНаСервере(ТабПарам)","ЯВыполняюКодВстроенногоЯзыкаНаСервере","И я выполняю код встроенного языка на сервере" + Символы.ПС + """""""bsl" + Символы.ПС + "	Сообщить(""Hellow world."")" + Символы.ПС + """""""","Позволяет выполнить произвольный код на встроенном языке на сервере. При этом можно вызвать метод Объект(), чтобы обратиться к объекту VA. Код передаётся через таблицу Gherkin.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыполняюКодВстроенногоЯзыкаНаСервереБезКонтекста(ТабПарам)","ЯВыполняюКодВстроенногоЯзыкаНаСервереБезКонтекста","И я выполняю код встроенного языка на сервере без контекста" + Символы.ПС + """""""bsl" + Символы.ПС + "	Сообщить(""Hellow world."")" + Символы.ПС + """""""","Позволяет выполнить произвольный код на встроенном языке на сервере без контекста. Код передаётся через таблицу Gherkin.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюСтрокуВПеременную(Парам01,Парам02)","ЯЗапоминаюСтрокуВПеременную","И я запоминаю строку ""НужнаяСтрока"" в переменную ""ИмяПеременной""","Запоминает значение строки в переменную.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯУдаляюПеременную(Парам01)","ЯУдаляюПеременную","И я удаляю переменную 'ИмяПеременной'","Удаляет локальную и глобальную переменную с таким именем, если они будут найдены. Если такой переменной, то исключение вызвано не будет.","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюСлучайноеЧислоВПеременную(Парам01)","ЯЗапоминаюСлучайноеЧислоВПеременную", "И Я запоминаю случайное число в переменную ""ИмяПеременной""", "Позволяет сохранить в переменную случайное число.", "Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздаюОбъектВстроенногоЯзыкаКак(Парам01,Парам02)","ЯСоздаюОбъектВстроенногоЯзыкаКак","И я создаю объект встроенного языка ""ИмяОбъекта"" как ""ИмяПеременной""", "Позволяет создать новый экземпляр объекта и сохранить его в переменную. Например - ""СистемнаяИнформация"".", "Встроенный язык");
	
	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
КонецПроцедуры

&НаКлиенте
Функция Контекст() Экспорт
	Возврат Ванесса;
КонецФункции	 

&НаКлиенте
Функция Context() Экспорт
	Возврат Ванесса;
КонецФункции	 

&НаКлиенте
//И выражение внутреннего языка 'Выражение' имеет значение 'Значение'
//@ВыражениеВнутреннегоЯзыкаИмеетЗначение(Парам01,Парам02)
Функция ВыражениеВнутреннегоЯзыкаИмеетЗначение(ПараметрВыражение, ПроверяемоеЗначение) Экспорт
	Выражение = Неопределено;
	ЗначениеВыражения = ВычислитьЗначениеВыражения(ПараметрВыражение, Выражение);
	
	Если ЗначениеВыражения <> ПроверяемоеЗначение Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Выражение <%1> оказалось равно <%2>, а ожидали <%3>.");
		Если Выражение = Неопределено Тогда
			Выражение = ПараметрВыражение;
		КонецЕсли;	 
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Выражение);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ЗначениеВыражения);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%3",Строка(ПроверяемоеЗначение));
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецФункции

&НаКлиенте
Функция ВычислитьЗначениеВыражения(ПараметрВыражение, Выражение)
	ПолучилосьВычислить = Ложь;
	Попытка
		ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(ПараметрВыражение);
		ПолучилосьВычислить = Истина;
	Исключение
		ЗначениеВыражения = ПараметрВыражение;
	КонецПопытки;
	
	Выражение = Неопределено;
	Если НЕ ПолучилосьВычислить Тогда
		Попытка
			ТекстИсключения = Неопределено;
			Выражение = Ванесса.ЗаменитьСлужебныеСимволыВВыраженииДляВычисления(
				Ванесса.ЗначениеПараметраТекущегоСценария(0));
			ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(Выражение, ТекстИсключения);
		Исключение
			ЗначениеВыражения = ПараметрВыражение;
		КонецПопытки;
	КонецЕсли;	 
	
	Возврат ЗначениеВыражения; 
	
КонецФункции	 

&НаКлиенте
//И выражение внутреннего языка "Контекст.КоличествоНачальноеПлюсОдин - Контекст.КоличествоНачальное = 1" Истинно
//@ВыражениеВнутреннегоЯзыкаИстинно(Парам01)
Процедура ВыражениеВнутреннегоЯзыкаИстинно(Знач ПараметрВыражение) Экспорт
	
	Выражение = Неопределено;
	ЗначениеВыражения = ВычислитьЗначениеВыражения(ПараметрВыражение, Выражение);
	
	Если ЗначениеВыражения <> Истина Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Выражение <%1> оказалось равно <%2>, а ожидали <%3>.");
		Если Выражение = Неопределено Тогда
			Выражение = ПараметрВыражение;
		КонецЕсли;	 
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Выражение);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ЗначениеВыражения);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%3",Строка(Истина));
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//И Я запоминаю выражение внутреннего языка "Ванесса.ПолучитьМассивPIDОкон1С().Количество()" в переменную "КоличествоНачальноеПлюсОдинВторойРаз"
//@ЯЗапоминаюЗначениеВыраженияВПеременную(Парам01,Парам02)
Процедура ЯЗапоминаюЗначениеВыраженияВПеременную(Знач ПараметрВыражение, ИмяПеременной) Экспорт
	ПолучилосьВычислить = Ложь;
	Попытка
		ТекстИсключения = Неопределено;
		Выражение = Ванесса.ЗаменитьСлужебныеСимволыВВыраженииДляВычисления(
			Ванесса.ЗначениеПараметраТекущегоСценария(0));
		ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(Выражение, ТекстИсключения);
		ПолучилосьВычислить = Истина;
	Исключение
		ЗначениеВыражения = ПараметрВыражение;
	КонецПопытки;
	
	Если НЕ ПолучилосьВычислить
		ИЛИ Найти(ЗначениеВыражения,"ОбъектКонтекст.") > 0
		ИЛИ Найти(ЗначениеВыражения,"ОбъектКонтекстСохраняемый.") > 0 Тогда
		Попытка
			ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(ПараметрВыражение);
		Исключение
			Ванесса.Отладка(ОписаниеОшибки());
			ЗначениеВыражения = ПараметрВыражение;
		КонецПопытки;
	КонецЕсли;	 
	
	Ванесса.СохранитьЗначениеПеременнойВКонтекст(ИмяПеременной,ЗначениеВыражения);
КонецПроцедуры

&НаКлиенте
//И Я запоминаю выражение внутреннего языка "Ванесса.ПолучитьМассивPIDОкон1С().Количество()" в переменную "КоличествоНачальноеПлюсОдинВторойРаз" глобально
//@ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально(Парам01,Парам02)
Процедура ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально(Знач ПараметрВыражение,ИмяПеременной) Экспорт
	ПолучилосьВычислить = Ложь;
	Попытка
		ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(ПараметрВыражение);
		ПолучилосьВычислить = Истина;
	Исключение
		ЗначениеВыражения = ПараметрВыражение;
	КонецПопытки;
	
	Если НЕ ПолучилосьВычислить Тогда
		Попытка
			ТекстИсключения = Неопределено;
			Выражение = Ванесса.ЗаменитьСлужебныеСимволыВВыраженииДляВычисления(
				Ванесса.ЗначениеПараметраТекущегоСценария(0));
			ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(Выражение, ТекстИсключения);
		Исключение
			ЗначениеВыражения = ПараметрВыражение;
		КонецПопытки;
	КонецЕсли;	 
	
	
	Попытка
		КонтекстСохраняемый.Вставить(ИмяПеременной,ЗначениеВыражения);
	Исключение
		Ванесса.СохранитьЗначениеВКонтекстСохраняемый(ИмяПеременной,ЗначениеВыражения);
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
//И я выполняю код встроенного языка
//@ЯВыполняюКодВстроенногоЯзыка(ТабПарам)
Процедура ЯВыполняюКодВстроенногоЯзыка(ТабПарам) Экспорт
	ЗатемЯВыполняюКодВстроенногоЯзыка(ТабПарам);
КонецПроцедуры

&НаКлиенте
//И затем я выполняю код встроенного языка
//@ЗатемЯВыполняюКодВстроенногоЯзыка(ТабПарам)
Процедура ЗатемЯВыполняюКодВстроенногоЯзыка(ТабПарам) Экспорт
	
	Текст = Ванесса.МногострочнаяСтрокаИзПараметраШага(ТабПарам);
	
	Выполнить(Текст);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЯВыполняюКодВстроенногоЯзыкаНаСервереСервер(Текст)
	Выполнить(Текст);
КонецПроцедуры 

&НаКлиенте
//И я выполняю код встроенного языка на сервере без контекста
//@ЯВыполняюКодВстроенногоЯзыкаНаСервереБезКонтекста(ТабПарам)
Процедура ЯВыполняюКодВстроенногоЯзыкаНаСервереБезКонтекста(ТабПарам) Экспорт
	Текст = Ванесса.МногострочнаяСтрокаИзПараметраШага(ТабПарам);
	
	ЯВыполняюКодВстроенногоЯзыкаНаСервереСервер(Текст);
КонецПроцедуры

&НаКлиенте
//И я выполняю код встроенного языка на сервере
//@ЯВыполняюКодВстроенногоЯзыкаНаСервере(ТабПарам)
Процедура ЯВыполняюКодВстроенногоЯзыкаНаСервере(ТабПарам) Экспорт
	Текст = Ванесса.МногострочнаяСтрокаИзПараметраШага(ТабПарам);
	
	Ванесса.ЯВыполняюКодВстроенногоЯзыкаНаСервереСервер(Текст);
КонецПроцедуры

&НаКлиенте
//И я запоминаю строку "НужнаяСтрока" в переменную "ИмяПеременной"
//@ЯЗапоминаюСтрокуВПеременную(Парам01,Парам02)
Процедура ЯЗапоминаюСтрокуВПеременную(НужнаяСтрока,ИмяПеременной) Экспорт
	Попытка
		Ванесса.СохранитьЗначениеПеременнойВКонтекст(ИмяПеременной,НужнаяСтрока);
	Исключение
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не получилось сохранить строку <%1> в переменную <%2>. Описание ошибки - <%3>");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",НужнаяСтрока);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ИмяПеременной);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%3",ОписаниеОшибки());
		ВызватьИсключение ТекстСообщения;
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура УдалитьПеременнуюИзКонтекстов(ИмяПеременной)
	Попытка
		Если Контекст.Свойство(ИмяПеременной) Тогда
			Контекст.Удалить(ИмяПеременной);
		КонецЕсли;	 
	Исключение
	КонецПопытки;
	
	Попытка
		Если КонтекстСохраняемый.Свойство(ИмяПеременной) Тогда
			КонтекстСохраняемый.Удалить(ИмяПеременной);
		КонецЕсли;	 
	Исключение
	КонецПопытки;
КонецПроцедуры 

&НаКлиенте
//И я удаляю переменную 'ИмяПеременной'
//@ЯУдаляюПеременную(Парам01)
Функция ЯУдаляюПеременную(Знач ИмяПеременной) Экспорт
	ИмяПеременной = Ванесса.УбратьЗапрещенныеСимволыИзКлючаСтруктуры(ИмяПеременной);
	УдалитьПеременнуюИзКонтекстов(ИмяПеременной);
	
	ЗначенияПараметров = Ванесса.ЗначенияПараметровТекущегоСценария();
	ИмяПеременной = Ванесса.УбратьЗапрещенныеСимволыИзКлючаСтруктуры(ЗначенияПараметров[0]);
	УдалитьПеременнуюИзКонтекстов(ИмяПеременной);
КонецФункции

&НаКлиенте
//И я запоминаю случайное число в переменную 'ИмяПеременной'
//@ЯЗапоминаюСлучайноеЧислоВПеременную(Парам01)
Функция ЯЗапоминаюСлучайноеЧислоВПеременную(Знач ИмяПеременной) Экспорт
	
	ГСЧ = Новый ГенераторСлучайныхЧисел();
	СлучайноеЧисло = ГСЧ.СлучайноеЧисло();
	
	ЯЗапоминаюСтрокуВПеременную(СлучайноеЧисло, ИмяПеременной);
	
	Возврат Истина;	
КонецФункции	

&НаКлиенте
//И я создаю объект встроенного языка "ИмяОбъекта" как "ИмяПеременной"
//@ЯСоздаюОбъектВстроенногоЯзыкаКак(Парам01,Парам02)
Функция ЯСоздаюОбъектВстроенногоЯзыкаКак(ИмяОбъекта, ИмяПеременной) Экспорт
	ПромОбъект = Вычислить("Новый " + ИмяОбъекта);
	Ванесса.СохранитьЗначениеПеременнойВКонтекст(ИмяПеременной, ПромОбъект);
КонецФункции

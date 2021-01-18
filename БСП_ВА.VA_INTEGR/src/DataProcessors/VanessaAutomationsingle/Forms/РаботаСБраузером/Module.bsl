#Область ОписаниеПеременных

&НаКлиенте
Перем Ванесса;

&НаКлиенте
Перем ПортБраузера Экспорт;

#КонецОбласти

#Область ЭкспортныеПроцедурыИФункции

// Делает первичную инициализацию модуля.
&НаКлиенте
Функция ИнициализацияФормы(ВладелецФормы) Экспорт
	Ванесса = ВладелецФормы;
	ПортБраузера = 9222;
	Возврат Истина;
КонецФункции

// Ищет расположение браузера в файловой системе
&НаКлиенте
Процедура НайтиБраузерChrome(ИспользоватьОтладку) Экспорт
	
	ПапкиПоиска = Новый Массив;
	ПапкиПоиска.Добавить("%ProgramFiles%");
	ПапкиПоиска.Добавить("%ProgramFiles(x86)%");
	ПапкиПоиска.Добавить("%LocalAppData%");
	
	СисИнфо = Новый СистемнаяИнформация;
	Если СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86 ИЛИ СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86_64 Тогда
		ИмяФайла = "\Google\Chrome\Application\chrome.exe";
		Для каждого ПапкаПоиска Из ПапкиПоиска Цикл
			ProgramFiles = Ванесса.ПолучитьWshShell().ExpandEnvironmentStrings(ПапкаПоиска);
			Файл = Новый Файл(ProgramFiles + ИмяФайла);
			Если Ванесса.ФайлСуществуетКомандаСистемы(Файл.ПолноеИмя) Тогда
				Ванесса.Объект.КомандаЗапускаБраузера = """" + Файл.ПолноеИмя + """"
					+ ?(ИспользоватьОтладку, " --remote-debugging-port=" + Формат(ПортБраузера, "ЧГ="), "");
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// Активизирует окно браузера
&НаКлиенте
Процедура АктивизироватьОкноБраузера(ПолныйЭкран = Ложь) Экспорт
	
	ОкноБраузера = ПолучитьОкноБраузера();
	Если ОкноБраузера <> 0 Тогда
		ВнешняяКомпонента().АктивироватьОкно(ОкноБраузера);
		Если ПолныйЭкран = Истина Тогда
			РаспахнутьПолныйЭкран(ОкноБраузера);
		КонецЕсли;
		ВыполнитьКалибровкуПозицииМыши(ОкноБраузера);
	КонецЕсли;
	
КонецПроцедуры

// Показывает анимацию клика в браузере
&НаКлиенте
Процедура АнимацияКликаВБраузере(ЭлементФормы = Неопределено) Экспорт
	Если НЕ Ванесса.Объект.ЭмулироватьДвиженияМышкиVanessaExt Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Ванесса.Объект.ПодсвечиватьКликМышкиВБраузереVanessaExt Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Ванесса.Объект.ИспользоватьКомпонентуVanessaExt Тогда
		Возврат;
	КонецЕсли;
	
	ВнешняяКомпонента().ПоказатьВизуализациюНажатияМыши();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РаспахнутьПолныйЭкран(ОкноБраузера)
	
	Скрипт = "{
		|let node = document.createElement('div');
		|node.style.position = 'absolute';
		|node.style.height = '100%';
		|node.style.width = '100%';
		|node.style.overflow = 'hidden';
		|node.style.zIndex = 999999;
		|node.addEventListener('click', () => {
		|	document.documentElement.requestFullscreen();
		|	node.remove();
		|});
		|document.body.appendChild(node);
		|}";
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	ВнешняяКомпонента().Пауза(500);
	
	ТекстJSON = ВнешняяКомпонента().ПолучитьРазмерОкна(ОкноБраузера);
	РазмерОкна = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
	X = Окр((РазмерОкна.Left + РазмерОкна.Right) / 2);
	Y = Окр((РазмерОкна.Top + РазмерОкна.Bottom) / 2);
	ВнешняяКомпонента().УстановитьПозициюКурсора(X, Y);
	ВнешняяКомпонента().ЭмуляцияНажатияМыши(0);
	ВнешняяКомпонента().Пауза(500);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКалибровкуПозицииМыши(ОкноБраузера);
	
	Скрипт = "{
		|let node = document.createElement('div');
		|node.style.position = 'absolute';
		|node.style.height = '100%';
		|node.style.width = '100%';
		|node.style.overflow = 'hidden';
		|node.style.zIndex = 999999;
		|node.addEventListener('click', (e) => {
		|	window.VanessaMousePosition = {x: e.pageX, y: e.pageY};
		|	node.remove();
		|});
		|document.body.appendChild(node);
		|}";
	
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	ВнешняяКомпонента().Пауза(500);
	
	ТекстJSON = ВнешняяКомпонента().ПолучитьРазмерОкна(ОкноБраузера);
	РазмерОкна = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
	X = Окр((РазмерОкна.Left + РазмерОкна.Right) / 2);
	Y = Окр((РазмерОкна.Top + РазмерОкна.Bottom) / 2);
	ВнешняяКомпонента().УстановитьПозициюКурсора(X, Y);
	ВнешняяКомпонента().ЭмуляцияНажатияМыши(0);
	ВнешняяКомпонента().Пауза(500);
	
	Скрипт = "{
		|let result = {
		|	x: window.VanessaMousePosition.x,
		|	y: window.VanessaMousePosition.y,
		|	z: window.devicePixelRatio,
		|	w: window.screenLeft,
		|	h: window.screenTop + window.outerHeight - window.innerHeight,
		|};
		|delete window.VanessaMousePosition;
		|JSON.stringify(result);
		|}";
	
	РезультатJSON = Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	ДанныеJSON = Ванесса.ПрочитатьОбъектJSON(РезультатJSON.result.result.value);
	Ванесса.Объект.СмещениеПоГоризонталиДвиженияМышкиVanessaExt = X - (ДанныеJSON.X + ДанныеJSON.W) * ДанныеJSON.Z;
	Ванесса.Объект.СмещениеПоВертикалиДвиженияМышкиVanessaExt = Y - (ДанныеJSON.Y + ДанныеJSON.H) * ДанныеJSON.Z;
	Ванесса.Объект.КоэффициентМасштабированияЭкрана = ДанныеJSON.Z;
	
КонецПроцедуры

&НаКлиенте
Функция ВнешняяКомпонента()
	Возврат Ванесса.ВнешняяКомпонентаДляСкриншотов;
КонецФункции

&НаКлиенте
Функция ПолучитьОкноБраузера()
	
	СтрокаИдентификатор = Строка(Новый УникальныйИдентификатор);
	Скрипт = "{
		|window.VanessaDocumentTitle = document.title; 
		|document.title = '" + СтрокаИдентификатор + "';
		|}";
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	
	ОкноБраузера = 0;
	ЧислоИтераций = 5;
	Пока ОкноБраузера = 0 И ЧислоИтераций > 0 Цикл
		ВнешняяКомпонента().Пауза(500);
		ЧислоИтераций = ЧислоИтераций - 1;
		ТекстJSON = ВнешняяКомпонента().ПолучитьСписокОкон(0);
		МассивОкон = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
		Для Каждого Стр Из МассивОкон Цикл
			ЗаголовокОкна = Неопределено;
			Если Стр.Свойство("Title", ЗаголовокОкна) Тогда
				Если Найти(ЗаголовокОкна, СтрокаИдентификатор) > 0 Тогда
					ОкноБраузера = Стр.Window;
					Прервать;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Скрипт = "{
		|document.title = window.VanessaDocumentTitle; 
		|delete window.VanessaDocumentTitle;
		|}";
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	
	Возврат ОкноБраузера;
	
КонецФункции

&НаКлиенте
Процедура ЗакрытьВкладкиБраузера() Экспорт
	
	HTTPЗапрос = Новый HTTPЗапрос("/json");
	HTTPСоединение = Новый HTTPСоединение("localhost", ПортБраузера, , , , 3);
	Попытка
		HTTPОтвет = HTTPСоединение.Получить(HTTPЗапрос);
	Исключение
		ВызватьИсключение НСтр("ru = 'Отсутствует соединение с браузером'");
	КонецПопытки;
	
	ТекстJSON = HTTPОтвет.ПолучитьТелоКакСтроку();
	ДанныеJSON = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
	Для каждого Элемент Из ДанныеJSON Цикл
		HTTPЗапрос = Новый HTTPЗапрос("/json/close/" + Элемент.id);
		HTTPСоединение.Получить(HTTPЗапрос);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
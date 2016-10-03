﻿
&НаКлиенте
Процедура ТЧЗадачиПередНачаломИзменения(Элемент, Отказ)
	Отказ = Ложь;
	//ПоказатьЗначение(,Элемент.ТекущиеДанные.Задача);
	////Элемент.ЗакончитьРедактированиеСтроки(Истина);
	//Элементы.ТЧЗадачиЗарегистрирована.ЗакончитьРедактированиеСтроки(Ложь);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	
	////ОпределитьОтборНаСервере(пНастройкиКомпоновщика);
	//ОпределитьОтборНаСервере();
	
	
	пНастройкиКомпоновщика = Неопределено;
	
	КлючНастроек = ПолучитьКлючНастроек();
	СохраненныеНастройки = ХранилищеОбщихНастроек.Загрузить(КлючНастроек,КлючНастроек);
	
	Если СохраненныеНастройки <> Неопределено Тогда
		ЗаполнитьТЧНастройкиКолонокНаСервере();	
		//Если СохраненныеНастройки.Свойство("ТЧНастройкиКолонок") Тогда
		//	Объект.ТЧНастройкиКолонок.Загрузить(СохраненныеНастройки.ТЧНастройкиКолонок);
		//Иначе
		//	ЗаполнитьТЧНастройкиКолонокНаСервере();	
		//Конецесли;
		//Если СохраненныеНастройки.Свойство("НастройкиКомпоновщикаХранилище") Тогда
		//	пНастройкиКомпоновщика = СохраненныеНастройки.НастройкиКомпоновщикаХранилище.Получить();
		//Конецесли;		
	Иначе
		ЗаполнитьТЧНастройкиКолонокНаСервере();
	Конецесли;
	
	НастройкиТЧДляАктивацииПервойСтроки = Новый Структура();
	
	ОпределитьОтборНаСервере(пНастройкиКомпоновщика);
	
	ЗаполнитьЗадачиНаСервере();
	УстановитьВидимостьДоступность();
	УстановитьОтборТЧ();	
КонецПроцедуры


&НаСервере
Функция ПолучитьКлючНастроек()
	КлючНастроек = "Обработка.узКанбанДоска";	
	Возврат КлючНастроек;
КонецФункции 

&НаСервере
Процедура ЗаполнитьТЧНастройкиКолонокНаСервере()
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.ЗаполнитьТЧНастройкиКолонок();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры 

&НаСервере
Процедура УстановитьОтборТЧ()
	
	Элементы.ТЧЗадачиОтменена.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.Отменена"));
	Элементы.ТЧЗадачиBacklog.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.Backlog"));
	Элементы.ТЧЗадачиЗарегистрирована.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.Зарегистрирована"));
	Элементы.ТЧЗадачиВПроцессеВыполнения.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.ВПроцессеВыполнения"));
	Элементы.ТЧЗадачиОжидаетОтвета.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.ОжидаетОтвета"));
	Элементы.ТЧЗадачиНаТестировании.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.НаТестированииПоказПользователям"));
	Элементы.ТЧЗадачиОтложена.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.Отложена"));
	Элементы.ТЧЗадачиГотово.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.Готово"));
	Элементы.ТЧЗадачиАрхив.ОтборСтрок = Новый ФиксированнаяСтруктура("Статус", ПредопределенноеЗначение("Справочник.узСтатусыЗадачи.Архив"));

КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность()
	Для каждого СтрокаТЧНастройкиКолонок из Объект.ТЧНастройкиКолонок цикл
		ИмяГруппы = "Группа"+СтрокаТЧНастройкиКолонок.ИмяПредопределенныхДанных;
		Элементы[ИмяГруппы].Видимость = СтрокаТЧНастройкиКолонок.Видимость;
	Конеццикла;
КонецПроцедуры 

&НаСервере
Процедура ЗаполнитьЗадачиНаСервере()
	Объект.АдресВременногоХранилища = ПоместитьВоВременноеХранилище(КомпоновщикНастроекКомпоновкиДанных.Настройки,Новый УникальныйИдентификатор());
	
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.ЗаполнитьЗадачи();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры 

&НаКлиенте
Процедура ТЧЗадачиПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	СменитьСтатусЗадачиНаКлиенте(Элемент,ПараметрыПеретаскивания);
КонецПроцедуры

&НаКлиенте
Процедура СменитьСтатусЗадачиНаКлиенте(Элемент,ПараметрыПеретаскивания)
	//ИмяТЧ = Элемент.Имя;
	//пОтборСтрок = Элементы[ИмяТЧ].ОтборСтрок;
	НовыйСтатус = Элемент.ОтборСтрок.Статус;	
	ДанныеИсточник = ПараметрыПеретаскивания.Значение;
	
	МассивЗадач = Новый Массив();
	Для каждого ДанныеИсточник из ПараметрыПеретаскивания.Значение цикл
		ЗадачаСсылка = ДанныеИсточник.Задача;
		МассивЗадач.Добавить(ЗадачаСсылка);
	Конеццикла;	
	
	ДопПараметры = Новый Структура();
	ДопПараметры.Вставить("НовыйСтатус",НовыйСтатус);
	ДопПараметры.Вставить("МассивЗадач",МассивЗадач);	
	СменитьСтатусЗадачиНаСервере(ДопПараметры);
КонецПроцедуры 

&НаСервере
Процедура СменитьСтатусЗадачиНаСервере(ДопПараметры)
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.СменитьСтатусЗадачи(ДопПараметры);
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры 

&НаКлиенте
Процедура ТЧЗадачиПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)	
	Отказ = Истина;
	ДобавитьНовуюЗадачу(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьНовуюЗадачу(Элемент)
	пСтатус = Элемент.ОтборСтрок.Статус;
	ПараметрыНовойЗадачи = Новый Структура();
	ПараметрыНовойЗадачи.Вставить("Статус",пСтатус);
	ЭлементыОтбора = КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор.Элементы;
	Для каждого ЭлементОтбора из ЭлементыОтбора цикл
		Если НЕ ЭлементОтбора.Использование Тогда
			Продолжить;
		Конецесли;
		Если ЭлементОтбора.ВидСравнения <> ВидСравненияКомпоновкиДанных.Равно Тогда
			Продолжить;
		Конецесли;		
		Если ТипЗнч(ЭлементОтбора) =  Тип("ЭлементОтбораКомпоновкиДанных") Тогда
			ПараметрыНовойЗадачи.Вставить("" + ЭлементОтбора.ЛевоеЗначение,ЭлементОтбора.ПравоеЗначение);	
		Конецесли;
	Конеццикла;
	ДопПараметры = Новый Структура();
	ДопПараметры.Вставить("ТребоватьЗаполнитьРодителя",Истина);
	ДопПараметры.Вставить("ПараметрыНовойЗадачи",ПараметрыНовойЗадачи);
	ОткрытьФорму("Справочник.узЗадачи.Форма.ФормаЭлемента",ДопПараметры);	
КонецПроцедуры 

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "СправочникЗадачаЗаписана" Тогда
		ЗаполнитьЗадачиНаСервере();		
	Конецесли;
КонецПроцедуры

&НаКлиенте
Процедура КомандаНастройки(Команда)
		
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОтключитьОбработчикОжидания("ЗаполнитьЗадачиНаКлиенте");
	ПриЗакрытииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииНаСервере()
	СохранитьНастройки();
КонецПроцедуры

&НаСервере
Процедура СохранитьНастройки()
	НастройкиКомпоновщикаХранилище = Новый ХранилищеЗначения(КомпоновщикНастроекКомпоновкиДанных.Настройки);
	
	КлючНастроек = ПолучитьКлючНастроек();
	ДопПараметры = Новый Структура();
	ДопПараметры.Вставить("ТЧНастройкиКолонок",Объект.ТЧНастройкиКолонок.Выгрузить());
	ДопПараметры.Вставить("НастройкиКомпоновщикаХранилище",НастройкиКомпоновщикаХранилище);
	
	ХранилищеОбщихНастроек.Сохранить(КлючНастроек,КлючНастроек,ДопПараметры);
КонецПроцедуры 

&НаКлиенте
Процедура ГруппаСтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	ВыполнитьДействиеДляАктивнойСтраницы();
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьДействиеДляАктивнойСтраницы()
	пТекущаяСтраница = Элементы.ГруппаСтраницы.ТекущаяСтраница;
	Если пТекущаяСтраница = Элементы.ГруппаКанбанДоска Тогда
		ОбновитьКанбанДоску();
	Конецесли;	
КонецПроцедуры 

&НаКлиенте
Процедура ОбновитьКанбанДоску()
	Объект.АдресВременногоХранилища = ПоместитьВоВременноеХранилище(КомпоновщикНастроекКомпоновкиДанных.Настройки,Новый УникальныйИдентификатор());
	ЗаполнитьЗадачиНаСервере();
	УстановитьВидимостьДоступность();	
	ОчиститьАктивизацииСтрок();
КонецПроцедуры 

&НаКлиенте
Процедура ОчиститьАктивизацииСтрок(ИсключитьИмяТЧ = Неопределено)
	Для каждого НастройкаАктивации из НастройкиТЧДляАктивацииПервойСтроки цикл		
		ИмяТЧ = НастройкаАктивации.Ключ;	
		Если ИмяТЧ = ИсключитьИмяТЧ Тогда
			Продолжить;
		Конецесли;
		Элементы[ИмяТЧ].ВыделенныеСтроки.Очистить();
	Конеццикла;
КонецПроцедуры 

&НаСервере
Функция ОпределитьОтборНаСервере(пНастройкиКомпоновщика = Неопределено) Экспорт
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	МакетСКД = пОбъект.ПолучитьМакет("СхемаКомпоновкиДанных");
	
	АдресВременногоХранилищаМакетаСКД = ПоместитьВоВременноеХранилище(МакетСКД,Новый УникальныйИдентификатор());
	
	ИсточникНастроек = Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресВременногоХранилищаМакетаСКД);
	КомпоновщикНастроекКомпоновкиДанных.Инициализировать(ИсточникНастроек);
	
	Если пНастройкиКомпоновщика = Неопределено Тогда
		КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(МакетСКД.НастройкиПоУмолчанию);
	Иначе
		КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(пНастройкиКомпоновщика);
	Конецесли;
	//ЗначениеВРеквизитФормы(КомпоновщикНастроекКомпоновкиДанных,"КомпоновщикНастроекКомпоновкиДанных");
	//ЗначениеВРеквизитФормы(СправочникОбъект,"Объект");
КонецФункции

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//Элементы.ТЧЗадачиЗарегистрирована.ТекущаяСтрока = -1;
	////Элементы.ТЧЗадачиЗарегистрирована.ТекущиеДанные = Неопределено;
	//Элементы.ТЧЗадачиЗарегистрирована.ТекущийЭлемент = -1;
	Элементы.ТЧЗадачиЗарегистрирована.ВыделенныеСтроки.Очистить();	
	ПодключитьОбработчикОжидания("ЗаполнитьЗадачиНаКлиенте", 180);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьЗадачиНаКлиенте()
	ОбновитьКанбанДоску();
КонецПроцедуры 

&НаКлиенте
Процедура КомандаОбновить(Команда)
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.ГруппаКанбанДоска;
	ЗаполнитьЗадачиНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура КомандаУстановитьСтандартныеНастройки(Команда)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ТЧЗадачиПриАктивизацииЯчейки(Элемент)
	ИмяТЧ = Элемент.Имя;
	ИмяАктивнойТЧ = ИмяТЧ; 
	ОчиститьАктивизацииСтрок(ИмяТЧ);
	Если НЕ НастройкиТЧДляАктивацииПервойСтроки.Свойство(ИмяТЧ) Тогда
		Элемент.ВыделенныеСтроки.Очистить();
		НастройкиТЧДляАктивацииПервойСтроки.Вставить(ИмяТЧ,"Истина");
	Конецесли;
КонецПроцедуры

&НаКлиенте
Процедура ТЧЗадачиАнализПриАктивизацииЯчейки(Элемент)
	
КонецПроцедуры

&НаКлиенте
Процедура ТЧЗадачиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПоказатьЗначение(,Элемент.ТекущиеДанные.Задача);	
КонецПроцедуры

&НаКлиенте
Процедура КомандаДобавитьВСпринт(Команда)
	ДобавитьУбратьВСпринтНаКлиенте(1);	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьУбратьВСпринтНаКлиенте(КодОперации)
	СтрокаТЧ = Элементы[ИмяАктивнойТЧ].ТекущиеДанные;	
	Если СтрокаТЧ = Неопределено тогда
		Сообщить("Выберите задачи, которые хотите добавить в спринт");
		Возврат;	
	Конецесли;	
	МассивВыделенныхСтрок = Элементы[ИмяАктивнойТЧ].ВыделенныеСтроки;
	Если МассивВыделенныхСтрок.Количество() = 0 Тогда
		Сообщить("Выберите задачи, которые хотите добавить в спринт");
		Возврат;
	Конецесли;	
	РезультатФункции = ДобавитьУбратьВСпринтНаСервере(КодОперации,МассивВыделенныхСтрок);
	КомандаДобавитьУбратьВыполнена = РезультатФункции.КомандаДобавитьУбратьВыполнена;
	Если НЕ КомандаДобавитьУбратьВыполнена Тогда
		Если РезультатФункции.Свойство("НеобходимоВыбратьСпринт") Тогда
			ДополнительныеПараметры = Новый Структура();
			ДополнительныеПараметры.Вставить("МассивВыделенныхСтрок",МассивВыделенныхСтрок);
			ОповещениеОЗакрытии = Новый ОписаниеОповещения("ОбработатьВыборСпринта", ЭтаФорма, ДополнительныеПараметры);
			
		    пОтбор = Новый Структура("СпринтЗавершен", Ложь);
			ПараметрыОткрытияФормы = Новый Структура("Отбор", пОтбор);   
			ОткрытьФорму("Справочник.узСпринты.Форма.ФормаВыбора",ПараметрыОткрытияФормы,,,,,ОповещениеОЗакрытии);	
		Конецесли;
	Конецесли;
	ДобавитьУбратьВСпринтНаКлиентеОбработатьРезультатФункции(РезультатФункции);
КонецПроцедуры 

&НаКлиенте
Процедура ДобавитьУбратьВСпринтНаКлиентеОбработатьРезультатФункции(РезультатФункции)
	Если РезультатФункции.Свойство("МассивСообщений") Тогда
		МассивСообщений = РезультатФункции.МассивСообщений;
		Для каждого ЭлМассиваСообщения из МассивСообщений цикл
			Сообщить(ЭлМассиваСообщения);		 
		Конеццикла;		
	Конецесли;
	ЗаполнитьЗадачиНаСервере();	
КонецПроцедуры 

&НаКлиенте
Процедура ОбработатьВыборСпринта(РезультатЗакрытия, ДопПараметры) Экспорт
	Если РезультатЗакрытия = Неопределено Тогда
		Возврат;
	Конецесли;
	пСпринт = РезультатЗакрытия;
	МассивВыделенныхСтрок = ДопПараметры.МассивВыделенныхСтрок;
	РезультатФункции = ДобавитьУбратьВСпринтНаСервере(1,МассивВыделенныхСтрок,пСпринт);
	ДобавитьУбратьВСпринтНаКлиентеОбработатьРезультатФункции(РезультатФункции);
КонецПроцедуры 


&НаСервере
Функция ДобавитьУбратьВСпринтНаСервере(КодОперации,МассивВыделенныхСтрок,пСпринт = Неопределено)
	МассивЗадач = ПолучитьМассивЗадачПоВыделеннымСтрокам(МассивВыделенныхСтрок);
	РезультатФункцииТекущийСпринт = Справочники.узСпринты.ПолучитьТекущийСпринт();	
	ТекстОшибки	= РезультатФункцииТекущийСпринт.ТекстОшибки;
	Если ЗначениеЗаполнено(ТекстОшибки) Тогда
		МассивСообщений = Новый Массив(); 
		МассивСообщений.Добавить(ТекстОшибки);
		
		РезультатФункции = Новый Структура();
		РезультатФункции.Вставить("КомандаДобавитьУбратьВыполнена",Ложь);
		РезультатФункции.Вставить("МассивСообщений",МассивСообщений);
		Возврат РезультатФункции;		
	Конецесли;
	
	Если КодОперации = -1 Тогда
		РезультатФункции = ДобавитьУбратьВСпринтЗадачи(КодОперации,Неопределено,МассивЗадач);
		Возврат РезультатФункции;			
	Конецесли;
	
	Если ЗначениеЗаполнено(пСпринт) Тогда
		РезультатФункции = ДобавитьУбратьВСпринтЗадачи(КодОперации,пСпринт,МассивЗадач);
		Возврат РезультатФункции;
	Конецесли;;		
	
	Только1АктивныйСпринт = РезультатФункцииТекущийСпринт.Только1АктивныйСпринт;	
	Если Только1АктивныйСпринт Тогда		
		пСпринт = РезультатФункцииТекущийСпринт.Спринт;
		РезультатФункции = ДобавитьУбратьВСпринтЗадачи(КодОперации,пСпринт,МассивЗадач);
		Возврат РезультатФункции;
	Конецесли;
	
	РезультатФункции = Новый Структура();
	РезультатФункции.Вставить("КомандаДобавитьУбратьВыполнена",Ложь);
	РезультатФункции.Вставить("НеобходимоВыбратьСпринт",Истина);
	Возврат РезультатФункции;
	
КонецФункции

&НаСервере
Функция ПолучитьМассивЗадачПоВыделеннымСтрокам(МассивВыделенныхСтрок)
	МассивЗадач = Новый Массив();
	Для каждого ЭлМассиваВыделенныхСтрок из МассивВыделенныхСтрок цикл
		ИдентификаторСтроки = ЭлМассиваВыделенныхСтрок;
		СтрокаТЧЗадачи = Объект.ТЧЗадачи.НайтиПоИдентификатору(ИдентификаторСтроки);
		МассивЗадач.Добавить(СтрокаТЧЗадачи.Задача);
	Конеццикла;	
	Возврат МассивЗадач;
КонецФункции

&НаСервере
Функция ДобавитьУбратьВСпринтЗадачи(КодОперации,пСпринт,МассивЗадач)
	ЭтоДобавление = КодОперации = 1;
	ЭтоУдаление = КодОперации = -1;
	
	РезультатФункции = Новый Структура();
	МассивСообщений = Новый Массив();
	Для каждого ЭлМассиваЗадач из МассивЗадач цикл
		пЗадачаСсылка = ЭлМассиваЗадач;
		Если ЭтоДобавление Тогда
			Если пЗадачаСсылка.Спринт <> пСпринт Тогда
				ЗадачаОбъект = пЗадачаСсылка.ПолучитьОбъект();
				ЗадачаОбъект.Спринт = пСпринт;
				ЗадачаОбъект.Записать();
				МассивСообщений.Добавить("Добавлена"
					+" в спринт ["+пСпринт+"] "
					+" задача [#"+пЗадачаСсылка.Код+" "+пЗадачаСсылка+"]");
			Иначе
				МассивСообщений.Добавить("Уже указана"
					+" в спринте ["+пСпринт+"] "
					+" задача [#"+пЗадачаСсылка.Код+" "+пЗадачаСсылка+"]");				
			Конецесли;
		ИначеЕсли ЭтоУдаление Тогда
			пСпринт = пЗадачаСсылка.Спринт;
			Если ЗначениеЗаполнено(пСпринт) Тогда
				ЗадачаОбъект = пЗадачаСсылка.ПолучитьОбъект();
				ЗадачаОбъект.Спринт = Неопределено;
				ЗадачаОбъект.Записать();
				МассивСообщений.Добавить("Убрана"
					+" из спринта ["+пСпринт+"] "
					+" задача [#"+пЗадачаСсылка.Код+" "+пЗадачаСсылка+"]");					
			Иначе
				МассивСообщений.Добавить("Не указана в спринте"
					+" задача [#"+пЗадачаСсылка.Код+" "+пЗадачаСсылка+"]");					
			Конецесли;	
		Иначе
			ВызватьИсключение "Неизвестный код операции " + КодОперации;
		КонецЕсли;
	Конеццикла;	
	РезультатФункции.Вставить("МассивСообщений",МассивСообщений);
	РезультатФункции.Вставить("КомандаДобавитьУбратьВыполнена",Истина);
	Возврат РезультатФункции;
КонецФункции

&НаКлиенте
Процедура КомандаУбратьИзСпринта(Команда)
	ДобавитьУбратьВСпринтНаКлиенте(-1);
КонецПроцедуры

// BSLLS:ExportVariables-off

#Использовать strings

#Область ОписаниеПеременных

// ВебЗапрос - Проинициализированный объект запроса
Перем Запрос;
// TCPСоединение - Соединение генерируемое сервером, используется для ответа на запрос
Перем Соединение;
// Соответствие - Заголовки ответа
Перем Заголовки;
// Строка - Тип http запроса (GET/POST/PUD и т.д)
Перем ТипЗапроса;
// Строка - Версия протокола http
Перем ВерсияHTTP;
// Строка, ДвоичныеДанные - Данне для отправки
Перем ТелоОтвета;

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриСозданииОбъекта(Знач ВебЗапрос)
	
	Запрос = ВебЗапрос;

	ОсновныеДанные = Запрос.ПолучитьОсновныеДанные();
	Соединение = ОсновныеДанные.Соединение;
	ТипЗапроса = ОсновныеДанные.ТипЗапроса;
	ВерсияHTTP = ОсновныеДанные.ВерсияHTTP;
	Заголовки = Новый Соответствие();	
	ТелоОтвета = "";
		
	// Server: Apache
	// X-Backend-Server: developer1.webapp.scl3.mozilla.com
	// Vary: Accept,Cookie, Accept-Encoding
	// Content-Type: text/html; charset=utf-8
	// Date: Wed, 07 Sep 2016 00:11:31 GMT
	// Keep-Alive: timeout=5, max=999
	// Connection: Keep-Alive
	// X-Frame-Options: DENY
	// Allow: GET
	// X-Cache-Info: caching
	// Content-Length: 41823

	Заголовки.Вставить("Server", "Oscript");
	Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	Заголовки.Вставить("Allow", ТипЗапроса);
	// Заголовки.Вставить("Content-Length", 0);

КонецПроцедуры

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Выполняет ответ на запрос и закрывает соединение
//
// Параметры:
//   КодСостояния - Число - Поддерживаемый код состояния http ответа
//
Процедура Отправить(КодСостояния) Экспорт

	ДанныеОтветаСтрокой = ВерсияHTTP + " " + Строка(КодСостояния) + " OK";
	// Заголовки.Вставить("Content-Length", СтрДлина(ТелоОтвета));

	Для каждого Элемент Из Заголовки Цикл
		ДанныеОтветаСтрокой = ДанныеОтветаСтрокой + Символы.ПС + Элемент.Ключ + ": " + Элемент.Значение;
	КонецЦикла;

	ДанныеОтветаСтрокой = ДанныеОтветаСтрокой + Символы.ПС + Символы.ПС + "<h1>Goood</h1>";

	ДвоичныеДанныеОтвета = ПолучитьДвоичныеДанныеИзСтроки(ДанныеОтветаСтрокой, "utf-8");

	Соединение.ОтправитьДвоичныеДанные(ДвоичныеДанныеОтвета);
	Приостановить(50);
	Соединение.Закрыть();

КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

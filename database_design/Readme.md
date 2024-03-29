## Пример бизнес-задачи, которая решает база данных (БД) broker
* База данных нужна для хранения словарей и транзакций для осуществления брокерской деятельности;
* Для покупки/продажи ценных бумаг эмитентов (акции, облигации, фьючерсы).

## Описание сущностей БД
## bill_of_users - таблица счетов пользователей;
  * id - идентификатор счёта
  * user_id - идентификатор пользователя
  * cash - деньги или счёт
  * currency_id - валюта счёта

## bounds - таблица облигаций
  * id - Идентификатор облигации
  * simbol - Обозначение эмитента
  * name_of_the_issuer - Название эмитента
  * info_about_issuer - Сводка об эмитенте
  * maturity_date - Дата погашения облигации
  * profitability - Доходность
  * market_id -  Идентификатор типа рынка

## currencys - таблица валют
  * id - Идентификатор валюты
  * symbol - Обозначение валюты
  * abbreviation - Аббревиатура
  * description - Описание валюты

## deals - таблица сделок с ценными бумагами
  * id - Идентификатор сделки
  * user_id - Идентификатор пользователя
  * type_of_bid_id - Тип заявки
  * issuer_id - Идентификатор эмитента
  * deal - Сделка на покупку или продажу
  * quantity - Количество
  * price - Цена сделки
  * currency_id - Идентификатор валюты
  * created_at - Время совершения сделки
  * closed - Статус сделки (закрыта или нет)

## invest_profiles - таблица инвестиционнных профилей
  * id - Идентификатор инвестиционннго профиля
  * name_profile - Название инвестиционного профиля
  * description - Описание инвестиционного профиля

## issuers - таблица эмитентов
  * id - Идентификатор эмитента
  * ticker_symbol - Обозначение эмитента
  * name_of_the_issuer - Название эмитента
  * info_about_issuer - Сводка об эмитенте
  * market_id - Тип рынка (российский, зарубежный)
  * price - Текущая цена

## markets - таблица типа рынка
  * id - Идентификатор рынка
  * type_market - Тип рынка (российский, зарубежный)

## type_of_bids - таблица типов заявок
  * id - Идентификатор типа заявки
  * types - Тип заявки
  * description - Описание заявки

## user_profiles - таблица профилей пользователей
  * id - Идентификатор профиля пользователя 
  * user_id - Идентификатор пользователя
  * login - Логин пользователя
  * password_hash - Хэш пароля
  * phone - Номер телефона
  * email - e-mail
  * number_of_contract - Номер договора
  * date_of_contract - Дата договора
  * brokerage_account - Брокерский счёт
  * individual_investment_account - Индивидкальный инвестиционный счёт (ИИС)
  * invest_profile_id - Инвистиционный профиль
  * qualifying_investor_status - Квалификационный статус инвестора

## users - таблица пользователей
  * id - Идентификатор пользователя
  * firstname - Имя
  * lastname - Фамилия
  * patronymic - Отчество
  * birthday - Дата рождения
  * gender - Пол
  * citizenship - Гражданство
  * created_at - Дата создания
  * updated_at - Дата изменения



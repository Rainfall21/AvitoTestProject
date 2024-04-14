# Avito Test Project
Проблем с заданием не возникло, кроме того, что iTunesApi документация оставляет желать лучшего, как по мне. 
Единственная проблема связана с ограничением времени с учетом основной работы, поэтому не весь функционал успел реализовать в такие сжатые сроки, несмотря на то, что были определенные идеи. А также "совместимость" с другими версиями iPhone (хардкод переменные)
В целях успеть написать больше функционала также пострадала визуальная составляющая.


# Тестовое задание для стажёра iOS
Написано приложение iOS для поиска контента, которое будет состоит из двух экранов:
1. Экрана поиска медиа-контента
2. Экрана с детальной информацией, который отображается после нажатия на элемент из результатов поиска
## Реализация
1. При реализации  использовано [iTunes Search API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html#//apple_ref/doc/uid/TP40017632-CH3-SW1)
### Экран поиска
1. Отображает строку ввода поискового запроса
2. Сохраняет историю поиска (до пяти последних запросов)
3. В момент начала ввода отображаются элементы-подсказки с ранее введенными значениями. По мере ввода символов подсказки фильтруются по вхождению без учета регистра.
4. Поисковый запрос выполняется по завершении ввода при помощи элементов управления клавиатуры и использует формат `https://itunes.apple.com/search?key-value-params`
5. Результаты поиска представлены на экране в виде «плиток», расположенных в два столбца (по умолчанию limit = 30)
6. В результатах поиска поддерживаются для отображения как минимум двух типов медиаконтента (например, `movie` и `audiobook`).  В каждом элементе поисковой выдачи отображена его принадлежность к типу, превью-изображение (artwork, если доступно) и название.  Помимо этого элементы отображают краткую информацию, относящуюся к соответствующему типу контента (имя исполнителя, длительность, цена, рейтинг и т.п.) — на ваше усмотрение
7. С экрана поиска открывается экран детальной информации по нажатию на элемент поисковой выдачи.
## Экран с детальной информацией
### Отображает детальную информацию о медиа-контенте:
1. Изображение для контента
2. Название материала
3. Имя автора материала
4. Тип контента 
6. Описание
### Требования к коду
1. Приложение написано на языке Swift, без использования сторонних библиотек
2. Пользовательский интерфейс полностью реализован кодом с использованием UIKit (без SwiftUI), с использованием MVC архитектуры. Минимальная версия iOS - 13.0. Для запуска проекта необходимо его клонировать и запустить в xcode. Все симуляции проделаны на iPhone 15 pro
3. Для выполнения сетевых запросов используется `URLSession`

# hsse_cat_tinder

Проект КотоТиндер представляет собой приложение по просмотру 'анкет' котов разных пород. Анкеты можно лайкать или дизлайкать, как с помощью свайпов, так и с помощью отдельных кнопок. Также можно просмотреть список ранее лайкнутых котов.

## Структура 

- `lib/data` -- Работа с данными
- `lib/domain` -- Доменный слой (бизнес-логика)
- `lib/presentation` -- Слой представления (UI + логика отображения)
- `di.dart` -- Подключение зависимостей
- `main.dart` -- Запуск приложения


## Фичи
- Реализована аватарка для приложения через пакет `flutter_launcher_icons`
- Реализована карточка кота, которую можно свапать вправо (лайк) и влево (дизлайк) через пакет `flutter_card_swiper`. Так же можно просто нажать на кнопки лайка и дизлайка. Кнопки сделаны через `StatelessWidget`
- Код отформатирован с помощь `dart format`
- Подключен и используется `flutter_lint` (в pubspec.yaml и analysis_options.yaml)
- Команда `flutter analyze` выполняется успешно без проблем
- Зависимости подключаются с помощью `get_it` в `di.dart`
- Экран лайкнутых котиков отображает список с изображением, породой и датой лайка. На этом экране возможна фильтрация по породе. Есть возможность удаления карточки из списка.
- При длительной загрузке приложение показывает `progress bar` через `CircularProgressIndicator`.
- Использовал `AlertDialog` для отображения ошибки сети.
- Управление состоянием через `Cubit` для всех экранов. 

## Интерфейс
<img src="https://github.com/user-attachments/assets/1a9b5ac9-8935-41b7-8607-0388c95b371d" width="200" height="480">
<img src="https://github.com/user-attachments/assets/8260b487-dcb1-4d4b-b646-61c8c596b9e6" width="200" height="480">
<img src="https://github.com/user-attachments/assets/854dc1c6-0e8b-4602-bb48-94946795866c" width="200" height="480">
<img src="https://github.com/user-attachments/assets/0db444d4-27e3-49b0-96fe-614a015525b2" width="200" height="480">
<img src="https://github.com/user-attachments/assets/535ec530-ca8b-4e68-be3d-606e95173945" width="200" height="480">
<img src="https://github.com/user-attachments/assets/491fb595-524d-4df5-b3b3-58b166481e52" width="200" height="480">
<img src="https://github.com/user-attachments/assets/c6f8dc96-f6a3-4280-b667-af89b9b1f627" width="200" height="480">


## [Ссылка на apk первой версии](https://github.com/Xrander24/Flutter_HSSE_2025_HW/raw/refs/heads/main/app-release.apk)
## [Cсылка на apk второй версии](https://github.com/Xrander24/Flutter_HSSE_2025_HW/raw/refs/heads/main/app-release_2.0.apk)

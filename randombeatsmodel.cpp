#include "randombeatsmodel.h"
#include "databasetracks.h"

RandomBeatsModel::RandomBeatsModel(QObject *parent) : QSqlQueryModel(parent) {
    this->updateModel(0);
}

QVariant RandomBeatsModel::data(const QModelIndex & index, int role) const {
    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаем индекс с помощью новоиспеченного ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);
    /* И с помощью уже метода data() базового класса
* берем данные для таблицы из модели
* */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> RandomBeatsModel::roleNames() const {
    /* Сохраняем в хеш-таблицу названия ролей
* по их номеру
* */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id_db";
    roles[TitleRole] = "Title";
    roles[AuthorRole] = "Author";
    roles[timeRole] = "TimeSec";
    roles[coverRole] = "coverURL";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void RandomBeatsModel::updateModel(int style) {
    // Обновление производится SQL-запросом к базе данных
    //this->setQuery("SELECT id, " TABLE_TITLE ", " TABLE_AUTHOR ", "
    //             TABLE_TIME " FROM " TABLE);
    this->setQuery("SELECT * FROM " TABLE " ORDER BY RANDOM() LIMIT 5");

}

// Получение id из строки в модели представления данных
int RandomBeatsModel::getId(int row) {
    return this->data(this->index(row, 0), IdRole).toInt();
}

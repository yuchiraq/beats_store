#include "searchlistmodel.h"
#include "databasetracks.h"

searchListModel::searchListModel(QObject *parent) : QSqlQueryModel(parent) {
    this->updateModel("");
}

QVariant searchListModel::data(const QModelIndex & index, int role) const {
    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаем индекс с помощью новоиспеченного ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);
    /* И с помощью уже метода data() базового класса
* берем данные для таблицы из модели
* */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> searchListModel::roleNames() const {
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
void searchListModel::updateModel(QString request) {
    // Обновление производится SQL-запросом к базе данных
    this->setQuery("SELECT * FROM " TABLE " WHERE " TABLE_TITLE " LIKE '%" + request + "%'");
}

// Получение id из строки в модели представления данных
int searchListModel::getId(int row) {
    return this->data(this->index(row, 0), IdRole).toInt();
}

#include "lastrealiseslistModel.h"
#include "databasetracks.h"

LastRealisesListModel::LastRealisesListModel(QObject *parent) : QSqlQueryModel(parent) {
    this->updateModel(0);
}

QVariant LastRealisesListModel::data(const QModelIndex & index, int role) const {
    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаем индекс с помощью новоиспеченного ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);
    /* И с помощью уже метода data() базового класса
* берем данные для таблицы из модели
* */
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> LastRealisesListModel::roleNames() const {
    /* Сохраняем в хеш-таблицу названия ролей
* по их номеру
* */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id_db";
    roles[TitleRole] = "Title";
    roles[AuthorRole] = "Author";
    roles[timeRole] = "TimeSec";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void LastRealisesListModel::updateModel(int type) {
    // Обновление производится SQL-запросом к базе данных
    //this->setQuery("SELECT id, " TABLE_TITLE ", " TABLE_AUTHOR ", "
    //             TABLE_TIME " FROM " TABLE);
    if(type == 0) {
        this->setQuery("SELECT * FROM " TABLE " ORDER BY id ASC");
    } else if (type == 1) {
        this->setQuery("SELECT * FROM " TABLE " ORDER BY id DESC");
    } else if (type == 2) {
        this->setQuery("SELECT * FROM " TABLE " ORDER BY " TABLE_TITLE);
    }
}

// Получение id из строки в модели представления данных
int LastRealisesListModel::getId(int row) {
    return this->data(this->index(row, 0), IdRole).toInt();
}

#include "functionsdatamodel.h"

functionsDataModel::functionsDataModel(QObject *parent) : QSqlQueryModel(parent) {
    this->updateModel(0);
}

QVariant functionsDataModel::data(const QModelIndex & index, int role) const {
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> functionsDataModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id_db";
    roles[TitleRole] = "Title";
    roles[AuthorRole] = "Author";
    roles[AlbumRole] = "Album";
    roles[timeRole] = "TimeSec";
    roles[bpmRole] = "BPM";

    return roles;
}

void functionsDataModel::updateModel(int id) {
    //QString sql = QString("SELECT id, title, author_id, album_id, duration, bpm FROM " TABLE " WHERE id = '%1'").arg(id);
return;
    //this->setQuery(sql);
}

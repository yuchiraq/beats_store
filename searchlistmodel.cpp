#include "searchlistmodel.h"


searchListModel::searchListModel(QObject *parent) : QAbstractListModel(parent) {
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
    return QAbstractListModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> searchListModel::roleNames() const {
    /* Сохраняем в хеш-таблицу названия ролей
* по их номеру
* */
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id_db";
    return roles;
}

// Метод обновления таблицы в модели представления данных
void searchListModel::updateModel(QString title) {
    // Обновление производится SQL-запросом к базе данных
    QEventLoop eventloop;

    QString url = "http://" + host + port + "/tracks/search?title=" + title;

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest request((QUrl(url)));

    reply = manager.get(request);
    eventloop.exec();

    if(reply->error() == QNetworkReply::NoError) {
        qDebug() << "NO EROOR";



        QString str = QString(reply->readAll());

        QStringList *replyList = new QStringList(QString(str).split("|||"));

        delete reply;

        //this->setItemData({"model", QVariant::fromValue(replyList)});

        qDebug() << "connected = true";
        return ;
    }else {
        qDebug() << "ERROR" << reply->error() << QUrl();

        qDebug() << "connected = false";
        delete reply;
        return ;
    }



    return ;
}

// Получение id из строки в модели представления данных
/*int searchListModel::getId(int row) {
    return this->data(this->index(row, 0), IdRole).toInt();
}*/

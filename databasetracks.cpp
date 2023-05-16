#include "databasetracks.h"

DataBaseTracks::DataBaseTracks(QObject *parent)
    : QObject{parent} {
}

void DataBaseTracks::connectToDataBase() {
    /* Перед подключением к базе данных производим проверку на ее
существование.
* В зависимости от результата производим открытие базы данных или ее
восстановление
* */
    connected = false;
    if(!QFile(DATABASE_NAME).exists()){
        qDebug() << "restore";
        this->restoreDataBase();
    } else {
        qDebug() << "OPEN";
        this->openDataBase();
    }
}

bool DataBaseTracks::restoreDataBase() {
    // Если база данных открылась ...
    if(this->openDataBase()){
        // Производим восстановление базы данных
        qDebug() << "удалось восстановить базу данных";
        return this->createTable();
        qDebug() << "удалось восстановить базу данных";
    } else {
        qDebug() << "Не удалось восстаноeventloop.exec();вить базу данных";
        return false;
    }
    return false;
}

bool DataBaseTracks::openDataBase() {
    /* База данных открывается по заданному пути
* и имени базы данных, если она существует
* */
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName(DATABASE_NAME);

    //    db = QSqlDatabase::addDatabase("QMYSQL");
    //    db.setHostName(host);
    //    db.setPort(DATABASE_PORT);
    //    db.setUserName(DATABASE_USER);
    //    db.setPassword(DATABASE_PASS);
    //    db.setDatabaseName(DATABASE_NAME);

    if(db.open()){
        qDebug() << "DB connected";
        createTable();
        return true;
    } else {
        qDebug() << "DB disconnected";
        return false;
    }
}

void DataBaseTracks::closeDataBase() {
    db.close();
}

bool DataBaseTracks::createTable() {
    /* В данном случае используется формирование сырого SQL-запроса
* с последующим его выполнением
* */

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QEventLoop eventloop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("http://" + this->host + this->port + "/")));
    reply = manager.get(req);
    eventloop.exec();

    if(QString(reply->readAll()) != "availible"){
        qDebug() << "connected = true";
        connected = true;
        return false;
    }

    deleteData();
    qDebug() << "START";
    QSqlQuery query;
    if(!query.exec( "CREATE TABLE " TABLE " ("
                    "id INTEGER, "
                    TABLE_TITLE " VARCHAR(255) NOT NULL,"
                    TABLE_AUTHOR " INTEGER NOT NULL,"
                    TABLE_TIME " INTEGER NOT NULL"
                    " )"
                    ))
    {
        qDebug() << "DataBase: error of create " << TABLE;
        qDebug() << query.lastError().text();
    }

    insertData();
    return true;

}

bool DataBaseTracks::insertData(){

    QEventLoop eventloop;

    QString url = "http://" + host + port + "/lastRealises";

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest request((QUrl(url)));

    reply = manager.get(request);
    eventloop.exec();

    if(reply->error() == QNetworkReply::NoError) {
        qDebug() << "NO EROOR";



        QString str = QString(reply->readAll());

        QStringList *replyList = new QStringList(QString(str).split(divider));


        QSqlQuery query;
        qDebug() << *replyList << "str = " << str;



        foreach (QString idStr, *replyList) {

            qDebug() << "GET DATA FOR " << idStr;
            url = "http://" + host + port + "/getDataTrack?ID=" + idStr;

            reply = manager.get(QNetworkRequest(QUrl(url)));
            eventloop.exec();

            if(reply->error() == QNetworkReply::NoError) {
                str = QString(reply->readAll());

                QStringList replyData = str.split(divider);

                qDebug() << "GOT " << replyData[0] << replyData[1] << replyData[2] << replyData[3];
                query.prepare("INSERT INTO " TABLE " ( id, " TABLE_TITLE ", " TABLE_AUTHOR ", " TABLE_TIME ") VALUES (:id, :title, :author, :time)");
                query.bindValue(":id", replyData[0].toInt());
                query.bindValue(":title", replyData[1]);
                query.bindValue(":author", replyData[2].toInt());
                query.bindValue(":time", replyData[3].toInt());

                if(!query.exec()){
                    qDebug() << query.lastQuery();
                    qDebug() << "error insert into " << TABLE;
                    qDebug() << query.lastError().text();
                }
            }

        }
        delete reply;
        connected = true;
        qDebug() << "connected = true";
        return true;
    }else {
        qDebug() << "ERROR" << reply->error() << QUrl();
        connected = true;
        qDebug() << "connected = true";
        delete reply;
        return false;
    }

    qDebug() << showDB();

    return false;
}

QString DataBaseTracks::showDB() {
    QString answer = "";
    QSqlQuery query;

    query.exec("SELECT * FROM " TABLE);
    while (query.next()) {
        answer += query.value(0).toString();
        answer += query.value(1).toString();
        answer += " & ";
    }
    return answer;
}

int DataBaseTracks::getQuantity() {
    int quantity = 0;
    QSqlQuery query;

    query.exec("SELECT * FROM " TABLE);
    while (query.next()) {
        quantity++;
    }
    return quantity;
}
void DataBaseTracks::deleteData() {
    QSqlQuery query;
    // Удаление производим по id записи, который передается в качестве аргумента функции
    query.exec("DROP TABLE " TABLE);
    //createTable();
}

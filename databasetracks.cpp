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
    if(!QFile(DATABASE_NAME).exists()){
        this->restoreDataBase();
    } else {
        this->openDataBase();
    }
}

bool DataBaseTracks::restoreDataBase() {
    // Если база данных открылась ...
    if(this->openDataBase()){
        // Производим восстановление базы данных
        return (this->createTable()) ? true : false;
    } else {
        qDebug() << "Не удалось восстановить базу данных";
        return false;
    }
    return false;
}

bool DataBaseTracks::openDataBase() {
    /* База данных открывается по заданному пути
* и имени базы данных, если она существует
* */
    db = QSqlDatabase::addDatabase("QPSQL");
    db.setHostName(DATABASE_HOSTNAME);
    db.setPort(DATABASE_PORT);
    db.setUserName(DATABASE_NAME);
    db.setPassword(DATABASE_PASS);
    db.setDatabaseName(DATABASE_NAME);

    if(db.open()){
        qDebug() << "CONNECT!!!" << QSqlDatabase::drivers();
        return true;
    } else {
        qDebug() << "NO CONNECT!!!((((" << QSqlDatabase::drivers();
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
    QSqlQuery query;
    if(!query.exec( "CREATE TABLE " TABLE " ("
                                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                                    TABLE_TITLE " VARCHAR(255) NOT NULL,"
                                    TABLE_AUTHOR " VARCHAR(255) NOT NULL,"
                                    TABLE_TIME " int NOT NULL,"
                                    //TABLE_COVER " VARCHAR(255)"
                                    " )"
                                    ))
    {
        qDebug() << "DataBase: error of create " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBaseTracks::inserIntoTable(const QVariantList &data) {

    /* Запрос SQL формируется из QVariantList,
* в который передаются данные для вставки в таблицу.
* */
    QSqlQuery query;
    /* В начале SQL запрос формируется с ключами,
* которые потом связываются методом bindValue
* для подстановки данных из QVariantList
* */
    query.prepare("INSERT INTO " TABLE " ( "
                  TABLE_TITLE ", "
                  TABLE_AUTHOR ", "
                          TABLE_TIME /*", "
                                     TABLE_COVER */" ) "
                              "VALUES (:title, :author, :time, :coverURL)");
    query.bindValue(":title", data[0].toString());
    query.bindValue(":author", data[1].toString());
    query.bindValue(":time", data[2].toInt());
    //query.bindValue(":coverURL", data[3].toString());
    // После чего выполняется запросом методом exec()
    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBaseTracks::inserIntoTable(const QString &title, const QString &author,
                                    const int &time/*, const QString &coverURL*/) {

    QVariantList data;
    data.append(title);
    data.append(author);
    data.append(time);
    //data.append(coverURL);
    if(inserIntoTable(data))
        return true;
    else
        return false;
}

bool DataBaseTracks::removeRecord(const int id) {
    // Удаление строки из базы данных будет производитсья с помощью SQL- запроса
    QSqlQuery query;
    // Удаление производим по id записи, который передается в качестве аргумента функции
    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);
    // Выполняем удаление
    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
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
    createTable();
}

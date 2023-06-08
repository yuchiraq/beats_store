#include "randombeatsmodel.h"

RandomBeatsModel::RandomBeatsModel(QObject *parent){
    //this->updateModel("5");
}

QStringList RandomBeatsModel::model(){
    return this->results;
}

void RandomBeatsModel::updateModel(QString quantity, QString style) {
    QEventLoop eventloop;

    QString url = setHost::getHost() + setHost::getPort() + "/tracks/random?quantity=" + quantity;

    if(style != "")
        url += "&style=" + style;

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    manager.setTransferTimeout(setHost::getTimeout());

    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

    QNetworkRequest request((QUrl(url)));

    reply = manager.get(request);
    eventloop.exec();

    if(reply->error() == QNetworkReply::NoError) {
        qDebug() << "NO EROOR";



        QString str = QString(reply->readAll());

        QStringList *replyList = new QStringList(QString(str).split("|||"));

        delete reply;

        qDebug() << "connected = true";

        this->results = *replyList;
        this->model();

        return;
    }else {
        qDebug() << "ERROR" << reply->error() << QUrl();

        qDebug() << "connected = false";
        delete reply;
        this->results = QStringList("0");
        return;
    }

    this->results = QStringList("0");
    return;
}

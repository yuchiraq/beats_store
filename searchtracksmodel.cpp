#include "searchtracksmodel.h"

searchTracksModel::searchTracksModel(QObject *parent)
    : QObject{parent}
{

}

QStringList searchTracksModel::model(){
    return this->results;
}

bool searchTracksModel::updateModel(QString title){
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

        qDebug() << "connected = true";

        this->results = *replyList;
        this->model();

        return true;
    }else {
        qDebug() << "ERROR" << reply->error() << QUrl();

        qDebug() << "connected = false";
        delete reply;
        this->results = QStringList("0");
        return false;
    }

    this->results = QStringList("0");
    return false;
}

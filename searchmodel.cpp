#include "searchmodel.h"

searchModel::searchModel(QObject *parent)
    : QObject{parent}
{

}

QStringList searchModel::model(){
    return this->results;
}

bool searchModel::updateModel(QString title, QString type, QString what){
    QEventLoop eventloop;

    QString url = "http://" + setHost::getHost() + setHost::getPort() + "/" + what + "/search?request=" + title + "&type=" + type;
    qDebug() << "searching... " << url;

    QNetworkReply *reply;
    QNetworkAccessManager manager;

    manager.setTransferTimeout(1000);

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

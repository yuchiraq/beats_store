#include "lastrealiseslistModel.h"

LastRealisesListModel::LastRealisesListModel(QObject *parent) : QObject(parent) {
    this->updateList(25);
}

bool LastRealisesListModel::updateList(int quantity){
    if(setHost::connect()){
        if(!this->idList.empty())
            this->idList.clear();

        QNetworkReply *reply;
        QNetworkAccessManager manager;

        QEventLoop eventloop;
        QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventloop, SLOT(quit()));

        QNetworkRequest req(QUrl(QString(setHost::getHost() + setHost::getPort() + "/tracks/lastRealises?quantity=" + QString::number(quantity))));
        reply = manager.get(req);
        eventloop.exec();

        QString str = QString(reply->readAll());

        this->idList = str.split("|||");

        if(this->idList.length() < quantity)
            return false;
        return true;
    }
    return false;
}

QString LastRealisesListModel::addRow(int n){

    if(this->idList.length() < n){
        if(this->updateList(idList.length() + 25))
            return this->idList[--n];
        else if(this->idList.length() < n)
            return "0";
        else
            return this->idList[--n];
    } else {
        return this->idList[--n];
    }
}

bool LastRealisesListModel::reload(){
    this->idList.clear();
    return this->updateList(25);
}

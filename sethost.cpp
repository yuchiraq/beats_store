#include "sethost.h"

setHost::setHost(QObject *parent) : QObject(parent) {

}

setHost::setHost(DataBaseTracks* databaseObj){
    this->database = databaseObj;
}

void setHost::getHost(QString newHost){
    this->database->host = newHost;
    this->database->connectToDataBase();
}

bool setHost::connect(){
    return database->connected;
}

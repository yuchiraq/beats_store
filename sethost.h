#ifndef SETHOST_H
#define SETHOST_H

#include "databasetracks.h"
#include "trackdata.h"
#include <QObject>
#include <QNetworkAccessManager>

class setHost : public QObject
{
    Q_OBJECT
public:
    explicit setHost(QObject *parent = nullptr);
    setHost(DataBaseTracks* database, trackData* trackDataCur);

signals:

public slots:
    void getHost(QString newHost);
    bool connect();
    QString checkNotification();
    bool connectDB();

private:
    bool conectionDB = false;
    bool conectionServer = false;
    DataBaseTracks* database;
    trackData* trackDataClass;
};

#endif // SETHOST_H

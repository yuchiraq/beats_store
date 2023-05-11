#ifndef SETHOST_H
#define SETHOST_H

#include "databasetracks.h"
#include <QObject>

class setHost : public QObject
{
    Q_OBJECT
public:
    explicit setHost(QObject *parent = nullptr);
    setHost(DataBaseTracks* database);

signals:

public slots:
    void getHost(QString newHost);

private:
    DataBaseTracks* database;
};

#endif // SETHOST_H

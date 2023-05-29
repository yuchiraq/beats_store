#ifndef SEARCHMODEL_H
#define SEARCHMODEL_H

#include <QObject>
#include <QEventLoop>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class searchModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList items READ model CONSTANT)
public:
    explicit searchModel(QObject *parent = nullptr);

    QString host = "172.20.10.7";
    QString port = ":8080";

    QStringList model();
public slots:
    bool updateModel(QString title, QString type, QString what);

private:
    QStringList results;
};

#endif // SEARCHMODEL_H

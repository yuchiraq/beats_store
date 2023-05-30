#ifndef LASTREALISESLISTMODEL_H
#define LASTREALISESLISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>

#include "sethost.h"

class LastRealisesListModel : public QObject
{
    Q_OBJECT

public:

    // Объявляем конструктор класса
    explicit LastRealisesListModel(QObject *parent = nullptr);

public slots:
    QString addRow(int n);
    bool reload();

private:
    QStringList idList;

    bool updateList(int quantity);
};

#endif // LASTREALISESLISTMODEL_H

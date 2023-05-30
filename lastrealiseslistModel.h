#ifndef LASTREALISESLISTMODEL_H
#define LASTREALISESLISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>

#include "sethost.h"

class LastRealisesListModel : public QSqlQueryModel
{
    Q_OBJECT


public:
    // Перечисляем все роли, которые будут использоваться в TableView
    enum Roles {
        IdRole = Qt::UserRole + 1, // idFNameRole,
        //TitleRole,
        //AuthorRole,
        //timeRole,
        //coverRole
    };
    // Объявляем конструктор класса
    explicit LastRealisesListModel(QObject *parent = nullptr);
    // Переопределяем метод, который будет возвращать данные
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:
    void updateModel(int type);
    int getId(int row);

};

#endif // LASTREALISESLISTMODEL_H

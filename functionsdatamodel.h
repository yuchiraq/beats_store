#ifndef FUNCTIONSDATAMODEL_H
#define FUNCTIONSDATAMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class functionsDataModel : public QSqlQueryModel
{
    Q_OBJECT
public:

    enum Roles {
        IdRole = Qt::UserRole + 1, // idFNameRole,
        TitleRole,
        AuthorRole,
        timeRole,
        AlbumRole,
        bpmRole
    };

    explicit functionsDataModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:

    void updateModel(int id);

};

#endif // FUNCTIONSDATAMODEL_H

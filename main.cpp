#include <QGuiApplication>
#include <QQuickStyle>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "databasetracks.h"
#include "lastrealiseslistModel.h"
#include "searchlistmodel.h"
#include "randombeatsmodel.h"
#include <QDirIterator>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material");
    QQuickStyle::setFallbackStyle("Material");


    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/beats_store/main.qml"_qs);

    qDebug() << "dick";
    QDir dir;
    dir.cd("./beats_store");//объявляем объект работы с папками
        dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);   ///устанавливаем фильтр выводимых файлов/папок (см ниже)
        dir.setSorting(QDir::Size | QDir::Reversed);   //устанавливаем сортировку "от меньшего к большему"
        QFileInfoList list = dir.entryInfoList();     //получаем список файлов директории
        //qDebug() << "     Bytes Filename";   //выводим заголовок
        /* в цикле выводим сведения о файлах */
        for (int i = 0; i < list.size(); ++i) {
            QFileInfo fileInfo = list.at(i);
            qDebug() << qPrintable(QString("%1").arg(fileInfo.fileName()));   //выводим в формате "размер имя"

        }


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    DataBaseTracks dataBaseTracks;
    dataBaseTracks.connectToDataBase();

    LastRealisesListModel *lastRealisesListModel = new LastRealisesListModel();
    searchListModel *searchModel = new searchListModel();
    RandomBeatsModel *randomBeatsModel = new RandomBeatsModel();

    engine.rootContext() -> setContextProperty("lastRealisesModel", lastRealisesListModel);
    engine.rootContext() -> setContextProperty("database", &dataBaseTracks);
    engine.rootContext() -> setContextProperty("randomBeatsModel", randomBeatsModel);
    engine.rootContext() -> setContextProperty("searchListModel", searchModel);


    engine.load(url);

    return app.exec();
}

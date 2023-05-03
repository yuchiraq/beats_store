#include <QGuiApplication>
#include <QQuickStyle>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "databasetracks.h"
#include "lastrealiseslistModel.h"
#include "searchlistmodel.h"
#include "randombeatsmodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material");
    QQuickStyle::setFallbackStyle("Material");


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("../beats_store/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);

    DataBaseTracks dataBaseTracks;
    dataBaseTracks.connectToDataBase();

    LastRealisesListModel *lastRealisesListModel = new LastRealisesListModel();
    searchListModel *searchModel = new searchListModel();
    RandomBeatsModel *randomBeatsModel = new RandomBeatsModel();

    engine.rootContext() -> setContextProperty("lastRealisesModel", lastRealisesListModel);
    engine.rootContext() -> setContextProperty("database", &dataBaseTracks);
    engine.rootContext() -> setContextProperty("randomBeatsModel", randomBeatsModel);
    engine.rootContext() -> setContextProperty("searchListModel", searchModel);

    //lastRealisesListModel->updateModel(0);

    engine.load(url);

    return app.exec();
}

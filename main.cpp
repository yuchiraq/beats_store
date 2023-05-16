#include <QGuiApplication>
#include <QQuickStyle>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "databasetracks.h"
#include "lastrealiseslistModel.h"
#include "searchlistmodel.h"
#include "randombeatsmodel.h"
#include "functionsdatamodel.h"
#include "sethost.h"
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
    const QUrl url("qrc:/beats_store/main.qml");

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
     QCoreApplication::setAttribute( Qt::AA_UseSoftwareOpenGL );

    DataBaseTracks dataBaseTracks;

    setHost *setHostClass = new setHost(&dataBaseTracks);
    LastRealisesListModel *lastRealisesListModel = new LastRealisesListModel();
    searchListModel *searchModel = new searchListModel();
    RandomBeatsModel *randomBeatsModel = new RandomBeatsModel();
    functionsDataModel * functionsModel = new functionsDataModel();

    engine.rootContext()->setContextProperty("setHost", setHostClass);
    engine.rootContext() -> setContextProperty("lastRealisesModel", lastRealisesListModel);
    engine.rootContext() -> setContextProperty("database", &dataBaseTracks);
    engine.rootContext() -> setContextProperty("randomBeatsModel", randomBeatsModel);
    engine.rootContext() -> setContextProperty("searchListModel", searchModel);
    engine.rootContext() -> setContextProperty("functionsModel", functionsModel);

    engine.load(url);

    dataBaseTracks.connectToDataBase();
    //lastRealisesListModel->updateModel(0);
    //randomBeatsModel->updateModel(0);

    return app.exec();
}

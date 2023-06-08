#include <QGuiApplication>
#include <QQuickStyle>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "lastrealiseslistModel.h"
#include "randombeatsmodel.h"
#include "functionsdatamodel.h"
#include "sethost.h"
#include "trackdata.h"
#include "searchmodel.h"

#include <QDirIterator>

int main(int argc, char *argv[])
{
    qDebug() << setHost::getHost() << " HOST";
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

    qDebug() << setHost::getHost() << " HOST";
    setHost setHostClass;
    qDebug() << setHost::getHost() << " HOST";

    LastRealisesListModel *lastRealisesListModel = new LastRealisesListModel();
    RandomBeatsModel *randomBeatsModel = new RandomBeatsModel();
    functionsDataModel * functionsModel = new functionsDataModel();
    trackData *trackDataClass = new trackData();
    searchModel *search = new searchModel();


    engine.rootContext()->setContextProperty("setHost", &setHostClass);
    engine.rootContext() -> setContextProperty("lastRealises", lastRealisesListModel);
    engine.rootContext() -> setContextProperty("randomBeatsModel", randomBeatsModel);
    engine.rootContext()->setContextProperty("search", search);

    engine.rootContext() -> setContextProperty("functionsModel", functionsModel);
    engine.rootContext()->setContextProperty("trackData", trackDataClass);

    qDebug() << setHost::getHost() << " HOST";

    engine.load(url);

    return app.exec();
}

QT += qml quick quickcontrols2 widgets core svg sql multimedia

greaterThan(QT_MAJOR_VERSION,5): QT += core5compat

SOURCES += \
        databasetracks.cpp \
        functionsdatamodel.cpp \
        lastrealiseslistModel.cpp \
        main.cpp \
        randombeatsmodel.cpp \
        searchtracksmodel.cpp \
        sethost.cpp \
        trackdata.cpp

resources.files = main.qml 
resources.prefix = /$${TARGET}
RESOURCES += resources \
    bottomBar.qrc \
    cards.qrc \
    centralScreen.qrc \
    fonts.qrc \
    helpPages.qrc \
    icons.qrc \
    leftScreen.qrc \
    pages.qrc \
    primitive.qrc \
    rightScreen.qrc \
    topBar.qrc

TRANSLATIONS += \
    beats_store_ru_RU.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


HEADERS += \
    databasetracks.h \
    functionsdatamodel.h \
    lastrealiseslistModel.h \
    randombeatsmodel.h \
    searchtracksmodel.h \
    sethost.h \
    trackdata.h

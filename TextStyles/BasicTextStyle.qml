import QtQuick 2.12

Text {

    color: light

    font: localFontRegular.font
    FontLoader { id: localFontRegular; source: "qrc:/TextStyles/Montserrat-Medium.ttf" }

    FontLoader { id: localFontExtraBold; source: "qrc:/TextStyles/Montserrat-ExtraBold.ttf" }

    FontLoader { id: localFontBold; source: "qrc:/TextStyles/Montserrat-Bold.ttf" }
}

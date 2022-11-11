import QtQuick 2.15

import "qrc:/TextStyles"

ListView {
    id: rightScreen

    width: parent

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }

    BasicTextStyle {
        anchors.centerIn: parent
        text: qsTr("More fragment")
    }
}

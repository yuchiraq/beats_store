import QtQuick 2.15

import "qrc:/TextStyles"

ListView {
    id: leftScreen

    width: parent

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom

    }

    BasicTextStyle {
        text: qsTr("Profile test view")
        anchors.centerIn: parent
    }

}

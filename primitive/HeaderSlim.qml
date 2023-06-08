import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

Rectangle {

    anchors {
        top: parent.top
        topMargin: topBar.height
        horizontalCenter: parent.horizontalCenter
    }

    property string headerText: ""

    //property Component backgroundBlur: NULL
    DropShadow {
        anchors.fill: parent
        radius: 8
        color: "black"
        source: parent
    }

    width: parent.width
    height: blockMargin * 2 + headerTextField.height
    color: container

    clip: true

    FastBlur {
        anchors.top: mainScreen.top
        anchors.horizontalCenter: parent.horizontalCenter
        height: mainScreen.height
        width: mainScreen.width
        source: parent.parent
        radius: 80
        visible: parent.visible
    }

    Rectangle {
        anchors.fill: parent
        color: container
        opacity: 0

        Divider {
            anchors.bottom: parent.bottom
        }
    }

    Text {
        id: headerTextField
        font {
            //weight: Font.Bold
            family: appFont
            pointSize: blockMargin * 1.3
        }
        color: accent
        text: "<b>" + headerText + "</b>"

        anchors {
            top: parent.top
            topMargin: blockMargin
            left: parent.left
            leftMargin: blockMargin
        }
    }
}

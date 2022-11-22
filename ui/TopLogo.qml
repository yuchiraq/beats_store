import QtQuick 2.15
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "qrc:/ui/BottomBar"

Rectangle {
    id: topBar

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }

    height: 60
    width: parent.width

    color: darkestTransparency

    /*Image {

        source: "qrc:/png/fullLOGO.png"

        anchors {
            left: parent.left
            leftMargin: (parent.width - width) / 2
            top: parent.top
            topMargin: (parent.height - height) / 2
        }

        width: parent.width * 0.3
        height: width / (2308 / 392)

    }*/

    ProgressBar {
        indeterminate: true
        anchors.centerIn: parent
    }

    MouseArea {
        id: logoButton

        anchors {
            left: parent.left
            leftMargin: (parent.width - width) / 2
            top: parent.top
            topMargin: (parent.height - height) / 2
        }

        width: parent.width * 0.3
        height: width / (2308 / 392)

        onClicked:{
            bottomBar.color = dark
            topBar.color = dark
        }
    }

//    Rectangle {
//        height: 1
//        width: parent.width
//        color: outline

//        anchors.bottom: parent.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//    }

}

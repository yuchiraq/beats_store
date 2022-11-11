import QtQuick 2.15

Rectangle {
    id: topBar

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }

    height: parent.height / 14
    width: parent.width

    color: "#df282323"

    Image {

        source: "qrc:/png/fullLOGO.png"

        anchors {
            left: parent.left
            leftMargin: (parent.width - width) / 2
            top: parent.top
            topMargin: (parent.height - height) / 2
        }

        width: parent.width * 0.3
        height: width / (2308 / 392)

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

        onClicked:
            topBar.color = "#282323"
    }

}

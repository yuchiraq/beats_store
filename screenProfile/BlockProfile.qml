import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

//import QtGraphicalEffects 1.15
Rectangle {
    border.color: outline
    border.width: 0
    width: mainScreen.width - (blockMargin * 2)
    height: width / 2 * 1

    color: container

    radius: width / 20

    Rectangle {
        id: avaMask
        width: parent.height
        height: width
        color: outline
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        radius: parent.radius

        clip: true
    }
    Image {
        id: avaImage
        anchors.fill: avaMask
        source: leftScreen.ava
        visible: false
    }

    OpacityMask {
        anchors.fill: avaImage
        source: avaImage
        maskSource: avaMask
    }

    Text {
        font.family: appFont
        text: "<strong>Account Name</strong>"
        anchors.left: avaMask.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: blockMargin * 2
        color: "white"
    }
}

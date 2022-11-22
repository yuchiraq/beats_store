import QtQuick 2.15

Rectangle {
    border.color: outline
    border.width: 1
    width: mainScreen.width - (blockMargin * 2)
    height: width / 2 * 1

    color: dark

    radius: width / 20

    Rectangle {
        id: avaMask
        width: parent.height
        height: width
        color: darkVariant
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        radius: parent.radius
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

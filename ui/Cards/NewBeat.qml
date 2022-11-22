import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls


Rectangle {
    id: newRealise

    width: mainScreen.width - (blockMargin * 2)
    height: width / 2 * 1


    radius: blockMargin * 2
    //radius: width / 20

    color: dark

    border.color: outline
    border.width: 1

    property string author: "Beatmaker"
    property string title: "New album"
    property string cover: ""

    Image {
        id: newBeatBackground

        source: cover

        width: parent.width
        height: parent.height

        anchors.centerIn: parent
        visible: false
    }

    OpacityMask {
        anchors.fill: newRealise
        source: newBeatBackground
        maskSource: newRealise
    }

    Text {
        id: newBeatAuthor
        font.family: appFont

        color: light
        anchors {
            left: parent.left
            leftMargin: blockMargin * 2
            bottom: newBeatName.top
            bottomMargin: 2
        }

        text: author
    }

    Text {
        id: newBeatName
        font.family: appFont

        color: "white"

        anchors {
            left: parent.left
            leftMargin: blockMargin * 2
            bottom: parent.bottom
            bottomMargin: blockMargin
        }
        font.bold: true
        text: title

    }

}

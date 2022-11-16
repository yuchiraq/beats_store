import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

import "qrc:/TextStyles"

Rectangle {
    id: newRealise

    width: mainScreen.width - (blockMargin * 2)
    height: width / 2 * 1



    radius: width / 20

    color: dark

    border.color: outline
    border.width: 1

    property string author: "Beatmaker"
    property string title: "New album"
    property string cover: ""

    Image {
        id: newBeatBackground

        source: cover

        width: height / 9 * 16
        height: parent.height
        anchors.centerIn: parent
        visible: false
    }

    OpacityMask {
        anchors.fill: newRealise
        source: newBeatBackground
        maskSource: newRealise
    }

    BasicTextStyle {
        id: newBeatAuthor

        color: light
        anchors {
            left: parent.left
            leftMargin: blockMargin * 2
            bottom: newBeatName.top
            bottomMargin: 2
        }
        text: author
    }

    HeaderTextStyle {
        id: newBeatName

        color: "white"
        anchors {
            left: parent.left
            leftMargin: blockMargin * 2
            bottom: parent.bottom
            bottomMargin: blockMargin
        }

        text: title

    }

}

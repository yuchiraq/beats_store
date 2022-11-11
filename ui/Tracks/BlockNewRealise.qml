import QtQuick 2.15
import Qt5Compat.GraphicalEffects

import "qrc:/TextStyles"

Rectangle {
    id: blockNewRealise

    width: mainScreen.width - (blockMargin * 2)
    height: width / 16 * 9

    radius: width / 20

    color: "black"

    Image {
        id: newBeatBackground

        source: "qrc:/png/temp/162-3.jpg"

        width: height / 9 * 16
        height: parent.height
        anchors.centerIn: parent
        visible: false
    }

    OpacityMask {
        anchors.fill: blockNewRealise
        source: newBeatBackground
        maskSource: blockNewRealise
    }

    Image {
        id: overlay
        source: "qrc:/png/interface/overlay.png"
        width: parent.width
        height: parent.height
        opacity: 0.2
        visible: false
    }

    OpacityMask {
        anchors.fill: blockNewRealise
        source: overlay
        maskSource: blockNewRealise
    }

    BasicTextStyle {
        id: newBeatAuthor

        color: "white"
        anchors {
            left: parent.left
            leftMargin: blockNewRealise.height * 0.1
            bottom: newBeatName.top
            bottomMargin: 2
        }
        text: "Niki-Y on da track"
    }

    HeaderTextStyle {
        id: newBeatName

        color: "white"
        anchors {
            left: parent.left
            leftMargin: blockNewRealise.height * 0.1
            bottom: parent.bottom
            bottomMargin: 10
        }

        text: "«162 pack 3»"

    }

    /*HeaderTextStyle {
        color: "white"
        text: "#Trap"

        anchors {
            top: newBeatName.bottom
            topMargin: 5
            left: parent.left
            leftMargin: blockNewRealise.height * 0.1
        }

    }*/



    MouseArea {

        anchors.fill: parent

        onClicked: {

            if(newBeatName.text == "«162 pack 3»") {
                newBeatBackground.source = "qrc:/png/temp/cp3.jpg"
                newBeatAuthor.text = "Niki-Y on da track"
                newBeatName.text = "«CLASSIC PACK III»"
            } else if(newBeatName.text == "«CLASSIC PACK III»") {
                newBeatBackground.source = "qrc:/png/temp/162-2.jpg"
                newBeatAuthor.text = "Niki-Y on da track"
                newBeatName.text = "«162 pack 2»"
            } else if(newBeatName.text == "«162 pack 2»") {
                newBeatBackground.source = "qrc:/png/temp/162-3.jpg"
                newBeatAuthor.text = "Niki-Y on da track"
                newBeatName.text = "«162 pack 3»"
            }

        }

        onPressAndHold: {



        }

    }

}

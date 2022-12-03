import QtQuick 2.15
import QtGraphicalEffects 1.15
//import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3


Rectangle {
    id: newRealise

    width: mainScreen.width - (blockMargin * 2)
    height: width / 2 * 1


    radius: blockMargin * 1.5

    color: dark

    border.color: outline
    border.width: 1

    property string author: "Beatmaker"
    property string title: "New album"
    property string cover: ""

    Image {
        id: newBeatBackground

        source: cover

        anchors.fill: parent

        anchors.centerIn: parent
        visible: false
    }

    OpacityMask {
        anchors.fill: newRealise
        source: newBeatBackground
        maskSource: newRealise
    }

    Rectangle {
        id: newBeatTextBackground

        color: dark

        opacity: 0.45

        anchors {
            bottom: parent.bottom
            left: parent.left
        }

        radius: parent.radius

        height: blockMargin + newBeatAuthor.height + newBeatName.height
        width: newBeatAuthor.width > newBeatName.width ? (newBeatAuthor.width + blockMargin * 2) : (newBeatName.width + blockMargin * 2)
    }

    Text {
        id: newBeatAuthor
        font.family: appFont

        color: secondary
        anchors {
            left: parent.left
            leftMargin: blockMargin
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
            leftMargin: blockMargin
            bottom: parent.bottom
            bottomMargin: blockMargin * 0.5
        }
        font.bold: true
        text: title

    }

    Rectangle {
        id: likeNewBeatOverlay

        anchors.fill: parent
        radius: parent.radius

        color: dark

        opacity: 0
    }

    property int likeMin: newRealise.height * 0.3
    property int likeMax: newRealise.height * 0.4
    property int timeAnimation: 100

    Image {
        id: likeNewBeatImg
        source: "qrc:/png/interface/heart (1).svg"
        anchors.centerIn: parent
        width: likeMin
        fillMode: Image.PreserveAspectFit
        opacity: 0
    }

    function singleClick(){

    }

    function doubleClick(){
        likeNewBeat.running = true
    }

    MouseArea {
        anchors.fill: parent

        Timer {
            id: timer
            interval: 250
            onTriggered: singleClick()
        }

        onClicked: {
            if (timer.running) {
                doubleClick()
                timer.stop()
            } else {
                timer.restart()
            }
        }
    }

    SequentialAnimation {
        id: likeNewBeat

        NumberAnimation {
            target: likeNewBeatOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0
            to: 0.3
        }

        NumberAnimation {
            target: likeNewBeatImg
            property: "opacity"
            duration: timeAnimation
            from: 0; to: 1
        }

        NumberAnimation {
            target: likeNewBeatImg
            property: "width"
            duration: timeAnimation
            from: likeMin
            to: likeMax
        }

        NumberAnimation {
            target: likeNewBeatImg
            property: "width"
            duration: timeAnimation
            from: likeMax
            to: likeMin
        }

        NumberAnimation {
            target: likeNewBeatImg
            property: "opacity"
            duration: timeAnimation
            from: 1; to: 0
        }

        NumberAnimation {
            target: likeNewBeatOverlay
            property: "opacity"
            duration: timeAnimation / 2
            from: 0.3
            to: 0
        }

        running: false
    }

}

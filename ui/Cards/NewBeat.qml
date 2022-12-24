import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
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

    DropShadow {
        anchors.fill: newBeatAuthor
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 2
        radius: 4.0
        color: "#a0000000"
        source: newBeatAuthor
    }

    DropShadow {
        anchors.fill: newBeatName
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 2
        radius: 4.0
        color: "#a0000000"
        source: newBeatName
    }

    Text {
        id: newBeatAuthor
        font.family: localFont.name

        color: secondary
        anchors {
            left: parent.left
            leftMargin: blockMargin
            bottom: newBeatName.top
            bottomMargin: 2
        }

        text: author
        font.pointSize: blockMargin * 1.7
    }

    Text {
        id: newBeatName
        font.family: appFont

        color: accent

        anchors {
            left: parent.left
            leftMargin: blockMargin
            bottom: parent.bottom
            bottomMargin: blockMargin * 0.5
        }
        font.bold: true
        text: title
        font.pointSize: blockMargin * 2
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
    property int timeAnimation: 300

    Image {
        id: likeNewBeatImg
        source: "qrc:/ui_icons/solid/heart.svg"
        anchors.centerIn: parent
        width: likeMin
        fillMode: Image.PreserveAspectFit
        opacity: 1
        visible: false
    }

    DropShadow {
        id: likeNewBeatImgShadow
        anchors.fill: likeNewBeatImg
        source: likeNewBeatImg
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: 12.0
        color: "#f0000000"
        opacity: 0
    }

    function singleClick() {}

    function doubleClick() {
        likeNewBeat.running = true
    }

    MouseArea {
        anchors.fill: parent

        Timer {
            id: timer
            interval: 250
            onTriggered: singleClick()
        }

        onDoubleClicked: likeNewBeat.running = true

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
        onStarted: likeNewBeatImg.visible = true
        ParallelAnimation {

            NumberAnimation {
                target: likeNewBeatImgShadow
                property: "opacity"
                duration: timeAnimation
                from: 0
                to: 1
            }

            NumberAnimation {
                target: likeNewBeatImg
                property: "width"
                duration: timeAnimation
                from: likeMin
                to: likeMax
            }
        }

        ParallelAnimation {

            NumberAnimation {
                target: likeNewBeatImgShadow
                property: "opacity"
                duration: timeAnimation
                from: 1
                to: 0
            }

            NumberAnimation {
                target: likeNewBeatImg
                property: "width"
                duration: timeAnimation
                from: likeMax
                to: likeMin
            }
        }
        onFinished: likeNewBeatImg.visible = false
        running: false
    }

    //    SequentialAnimation {
    //        id: likeNewBeat

    //        NumberAnimation {
    //            target: likeNewBeatOverlay
    //            property: "opacity"
    //            duration: timeAnimation / 2
    //            from: 0
    //            to: 0.3
    //        }

    //        NumberAnimation {
    //            target: likeNewBeatImg
    //            property: "opacity"
    //            duration: timeAnimation
    //            from: 0; to: 1
    //        }

    //        NumberAnimation {
    //            target: likeNewBeatImg
    //            property: "width"
    //            duration: timeAnimation
    //            from: likeMin
    //            to: likeMax
    //        }

    //        NumberAnimation {
    //            target: likeNewBeatImg
    //            property: "width"
    //            duration: timeAnimation
    //            from: likeMax
    //            to: likeMin
    //        }

    //        NumberAnimation {
    //            target: likeNewBeatImg
    //            property: "opacity"
    //            duration: timeAnimation
    //            from: 1; to: 0
    //        }

    //        NumberAnimation {
    //            target: likeNewBeatOverlay
    //            property: "opacity"
    //            duration: timeAnimation / 2
    //            from: 0.3
    //            to: 0
    //        }

    //        running: false
    //    }
}

import QtQuick 2.15
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "qrc:/"

Rectangle {
    id: musicPlayer

    property string titlePlayer: "Title"
    property string authorPlayer: "Author"
    property string coverPlayer: ""
    property bool play: true

    width: mainScreen.width
    height: 40

    color: darkestTransparency

    visible: false

    anchors {
        bottom: parent.bottom
        bottomMargin: bottomBar.height
        left: parent.left
        right: parent.right
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (parent.height == 40) {
                musicPlayerMax.visible = true
                musicPlayerMin.visible = false
                musicPlayerOnMax.running = true
                parent.color = darkest
            }
            else if (parent.height == mainScreen.height - 120) {
                musicPlayerMax.visible = false
                musicPlayerMin.visible = true
                musicPlayerOnMin.running = true
                parent.color = darkestTransparency
            }
        }
    }

    Item {

        id: musicPlayerMin

        anchors.fill: parent

        Text {
            id: musicPlayerMinTitle

            text: titlePlayer

            font.family: appFont

            color: "#FFF"

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: blockMargin * 2
            }
        }

        Text {
            id: musicPlayerMinAuthor

            text: authorPlayer

            font.family: appFont

            color: light

            anchors {
                verticalCenter: parent.verticalCenter
                left: musicPlayerMinTitle.right
                leftMargin: blockMargin
            }
        }

        Button {
            id: musicPlayerMinPP

            width: parent.height
            height: width

            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: blockMargin
            }

            contentItem: Image {
                id: musicPlayerMinPPImg
                source: "qrc:/png/interface/play.svg"
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                height: 40
            }

            background: Rectangle {
                color: "#00000000"
            }

            onClicked: {
                playerPPclick()
            }
        }
    }


    function playerPPclick(){
        if(play){
            play = false
            musicPlayerMinPPImg.source = "qrc:/png/interface/pause.svg"
            musicPlayerMaxPPImg.source = "qrc:/png/interface/pause.svg"
        }else{
            play = true
            musicPlayerMinPPImg.source = "qrc:/png/interface/play.svg"
            musicPlayerMaxPPImg.source = "qrc:/png/interface/play.svg"
        }
    }

    //animation and max from here



    Item {
        id: musicPlayerMax

        anchors.fill: parent

        visible: true
        opacity: 0

        Rectangle {
            id: topLine

            width: 40
            height: 4

            color: secondary

            radius: 2

            anchors {
                top: parent.top
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }

        }

        Rectangle {
            id: musicPlayerMaxCoverMask
            width: parent.width * 0.8
            height: width

            radius: blockMargin * 2

            color: darkVariant

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.width * 0.1
            }
            smooth: true
            visible: false
        }

        DropShadow {
            anchors.fill: musicPlayerMaxCoverMask
            horizontalOffset: -8
            verticalOffset: 8
            radius: 20.0
            color: "#80000000"
            source: musicPlayerMaxCoverMask
        }


        Image {
            id: musicPlayerMaxCoverImg

            source: coverPlayer

            anchors {
                fill: musicPlayerMaxCoverMask
                centerIn: musicPlayerMaxCoverMask
            }

            visible: false
        }

        OpacityMask {
            anchors.fill: musicPlayerMaxCoverMask
            source: musicPlayerMaxCoverImg
            maskSource: musicPlayerMaxCoverMask
        }

        Slider {
            id: seekSlider
            value: 113
            to: 261

            width: parent.width * 0.6

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: musicPlayerMaxCoverMask.bottom
                topMargin: 20
            }

            ToolTip {
                parent: seekSlider.handle
                visible: seekSlider.pressed
                text: pad(Math.floor(value / 60)) + ":" + pad(Math.floor(value % 60))
                y: parent.height

                readonly property int value: seekSlider.valueAt(seekSlider.position)

                function pad(number) {
                    if (number <= 9)
                        return "0" + number;
                    return number;
                }
            }
        }

        Label {
            id: musicPlayerMaxTitle
            text: titlePlayer

            color: "#FFF"
            font.family: appFont
            font.bold: true
            font.pointSize: 20

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: musicPlayerMaxCoverMask.bottom
                topMargin: 60
            }
        }

        Label {
            id: musicPlayerMaxAuthor
            text: authorPlayer

            color: secondary
            font.family: appFont
            font.bold: false
            font.pointSize: 15
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: musicPlayerMaxTitle.bottom
                topMargin: 10
            }
        }

        Button {
            id: musicPlayerMaxPP

            width: parent.width * 0.2
            height: width

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: musicPlayerMaxAuthor.bottom
                topMargin: 40
            }

            contentItem: Image {
                id: musicPlayerMaxPPImg
                source: "qrc:/png/interface/play.svg"
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                height: parent.height
                smooth: true
            }

            background: Rectangle {
                color: "#00000000"
            }

            onClicked: {
                playerPPclick()
            }

        }
    }

    property int timeAnimation: 200

    ParallelAnimation {
        id: musicPlayerOnMax

        running: false

        NumberAnimation {
            target: musicPlayer
            property: "radius"
            duration: timeAnimation
            from: 0
            to: blockMargin * 2
        }

        NumberAnimation {
            target: musicPlayer
            property: "height"
            duration: timeAnimation
            from: 40
            to: mainScreen.height - 120
        }

        NumberAnimation {
            target: musicPlayer
            property: "anchors.bottomMargin"
            duration: timeAnimation
            from: bottomBar.height
            to: 0
        }

        NumberAnimation {
            target: musicPlayerMax
            property: "opacity"
            duration: timeAnimation
            from: 0
            to: 1
        }

        NumberAnimation {
            target: topLine
            property: "width"
            duration: timeAnimation
            from: 0
            to: 40
        }

    }

    ParallelAnimation {
        id: musicPlayerOnMin

        running: false

        NumberAnimation {
            target: musicPlayer
            property: "radius"
            duration: timeAnimation
            from: blockMargin * 2
            to: 0
        }

        NumberAnimation {
            target: musicPlayer
            property: "height"
            duration: timeAnimation
            from: mainScreen.height - 120
            to: 40
        }

        NumberAnimation {
            target: musicPlayer
            property: "anchors.bottomMargin"
            duration: timeAnimation
            from: 0
            to: bottomBar.height
        }

        NumberAnimation {
            target: musicPlayerMax
            property: "opacity"
            duration: timeAnimation
            from: 1
            to: 0
        }

        NumberAnimation {
            target: topLine
            property: "width"
            duration: timeAnimation
            from: 40
            to: 0
        }

    }

}

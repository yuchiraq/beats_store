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
    property bool onRepeat: false

    property string timePlayerString: "0:00"
    property int timePlayerSec: 200
    property int curTime: 0

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
                musicPlayerOnMax.running = true
                musicPlayerMax.visible = true
                musicPlayerMin.visible = false
                parent.color = darkest
            }
            else if (parent.height == mainScreen.height - 120) {
                musicPlayerOnMin.running = true
                musicPlayerMax.visible = false
                musicPlayerMin.visible = true
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

        Text {
            id: musicPlayerMinCurTime

            text: timeCorrector(Math.floor(playerSlider.value / 60)) + ":" + timeCorrector(Math.floor(playerSlider.value % 60))

            color: secondary

            anchors {
                right: musicPlayerMinPP.left
                rightMargin: blockMargin
                verticalCenter: parent.verticalCenter
            }

            function timeCorrector(number) {
                if (number <= 9)
                    return "0" + number;
                return number;
            }
        }

        Button {
            id: musicPlayerMinPP

            width: 40
            height: 40

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
            id: topLinePlayer

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
            id: playerSlider
            value: curTime
            to: timePlayerSec

            width: parent.width * 0.6

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: musicPlayerMaxCoverMask.bottom
                topMargin: 20
            }

            ToolTip {
                parent: playerSlider.handle
                //visible: playerSlider.pressed
                visible: false
                text: pad(Math.floor(value / 60)) + ":" + pad(Math.floor(value % 60))
                y: parent.height

                readonly property int value: playerSlider.valueAt(playerSlider.position)

                function pad(number) {
                    if (number <= 9)
                        return "0" + number;
                    return number;
                }
            }
        }


        Text {
            id: musicPlayerMaxCurTime

            text: timeCorrector(Math.floor(playerSlider.value / 60)) + ":" + timeCorrector(Math.floor(playerSlider.value % 60))

            color: secondary

            anchors {
                right: musicPlayerMaxCoverMask.left
                verticalCenter: playerSlider.verticalCenter
            }

            function timeCorrector(number) {
                if (number <= 9)
                    return "0" + number;
                return number;
            }
        }

        Text {
            id: musicPlayerMaxTime

            text: timePlayerString

            color: secondary

            anchors {
                left: musicPlayerMaxCoverMask.right
                verticalCenter: playerSlider.verticalCenter
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
                top: playerSlider.bottom
                topMargin: 20
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

                width: parent.width * 0.15
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

            Button {
                id: playerRepeat

                width: musicPlayerMaxPP.height * 0.7
                height: width

                anchors {
                    left: musicPlayerMaxPP.right
                    leftMargin: parent.width * 0.1
                    verticalCenter: musicPlayerMaxPP.verticalCenter
                }

                contentItem: Image {
                    id: playerRepeatImg
                    source: "qrc:/png/interface/arrows-repeat (1).svg"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    width: parent.height
                    smooth: true
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onClicked: {
                    if(onRepeat) {
                        onRepeat = false
                        playerRepeatImg.source = "qrc:/png/interface/arrows-repeat (1).svg"
                    } else {
                        onRepeat = true
                        playerRepeatImg.source = "qrc:/png/interface/arrows-repeat.svg"
                    }
                }

            }

            Button {
                id: playerFunctions

                width: musicPlayerMaxPP.height * 0.7
                height: width

                anchors {
                    right: musicPlayerMaxPP.left
                    rightMargin: parent.width * 0.1
                    verticalCenter: musicPlayerMaxPP.verticalCenter
                }

                contentItem: Image {
                    id: playerFunctionsImg
                    source: "qrc:/png/interface/menu-burger.svg"
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                    width: parent.height
                    smooth: true
                }

                background: Rectangle {
                    color: "#00000000"
                }

                onClicked: {
                    beatFunctions.starter()
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
            target: topLinePlayer
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
            target: topLinePlayer
            property: "width"
            duration: timeAnimation
            from: 40
            to: 0
        }

    }

    function resetPlayerSlider(){
        playerSlider.value = 0
    }


}

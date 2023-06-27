import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/cards"
import "qrc:/primitive"

Rectangle {
    id: blockRandomBeats

    width: mainScreen.width - (blockMargin * 2)
    height: blockMargin * 7 * 5 + 3 + headerRandomBeats.height + blockMargin * 2 + blockMargin
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#333333"
    color: container
    border.color: outline
    border.width: px(1)
    clip: true

    property int style: 0

    property bool page: false

    property int prevPosView: 0

    ColorAnimation on border.color {
        id: borderColorOn
        from: outline
        to: secondary
        duration: 200
        running: false
        onFinished: borderColorOff.restart()
    }
    ColorAnimation on border.color {
        id: borderColorOff
        from: secondary
        to: outline
        duration: 200
        running: false
    }

    MouseArea {
        id: randomBeatsMouse
        anchors.fill: parent

        onClicked: {
            //            if (bottomBar.active == 2) {
            //                centralScreen.push("qrc:/screenTracks/RandomBeatsPage.qml",
            //                                   StackView.Immediate)
            //                topBar.backSwitch()
            //            }
            if (!blockRandomBeats.page)
                openPage.start()
            else
                closePage.start()
        }

        onPressed: {
            if (!borderColorOn.running && !borderColorOff.running)
                borderColorOn.restart()
        }
    }

    Divider {
        width: parent.width
        color: outline
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
    }

    ListView {
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        model: 5

        visible: !randomBeatsView.visible

        delegate: Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: blockMargin * 7 + px(1)

            BeatLine {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                id_track: ""
            }
        }
    }

    ListView {
        id: randomBeatsView

        model: randomBeatsModel.items

        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            //bottom: parent.bottom
        }

        flickableDirection: Flickable.AutoFlickDirection
        reuseItems: true

        height: contentHeight

        delegate: Item {
            id: randomBeatButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: randomBeat.height + 0.5

            BeatLine {
                id: randomBeat
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                id_track: modelData != "" ? modelData : "empty arg"
            }
        }

        visible: randomBeatsView.count != 0
    }

    function updateView(count) {
        randomBeatsModel.updateModel(count, blockRandomBeats.style.toString())
        randomBeatsView.model = randomBeatsModel.items
    }

    ParallelAnimation {
        id: openPage

        NumberAnimation {
            target: blockRandomBeats
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: blockMargin * 7 * 5 + 3 + headerRandomBeats.height + blockMargin * 2 + blockMargin
            to: mainScreen.height
        }

        NumberAnimation {
            target: blockRandomBeats
            property: "width"
            duration: 400
            easing.type: Easing.InOutQuad
            from: mainScreen.width - (blockMargin * 2)
            to: mainScreen.width
        }

        NumberAnimation {
            target: blockRandomBeats
            property: "radius"
            duration: 400
            easing.type: Easing.InOutQuad
            from: blockMargin * 1.5
            to: 0
        }

        NumberAnimation {
            target: bestTracksInitial
            property: "contentY"
            //duration: 400
            easing.type: Easing.InOutCirc
            from: bestTracksInitial.contentY
            to: blockMargin * 2 + blockNewRealise.height
        }

        NumberAnimation {
            target: randomBeatsView
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: randomBeatsView.contentHeight
            to: mainScreen.height - topBar.height * 3
        }

        onFinished: {
            updateView(0)

            blockRandomBeats.page = true
        }

        onStarted: {
            randomBeatsView.interactive = true
            prevPosView = bestTracksInitial.contentY
            headerOnColor.start()
            colorToSurface.start()
            bestTracksInitial.interactive = false
            randomBeatsView.clip = false
        }

        running: false
    }

    ParallelAnimation {
        id: closePage

        NumberAnimation {
            target: blockRandomBeats
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: mainScreen.height
            to: blockMargin * 7 * 5 + 3 + headerRandomBeats.height + blockMargin * 2 + blockMargin
        }

        NumberAnimation {
            target: blockRandomBeats
            property: "width"
            duration: 400
            easing.type: Easing.InOutQuad
            from: mainScreen.width
            to: mainScreen.width - (blockMargin * 2)
        }

        NumberAnimation {
            target: blockRandomBeats
            property: "radius"
            duration: 400
            easing.type: Easing.InOutQuad
            from: 0
            to: blockMargin * 1.5
        }

        NumberAnimation {
            target: bestTracksInitial
            property: "contentY"
            //duration: 200
            easing.type: Easing.InOutCirc
            from: blockMargin * 2 + blockNewRealise.height
            to: prevPosView
        }

        //        NumberAnimation {
        //            target: randomBeatsView
        //            property: "height"
        //            duration: 400
        //            easing.type: Easing.InOutQuad
        //            from: randomBeatsView.contentHeight
        //            to: (blockMargin * 7 + px(1)) * 5
        //        }
        NumberAnimation {
            target: randomBeatsView
            property: "contentY"
            duration: 400
            easing.type: Easing.InOutQuad
            from: randomBeatsView.contentY
            to: 0
        }

        onFinished: {

            //updateView(5)
            randomBeatsView.height = (blockMargin * 7 + px(1)) * 5

            randomBeatsView.positionViewAtBeginning()
            blockRandomBeats.page = false

            randomBeatsView.clip = true
            randomBeatsView.interactive = false
        }

        onStarted: {
            headerOnTransparent.start()
            colorToContainer.start()
            bestTracksInitial.interactive = true
        }

        running: false
    }

    ColorAnimation on color {
        id: colorToSurface
        from: container
        to: surface
        duration: 400
        running: false
    }
    ColorAnimation on color {
        id: colorToContainer
        from: surface
        to: container
        duration: 400
        running: false
    }

    Rectangle {

        id: header
        ColorAnimation on color {
            id: headerOnColor
            from: "transparent"
            to: surface
            duration: 400
            running: false
        }

        ColorAnimation on color {
            id: headerOnTransparent
            from: surface
            to: "transparent"
            duration: 200
            running: false
        }

        border.width: header.color == surface ? px(1) : 0
        border.color: surface

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width
        color: "transparent"

        height: blockMargin * 4

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (!blockRandomBeats.page)
                    openPage.start()
                else
                    closePage.start()
            }

            onPressed: {
                if (!borderColorOn.running && !borderColorOff.running)
                    borderColorOn.restart()
            }
        }

        Text {
            id: headerRandomBeats
            font {
                //weight: Font.Bold
                //family: appFont
                pointSize: blockMargin * 1.3
            }
            color: accent
            text: "<b>Биты</b>"

            anchors {
                top: parent.top
                topMargin: blockMargin
                left: parent.left
                leftMargin: blockMargin
            }
        }

        Button {
            id: blockRandomBeatsStyleButton

            anchors {
                verticalCenter: headerRandomBeats.verticalCenter
                right: parent.right
                rightMargin: blockMargin
            }

            background: Rectangle {
                anchors.fill: parent
                radius: blockMargin
                border.color: outline
                border.width: 0.5
                color: container

                Text {

                    id: randomBeatsSelectorText
                    text: "Случайные"
                    font.pointSize: blockMargin * 1.3
                    //font.family: appFont
                    color: secondary

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }

                Image {
                    source: "qrc:/ui_icons/basic/angle-small-right.svg"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    ColorOverlay {
                        source: parent
                        color: secondary
                        anchors.fill: parent
                    }

                    rotation: 90
                    height: parent.height
                    width: height
                }
            }

            height: blockMargin * 1.6
            width: randomBeatsSelectorText.width + height + 20

            onClicked: {
                //styleChooser.styleFor = 1
                console.log("Clicked!!!!!")
                //styleChooser.starter()
                //stackMaskedBackground.visible = true
                menu.open()
            }
        }

        Menu {
            id: menu
            background: Rectangle {
                anchors.top: blockRandomBeatsStyleButton.top
                anchors.horizontalCenter: blockRandomBeatsStyleButton.horizontalCenter
                color: container
                border.color: outline
                border.width: 0.5
                radius: blockMargin * 1.5
                implicitWidth: blockMargin * 12
                implicitHeight: blockMargin * 12
            }

            onAboutToShow: stackMaskedBackground.visible = true
            onAboutToHide: stackMaskedBackground.visible = false

            font {
                pointSize: blockMargin * 1.4
                //family: appFont
            }

            MenuItem {
                text: "Jazz"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuSeparator {
                Divider {}
            }
            MenuItem {
                text: "K-Pop"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuSeparator {
                contentItem: Divider {}
            }
            MenuItem {
                text: "Russian Rock"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuSeparator {
                contentItem: Rectangle {
                    implicitWidth: blockMargin * 6
                    implicitHeight: 0.5
                    color: outline
                }
            }
            MenuItem {
                text: "UK Drill"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuSeparator {
                contentItem: Rectangle {
                    implicitWidth: blockMargin * 6
                    implicitHeight: 0.5
                    color: outline
                }
            }
            MenuItem {
                text: "Drill"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuSeparator {
                contentItem: Rectangle {
                    implicitWidth: blockMargin * 6
                    implicitHeight: 0.5
                    color: outline
                }
            }
            MenuItem {
                text: "Pop"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuSeparator {
                contentItem: Rectangle {
                    implicitWidth: blockMargin * 6
                    implicitHeight: 0.5
                    color: outline
                }
            }
            MenuItem {
                text: "Rock"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Trap"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Rap"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "R\&B"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Jazz"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Russian Rock"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "UK Drill"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Drill"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Pop"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Rock"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Trap"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "Rap"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "R\&B"
                font {
                    pointSize: blockMargin * 1.4
                    //family: appFont
                }
                background: Rectangle {
                    color: container
                    implicitWidth: blockMargin * 12
                    implicitHeight: blockMargin * 3
                    radius: blockMargin * 1.5
                }
                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
        }
    }
}

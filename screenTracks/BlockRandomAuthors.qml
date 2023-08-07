import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/cards"
import "qrc:/primitive"

Rectangle {
    id: blockRandomAuthors

    width: mainScreen.width - (blockMargin * 2)
    height: headerRandomAuthors.height + blockMargin * 2 + blockMargin + blockMargin * 16
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#00333333"
    color: container

    border.color: outline
    border.width: px(1)

    clip: true

    property bool page: false
    property int prevPosView: 0

    MouseArea {
        id: backgroundMenu
        anchors.fill: mainScreen

        onClicked: menu.close()
        visible: false
    }

    Flickable {
        id: randomAuthorsFlicable

        contentWidth: AuthorMiniCard.width * 8 + blockMargin * 7
        anchors {
            top: header.bottom
            //topMargin: blockMargin
            left: parent.left
            right: parent.right
            leftMargin: 1
            rightMargin: 1
        }

        clip: true

        width: parent.width - 2
        height: parent.height - headerRandomAuthors.height - 20

        Row {
            id: randomAuthors
            anchors.fill: parent
            anchors.leftMargin: blockMargin
            anchors.rightMargin: blockMargin
            spacing: blockMargin

            AuthorMiniCard {

                style: "Trap/EDM"
                name: "Niki-Y On Da Track"
                author_id: "8"
            }

            AuthorMiniCard {
                style: "Boss design"
                name: "Chiraq Concept"
                author_id: "5"
            }

            AuthorMiniCard {
                style: "Shit"
                name: "ogbogtoy"
                author_id: "1"
            }

            AuthorMiniCard {
                style: "Shit"
                name: "ogbogdsalkdsald toykjadiojdajdosad"
                author_id: "2"
            }
            AuthorMiniCard {
                author_id: "12"
            }
            AuthorMiniCard {
                author_id: "19"
            }
            AuthorMiniCard {}
            AuthorMiniCard {}
            AuthorMiniCard {}
        }
    }

    ParallelAnimation {
        id: openPage

        NumberAnimation {
            target: blockRandomAuthors
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: blockMargin * 7 * 5 + 3 + headerRandomAuthors.height
                  + blockMargin * 2 + blockMargin
            to: mainScreen.height
        }

        NumberAnimation {
            target: blockRandomAuthors
            property: "width"
            duration: 400
            easing.type: Easing.InOutQuad
            from: mainScreen.width - (blockMargin * 2)
            to: mainScreen.width
        }

        NumberAnimation {
            target: blockRandomAuthors
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
            to: blockMargin * 3 + blockRandomBeats.height + blockNewRealise.height
        }
        NumberAnimation {
            target: randomAuthorsView
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: randomAuthorsView.contentHeight
            to: mainScreen.height - topBar.height * 3
        }

        onFinished: {
            blockRandomAuthors.page = true
            //startSplashScreen.visible = false
        }

        onStarted: {
            //startSplashScreen.startSplash()
            //randomAuthorsView.interactive = true
            //blockRandomAuthors.prevPosView = blockRandomAuthors.top
            headerOnColor.start()
            colorToSurface.start()
            bestTracksInitial.interactive = false
            //randomAuthorsView.clip = false
            //updateView(0)
        }

        running: false
    }

    ParallelAnimation {
        id: closePage

        NumberAnimation {
            target: blockRandomAuthors
            property: "height"
            duration: 400
            easing.type: Easing.InOutQuad
            from: mainScreen.height
            to: blockMargin * 16 + 3 + headerRandomAuthors.height + blockMargin * 2 + blockMargin
        }

        NumberAnimation {
            target: blockRandomAuthors
            property: "width"
            duration: 400
            easing.type: Easing.InOutQuad
            from: mainScreen.width
            to: mainScreen.width - (blockMargin * 2)
        }

        NumberAnimation {
            target: blockRandomAuthors
            property: "radius"
            duration: 400
            easing.type: Easing.InOutQuad
            from: 0
            to: blockMargin * 1.5
        }

        NumberAnimation {
            target: randomAuthorsView
            property: "contentY"
            duration: 400
            easing.type: Easing.InOutQuad
            from: randomBeatsView.contentY
            to: 0
            onStarted: {
                console.log("count " + randomBeatsView.count)
                while (randomBeatsView.count > 5) {
                    randomBeatsView.remove(randomBeatsView.count - 1)
                }
            }
        }

        onFinished: {

            //updateView(5)
            //randomAuthorsView.height = (blockMargin * 7 + px(1)) * 5
            blockRandomAuthors.page = false

            //randomAuthorsView.clip = true
            //randomAuthorsView.interactive = false
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

        height: headerRandomAuthors.height + blockMargin * 2

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (!blockRandomAuthors.page)
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
            id: headerRandomAuthors
            font {
                pointSize: blockMargin * 1.3
            }
            color: accent
            text: "<b>Авторы</b>"

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: blockMargin
            }
        }

        Button {
            id: blockRandomAuthorsStyleButton

            anchors {
                verticalCenter: headerRandomAuthors.verticalCenter
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

                    id: randomAuthorsSelectorText
                    text: "Случайные"
                    font.pointSize: blockMargin * 1.3
                    //font.family: appFont
                    color: secondary

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }

                Image {
                    source: "qrc:/png/interface/next.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    rotation: 90
                    height: parent.height / 2
                    width: height
                }
            }

            height: blockMargin * 1.6
            width: randomAuthorsSelectorText.width + height + 20

            onClicked: {
                //            styleChooser.styleFor = 2
                //            console.log("Clicked!!!!!")
                //            styleChooser.starter()
                menu.popup()
            }
        }

        Menu {
            id: menu

            onAboutToShow: {
                backgroundMenu.visible = true
                stackMaskedBackground.visible = true
            }
            onAboutToHide: {
                backgroundMenu.visible = false
                stackMaskedBackground.visible = false
            }

            transformOrigin: Menu.Right

            font {
                pointSize: blockMargin * 1.4
                //family: appFont
            }

            MenuItem {
                text: "Все"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuSeparator {
                Divider {}
            }
            MenuItem {
                text: "K-Pop"

                contentItem: Text {
                    text: parent.text
                    color: secondary
                    font: parent.font
                }

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
            MenuItem {
                text: "K-Pop"

                onClicked: {
                    randomBeatsSelectorText.text = text
                }
            }
        }
    }
}

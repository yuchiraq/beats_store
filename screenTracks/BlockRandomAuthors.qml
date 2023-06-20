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

    Text {
        id: headerRandomAuthors

        font {
            weight: Font.Bold
            //family: appFont
            pointSize: blockMargin * 1.3
        }
        color: accent

        text: "<b>Авторы</b>"
        anchors {
            top: parent.top
            topMargin: blockMargin
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

    MouseArea {
        id: backgroundMenu
        anchors.fill: mainScreen

        onClicked: menu.close()
        visible: false
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

    Flickable {
        id: randomAuthorsFlicable

        contentWidth: AuthorMiniCard.width * 8 + blockMargin * 7
        anchors {
            top: headerRandomAuthors.bottom
            topMargin: blockMargin
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
                cover: "http://" + ip + "/coversMini/9.jpg"
            }

            AuthorMiniCard {
                style: "Boss design"
                name: "Chiraq Concept"
                cover: "http://" + ip + "/coversMini/1.jpg"
            }

            AuthorMiniCard {
                style: "Shit"
                name: "ogbogtoy"
                cover: "http://" + ip + "/coversMini/10.jpg"
            }

            AuthorMiniCard {
                style: "Shit"
                name: "ogbogdsalkdsald toykjadiojdajdosad"
                cover: "http://" + ip + "/coversMini/12.jpg"
            }
            AuthorMiniCard {}
            AuthorMiniCard {}
            AuthorMiniCard {}
            AuthorMiniCard {}
            AuthorMiniCard {}
        }
    }
}

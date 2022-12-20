import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/ui/Cards"
import "qrc:/fonts"

Rectangle {
    id: blockRandomAuthors

    width: mainScreen.width - (blockMargin * 2)
    height: headerRandomAuthors.height + blockMargin * 2 + blockMargin + blockMargin * 14
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#00333333"
    color: dark

    border.color: outline
    border.width: 0.5

    Text {
        id: headerRandomAuthors

        font.family: appFont
        color: light

        text: "<b>Авторы</b>"
        anchors {
            top: parent.top
            topMargin: blockMargin
            left: parent.left
            leftMargin: blockMargin
        }
        font.pointSize: blockMargin * 1.3
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
            color: dark

            Text {

                id: randomAuthorsSelectorText
                text: "Случайные"
                font.pointSize: blockMargin * 1.3
                font.family: appFont
                color: light

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
            styleChooser.styleFor = 2
            console.log("Clicked!!!!!")
            styleChooser.starter()
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
                cover: "qrc:/png/temp/authors/ava.png"
            }

            AuthorMiniCard {
                style: "Boss design"
                name: "Chiraq Concept"
                cover: "qrc:/png/temp/authors/cq.png"
            }

            AuthorMiniCard {
                style: "Shit"
                name: "ogbogtoy"
                cover: "qrc:/png/temp/covers/cover.jpg"
            }

            AuthorMiniCard {
                style: "Shit"
                name: "ogbogdsalkdsald toykjadiojdajdosad"
                cover: "qrc:/png/temp/covers/cover.jpg"
            }
            AuthorMiniCard {}
            AuthorMiniCard {}
            AuthorMiniCard {}
            AuthorMiniCard {}
            AuthorMiniCard {}
        }
    }
}

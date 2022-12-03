import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/ui/Cards"

Rectangle {
    id: blockRandomAuthors

    width: mainScreen.width - (blockMargin * 2)
    height: headerRandomAuthors.height + 20 + blockMargin + blockMargin * 12
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#00333333"
    color: dark

    border.color: outline
    border.width: 0

    Text {
        id: headerRandomAuthors

        font.family: appFont
        color: light

        text: "<b>Авторы</b>"
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: blockMargin * 2
        }
    }

    Flickable {
        id: randomAuthorsFlicable

        contentWidth: AuthorMiniCard.width * 8 + blockMargin * 7
        anchors {
            top: headerRandomAuthors.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        clip: true

        width: parent.width
        height: parent.height - headerRandomAuthors.height - 20

        Row {
            id: randomAuthors
            anchors.fill: parent
            anchors.leftMargin: blockMargin
            anchors.rightMargin: blockMargin
            spacing: blockMargin

//            OpacityMask {
//                anchors.fill: randomAuthors
//                source: randomAuthors
//                maskSource: blockRandomAuthors
//            }

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

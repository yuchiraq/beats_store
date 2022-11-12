import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

import "qrc:/TextStyles"
import "qrc:/ui/Cards"

Rectangle {
    id: blockRandomAuthors

    width: mainScreen.width - (blockMargin * 2)
    height: blockMargin * 20
    radius: width / 20

    color: "#333333"

    HeaderTextStyle {
        id: headerRandomAuthors

        text: "Авторы"
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: blockNewRealise.height * 0.1
        }
    }

    ScrollView {

        anchors {
            top: headerRandomAuthors.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        width: parent.width
        height: parent.height - headerRandomAuthors.height - 20

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ScrollBar.horizontal.interactive: true
        ScrollBar.vertical.interactive: false

        contentHeight: height

        Row {
            id: randomAuthors
            anchors.fill: parent
            anchors.leftMargin: blockMargin
            spacing: blockMargin

            AuthorMiniCard {
                id: testRandomAuthorCard0
                style: "Trap/EDM"
                name: "Niki-Y On Da Track"
                cover: "qrc:/png/temp/authors/ava.png"
            }

            AuthorMiniCard {
                id: testRandomAuthorCard1
                style: "Boss design"
                name: "Chiraq Concept"
                cover: "qrc:/png/temp/authors/cq.png"
            }

            AuthorMiniCard {
                id: testRandomAuthorCard2
                style: "Shit"
                name: "ogbogtoy"
                cover: "qrc:/png/temp/covers/cover.jpg"
            }

            AuthorMiniCard {

            }

            AuthorMiniCard {

            }
        }
    }

}

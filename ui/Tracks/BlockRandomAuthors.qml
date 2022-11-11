import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

import "qrc:/TextStyles"

Rectangle {
    id: blockRandomAuthors

    width: mainScreen.width - (blockMargin * 2)
    height: blockMargin * 20
    radius: width / 20

    color: "#333333"

    HeaderTextStyle {
        id: headerRandomAuthors
        text: "Случайные авторы"
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
            leftMargin: blockRandomAuthors.radius
        }

        width: parent.width
        height: parent.height - headerRandomAuthors.height - 20

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        ScrollBar.horizontal.interactive: true
        ScrollBar.vertical.interactive: false

        contentHeight: height

        Row {

            anchors.fill: parent
            spacing: blockMargin

            Rectangle {
                id: randomAuthor

                height: parent.height - blockRandomAuthors.radius
                width: height / 12 * 9
                radius: height / 20
                color: "#282323"

                Rectangle {
                    id: randomAuthorCoverMask

                    width: parent.width - blockMargin
                    height: width
                    radius: width / 20

                    color: "#333"

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: blockMargin / 2
                    }
                }

                Image {
                    id: randomAuthorCover
                    source: "qrc:/png/temp/authors/ava.png"

                    width: parent.width - blockMargin
                    height: width

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: blockMargin / 2
                    }

                    visible: false
                }

                OpacityMask {
                    anchors.fill: randomAuthorCoverMask
                    source: randomAuthorCover
                    maskSource: randomAuthorCoverMask
                }

                BasicTextStyle {
                    id: randomAuthorName
                    color: "white"
                    text: "Niki-Y On Da Track"

                    height: (randomAuthor.height - randomAuthorCoverMask.height) / 2

                    anchors {
                        top: randomAuthorCoverMask.bottom
                        topMargin: blockMargin
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }

                BasicTextStyle {
                    id: randomAuthorStyle

                    text: "Trap/EDM"

                    anchors {
                        top: randomAuthorName.bottom
                        topMargin: blockMargin
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }
            }

        }
    }

}

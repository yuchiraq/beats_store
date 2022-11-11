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

                height: parent.height - 10
                width: height / 12 * 9
                radius: height / 20
                color: "#333"
                border.color: "#282323"
                border.width: 1

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

                HeaderTextStyle {
                    id: randomAuthorName
                    color: "white"
                    text: "Niki-Y On Da Track"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 4

                    anchors {
                        top: randomAuthorCoverMask.bottom
                        topMargin: blockMargin / 2
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }

                BasicTextStyle {
                    id: randomAuthorStyle

                    text: "Trap/EDM"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 5

                    anchors {
                        top: randomAuthorName.bottom
                        topMargin: blockMargin / 4
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }
            }

            Rectangle {
                id: randomAuthor1

                height: parent.height - 10
                width: height / 12 * 9
                radius: height / 20
                color: "#333"
                border.color: "#282323"
                border.width: 1

                Rectangle {
                    id: randomAuthorCoverMask1

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
                    id: randomAuthorCover1
                    source: "qrc:/png/temp/authors/cq.png"

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
                    anchors.fill: randomAuthorCoverMask1
                    source: randomAuthorCover1
                    maskSource: randomAuthorCoverMask1
                }

                HeaderTextStyle {
                    id: randomAuthorName1
                    color: "white"
                    text: "Chiraq Concept"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 4

                    anchors {
                        top: randomAuthorCoverMask1.bottom
                        topMargin: blockMargin / 2
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }

                BasicTextStyle {
                    id: randomAuthorStyle1

                    text: "Boss"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 5

                    anchors {
                        top: randomAuthorName1.bottom
                        topMargin: blockMargin / 4
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }
            }

            Rectangle {
                id: randomAuthor2

                height: parent.height - 10
                width: height / 12 * 9
                radius: height / 20
                color: "#333"
                border.color: "#282323"
                border.width: 1

                Rectangle {
                    id: randomAuthorCoverMask2

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
                    id: randomAuthorCover2
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
                    anchors.fill: randomAuthorCoverMask2
                    source: randomAuthorCover2
                    maskSource: randomAuthorCoverMask2
                }

                HeaderTextStyle {
                    id: randomAuthorName2
                    color: "white"
                    text: "Niki-Y On Da Track"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 4

                    anchors {
                        top: randomAuthorCoverMask2.bottom
                        topMargin: blockMargin / 2
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }

                BasicTextStyle {
                    id: randomAuthorStyle2

                    text: "Trap/EDM"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 5

                    anchors {
                        top: randomAuthorName2.bottom
                        topMargin: blockMargin / 4
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }
            }

            Rectangle {
                id: randomAuthor3

                height: parent.height - 10
                width: height / 12 * 9
                radius: height / 20
                color: "#333"
                border.color: "#282323"
                border.width: 1

                Rectangle {
                    id: randomAuthorCoverMask3

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
                    id: randomAuthorCover3
                    source: "qrc:/png/temp/authors/cq.png"

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
                    anchors.fill: randomAuthorCoverMask3
                    source: randomAuthorCover3
                    maskSource: randomAuthorCoverMask3
                }

                HeaderTextStyle {
                    id: randomAuthorName3
                    color: "white"
                    text: "Chiraq Concept"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 4

                    anchors {
                        top: randomAuthorCoverMask3.bottom
                        topMargin: blockMargin / 2
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }

                BasicTextStyle {
                    id: randomAuthorStyle3

                    text: "Boss"

                    font.pointSize: (randomAuthor.height - randomAuthorCoverMask.height) / 5

                    anchors {
                        top: randomAuthorName3.bottom
                        topMargin: blockMargin / 4
                        left: parent.left
                        leftMargin: blockMargin / 2
                    }
                }
            }

        }
    }

}

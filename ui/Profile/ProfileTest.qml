import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/TextStyles"
import "qrc:/ui/Tracks"
import "qrc:/ui"
import "qrc:/ui/Cards"

Flickable {
    id: leftScreen

    contentHeight: profileColumn.height
    anchors.fill: stackView
    anchors.topMargin: topLogo.height
    anchors.bottomMargin: bottomBar.height

    Column {
        id: profileColumn

        anchors {
            top: mainScreen.top
            topMargin: topLogo.height
            bottomMargin: topLogo.height
            horizontalCenter: parent.horizontalCenter
        }

        spacing: blockMargin

        Rectangle {
            border.color: outline
            border.width: 1
            width: mainScreen.width - (blockMargin * 2)
            height: width / 2 * 1

            color: dark

            radius: width / 20

            Rectangle {
                id: avaMask
                width: parent.height
                height: width
                color: darkVariant
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                radius: parent.radius
            }

            HeaderTextStyle {
                text: "Account Name"
                anchors.left: avaMask.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: blockMargin * 2
                color: "white"
            }
        }

        Rectangle {
            id: profileMenu

            border.color: outline
            border.width: 1

            width: mainScreen.width - blockMargin * 2
            height: blockMargin * 6 * 3 + 2

            anchors.horizontalCenter: parent.horizontalCenter

            radius: width / 20

            color: dark

            Column {
                anchors.fill: parent

                spacing: 0
                Button {
                    width: parent.width
                    height: blockMargin * 6

                    background: Rectangle {
                        color: "#00000000"
                    }

                    BasicTextStyle {
                        text: "шото"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
                    }

                    Image {
                        source: "qrc:/png/interface/next.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: blockMargin * 2

                        height: parent.height / 5
                        width: height
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 0.5
                    color: outline
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Button {
                    width: parent.width
                    height: blockMargin * 6

                    background: Rectangle {
                        color: dark
                    }

                    BasicTextStyle {
                        text: "шото"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
                    }

                    Image {
                        source: "qrc:/png/interface/next.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: blockMargin * 2

                        height: parent.height / 5
                        width: height
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 0.5
                    color: outline
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Button {

                    width: parent.width
                    height: blockMargin * 6

                    background: Rectangle {
                        color: "#00000000"
                    }

                    Image {
                        id: exitImg

                        source: "qrc:/png/interface/exit.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
                        sourceSize.width: blockMargin * 2.5
                        sourceSize.height: blockMargin * 2.5
                        //fillMode: Image.PreserveAspectFit
                    }

                    BasicTextStyle {
                        text: "Выход"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: exitImg.right
                        anchors.leftMargin: blockMargin * 2
                        color: alert
                    }

                    Image {
                        source: "qrc:/png/interface/next.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: blockMargin * 2

                        height: parent.height / 5
                        width: height
                    }

                    onClicked: {
                        mainScreen.close()
                        mainScreen.destroy()
                    }

                }

            }

        }

        BasicTextStyle {
            text: "by Chiraq Concept"
            anchors {
                right: parent.right
                rightMargin: blockMargin
            }
        }

    }
}

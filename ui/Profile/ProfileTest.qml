import QtQuick 2.15
import QtQuick.Controls.Material

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

            Text {
                font.family: appFont
                text: "<strong>Account Name</strong>"
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
            height: blockMargin * 5 * 3 + 2

            anchors.horizontalCenter: parent.horizontalCenter

            radius: width / 20

            color: dark

            Column {
                anchors.fill: parent

                spacing: 0
                Button {
                    width: parent.width
                    height: blockMargin * 5

                    background: Rectangle {
                        color: "#00000000"
                    }

                    Text {
                        font.family: appFont
                        color: light
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
                    height: blockMargin * 5

                    background: Rectangle {
                        color: "#00000000"
                    }

                    Image {
                        id: settingsImg

                        source: "qrc:/png/interface/settings (1).svg"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
                        sourceSize.width: blockMargin * 2.5
                        sourceSize.height: blockMargin * 2.5
                        //fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        font.family: appFont
                        text: "Настройки"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: settingsImg.right
                        anchors.leftMargin: blockMargin * 2
                        color: secondary
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
                    height: blockMargin * 5

                    background: Rectangle {
                        color: "#00000000"
                    }

                    Image {
                        id: exitImg

                        source: "qrc:/png/interface/power.svg"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: blockMargin * 2
                        sourceSize.width: blockMargin * 2.5
                        sourceSize.height: blockMargin * 2.5
                        //fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        font.family: appFont
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

        Text {
            font.family: appFont
            color: secondary
            text: "<strong>by Chiraq Concept</strong>"

            anchors {
                right: parent.right
                rightMargin: blockMargin
            }
        }

    }
}

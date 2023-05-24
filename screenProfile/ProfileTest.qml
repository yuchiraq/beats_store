import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

//import QtGraphicalEffects 1.15
import "qrc:/primitive"

StackView {
    id: leftScreen

    anchors.fill: parent

    property string ava: ""

    function clearStack() {
        if (leftScreen.depth > 1) {
            leftScreen.clear(StackView.PopTransition)
            leftScreen.push(profileInitial)
            topBar.backSwitch(1)
        }
    }

    initialItem: Flickable {
        id: profileInitial
        contentHeight: profileColumn.height
        anchors.fill: parent
        anchors.topMargin: topBar.height + blockMargin
        anchors.bottomMargin: bottomBar.height

        Column {
            id: profileColumn

            anchors {
                top: mainScreen.top
                topMargin: topBar.height + blockMargin
                bottomMargin: topBar.height
                horizontalCenter: parent.horizontalCenter
            }

            spacing: blockMargin

            BlockProfile {
                id: blockProfile
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {

                id: profileMenu

                layer.effect: DropShadow {
                    color: "black"
                    horizontalOffset: 4
                    verticalOffset: 4
                    radius: 8
                    source: parent
                    anchors.fill: parent
                    transparentBorder: true
                }

                border.color: outline
                border.width: 0

                width: mainScreen.width - blockMargin * 2
                height: blockMargin * 5 * 4 + 3

                anchors.horizontalCenter: parent.horizontalCenter

                radius: blockMargin * 1.5

                color: container

                Column {
                    anchors.fill: parent

                    spacing: 0
                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        background: Rectangle {
                            color: "#00000000"
                        }

                        Image {
                            id: infoServiceImg

                            source: "qrc:/ui_icons/basic/interrogation.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 1.5
                            sourceSize.width: blockMargin * 2.2
                            sourceSize.height: blockMargin * 2.2
                            //fillMode: Image.PreserveAspectFit
                            ColorOverlay {
                                source: parent
                                color: secondary
                                anchors.fill: parent
                            }
                        }

                        Text {
                            font.family: appFont
                            text: "Информация о сервисе"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: infoServiceImg.right
                            anchors.leftMargin: blockMargin * 1.5
                            color: secondary
                            font.pointSize: 15
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: secondary
                                anchors.fill: parent
                            }
                        }

                        onClicked: {
                            leftScreen.push("./InfoServicePage.qml")
                            topBar.backSwitch()
                        }
                    }

                    Divider {
                        width: parent.width - blockMargin * 2
                    }

                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        background: Rectangle {
                            color: "#00000000"
                        }

                        Image {
                            id: infoBuyImg

                            source: "qrc:/ui_icons/solid/invoice.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 1.5
                            sourceSize.width: blockMargin * 2.2
                            sourceSize.height: blockMargin * 2.2
                            //fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            font.family: appFont
                            text: "Информация о покупках"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: infoBuyImg.right
                            anchors.leftMargin: blockMargin * 1.5
                            color: secondary
                            font.pointSize: 15
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: secondary
                                anchors.fill: parent
                            }
                        }

                        onClicked: {
                            leftScreen.push("./InfoBuyPage.qml")
                            topBar.backSwitch()
                        }
                    }

                    Divider {
                        width: parent.width - blockMargin * 2
                    }

                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        background: Rectangle {
                            color: "#00000000"
                        }

                        Image {
                            id: settingsImg

                            source: "qrc:/ui_icons/basic/settings.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 1.5
                            sourceSize.width: blockMargin * 2.2
                            sourceSize.height: blockMargin * 2.2
                            //fillMode: Image.PreserveAspectFit
                            ColorOverlay {
                                source: parent
                                color: secondary
                                anchors.fill: parent
                            }
                        }

                        Text {
                            font.family: appFont
                            text: "Настройки"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: settingsImg.right
                            anchors.leftMargin: blockMargin * 1.5
                            color: secondary
                            font.pointSize: 15
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: secondary
                                anchors.fill: parent
                            }
                        }

                        onClicked: {
                            leftScreen.push("./SettingsPage.qml")
                            topBar.backSwitch()
                        }
                    }

                    Divider {
                        width: parent.width - blockMargin * 2
                    }

                    Button {
                        width: parent.width
                        height: blockMargin * 5

                        background: Rectangle {
                            color: "#00000000"
                        }

                        Image {
                            id: infoProfileImg

                            source: "qrc:/ui_icons/basic/fingerprint.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: blockMargin * 1.5
                            sourceSize.width: blockMargin * 2.2
                            sourceSize.height: blockMargin * 2.2
                            ColorOverlay {
                                source: parent
                                color: secondary
                                anchors.fill: parent
                            }
                        }

                        Text {
                            font.family: appFont
                            text: "Хранящиеся данные пользователя"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: infoProfileImg.right
                            anchors.leftMargin: blockMargin * 1.5
                            color: secondary
                            font.pointSize: 15
                        }

                        Image {
                            source: "qrc:/ui_icons/basic/angle-small-right.svg"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: blockMargin

                            height: parent.height / 3
                            width: height

                            ColorOverlay {
                                source: parent
                                color: secondary
                                anchors.fill: parent
                            }
                        }
                    }
                }
            }

            Button {

                width: mainScreen.width - blockMargin * 2
                height: blockMargin * 5

                background: Rectangle {
                    anchors.fill: parent

                    border.color: outline
                    border.width: 0.5

                    anchors.horizontalCenter: parent.horizontalCenter

                    radius: blockMargin * 1.5

                    color: container
                }

                Image {
                    id: exitImg

                    source: "qrc:/png/interface/power.svg"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: blockMargin
                    sourceSize.width: blockMargin * 2.5
                    sourceSize.height: blockMargin * 2.5
                    //fillMode: Image.PreserveAspectFit
                }

                Text {
                    font.family: appFont
                    text: "Выход"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: exitImg.right
                    anchors.leftMargin: blockMargin
                    color: alert
                    font.pointSize: 15
                }

                Image {
                    source: "qrc:/ui_icons/basic/angle-small-right.svg"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: blockMargin

                    height: parent.height / 3
                    width: height

                    ColorOverlay {
                        source: parent
                        color: alert
                        anchors.fill: parent
                    }
                }

                onClicked: {
                    mainScreen.close()
                    mainScreen.destroy()
                }
            }

            Text {
                font.family: appFont
                color: secondary
                text: "<strong>by Chiraq Concept</strong>"
                font.pointSize: 15

                anchors {
                    right: parent.right
                    rightMargin: blockMargin
                }
            }
        }
    }
}

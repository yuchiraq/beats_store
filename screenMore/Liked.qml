import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Page {
    id: rightScreen

    anchors.fill: stackView

    Rectangle {
        anchors.fill: parent
        color: darkest
    }

    Column {
        id: column
        anchors.centerIn: parent
        Text {
            text: qsTr("Название:")
            font.pixelSize: 16
            color: light
        }
        TextField {
            id: titleField
            font.family: appFont
            font.pointSize: 25
            placeholderTextColor: outline
            selectedTextColor: secondary
            color: secondary
        }
        Text {
            text: qsTr("Автор:")
            font.pixelSize: 16
            color: light
        }
        TextField {
            id: authorField
            font.family: appFont
            font.pointSize: 25
            placeholderTextColor: outline
            selectedTextColor: secondary
            color: secondary
        }
        Text {
            text: qsTr("Длительность (секунд):")
            font.pixelSize: 16
            color: light
        }
        TextField {
            id: timeField
            validator: RegularExpressionValidator {
                regularExpression: /[\d\s \Q(+)\E]{0,32}$/
            }
            font.family: appFont
            font.pointSize: 25
            placeholderTextColor: outline
            selectedTextColor: secondary
            color: secondary
        }

        Button {
            text: "Добавить"
            Material.theme: Material.Dark
            onClicked: {
                database.inserIntoTable(titleField.text, authorField.text,
                                        timeField.text)
                titleField.clear()
                authorField.clear()
                timeField.clear()
                //centralScreen.update()
            }
        }
    }
}

import QtQuick 2.15
import QtQuick.Controls.Material

Flickable {
    id: infoBuy

    contentHeight: infoBuyColumn.height
    anchors.fill: leftScreen
    anchors.topMargin: topBar.height
    anchors.bottomMargin: bottomBar.height

    Column {

        id: infoBuyColumn

        anchors {
            top: leftScreen.top
            topMargin: topBar.height
            bottomMargin: topBar.height
            horizontalCenter: parent.horizontalCenter
        }

        width: parent.width

        spacing: blockMargin

        Text {
            anchors.left: parent.left
            anchors.leftMargin: blockMargin * 2

            font.family: appFont
            font.bold: true

            horizontalAlignment: Text.AlignLeft

            text: "Оплата"

            font.pointSize: 20

            color: secondary
        }

        Label {
            font.family: appFont
            anchors.left: parent.left
            anchors.leftMargin: blockMargin
        //    anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            width: parent.width - blockMargin * 2
            wrapMode: Label.Wrap
            text: "    Оплата производится безналичным способом. Вывод средств "
                  + "осуществляется с помощью электронного кошелька Ю-мани, банковской "
                  + "карты."

            color: light
        }

        Text {
            anchors.left: parent.left
            anchors.leftMargin: blockMargin * 2
            anchors.topMargin: blockMargin

            font.family: appFont
            font.bold: true

            horizontalAlignment: Text.AlignLeft

            text: "Поддержка"

            font.pointSize: 20

            color: secondary
        }

        Label {
            font.family: appFont
            anchors.left: parent.left
            anchors.leftMargin: blockMargin
        //    anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            width: parent.width - blockMargin * 2
            wrapMode: Label.Wrap
            text: "    Вы можете задать нам любые вопросы, воспользовавшись формой или по "
            + "указанным ниже контактам. Мы отвечаем в течение 1-2 суток. Наши "
            + "с одной стороны, и пользователем данного сайта (далее «Пользователь»), с другой стороны."
            + "специалисты рады ответить на вопросы и предложения, связанные с "
            + "сервисом в онлайн-чате."

            color: light
        }

        Text {
            font.family: appFont
            font.italic: true

            anchors.left: parent.left
            anchors.leftMargin: blockMargin
        //    anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignLeft
            width: parent.width - blockMargin * 2
            wrapMode: Text.Wrap
            text: "support@ogbeats.ru"

            color: light
        }


    }

}

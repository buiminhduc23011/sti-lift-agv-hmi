import QtQuick
import QtQuick.Controls

Button {
    id: control

    contentItem: Column {
        spacing: 2
        Label {
            text: control.icon.name // or source
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            text: control.text
            font: control.font
            color: control.checked ? "#00e676" : "#ffffff"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}

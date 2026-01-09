import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    property string text: ""
    property color textColor: "#ffffff"
    property bool active: true

    // Size constraints
    implicitHeight: 24
    implicitWidth: label.implicitWidth + 20

    radius: height / 2
    color: active ? "#2e7d32" : "#424242" // Default Green or Grey

    Label {
        id: label
        text: root.text.toUpperCase()
        color: root.textColor
        font.pixelSize: 11
        font.bold: true
        anchors.centerIn: parent
    }
}

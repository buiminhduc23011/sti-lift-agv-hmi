import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: alarmScreen

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Label {
            text: "ACTIVE ALARMS"
            color: "#ff1744"
            font.bold: true
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: ListModel {
                ListElement { code: "[CRITICAL] E-102"; msg: "E-STOP PRESSED"; time: "10:42:05"; level: "CRITICAL" }
                ListElement { code: "[WARN] W-204"; msg: "PATH OBSTACLE DETECTED"; time: "10:41:15"; level: "WARN" }
                ListElement { code: "[INFO] I-301"; msg: "SYSTEM READY"; time: "08:00:00"; level: "INFO" }
            }
            delegate: Rectangle {
                width: parent.width
                height: 60
                color: "#1e1e1e"
                radius: 5
                border.width: 1
                border.color: level === "CRITICAL" ? "#ff1744" : (level === "WARN" ? "#ff9100" : "#2979ff")

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    Rectangle {
                        width: 4; height: parent.height
                        color: parent.parent.border.color
                    }

                    Column {
                        Label { text: code; color: parent.parent.parent.border.color; font.bold: true }
                        Label { text: msg; color: "white" }
                    }

                    Item { Layout.fillWidth: true }

                    Label { text: time; color: "#757575" }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Button {
                text: "ACKNOWLEDGE FAULT"
                Layout.fillWidth: true
                background: Rectangle { color: "#2979ff"; radius: 4 }
                contentItem: Text { text: parent.text; color: "white"; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                onClicked: agvBackend.acknowledgeAlarm()
            }
            Button {
                text: "RESET"
                Layout.fillWidth: true
                onClicked: agvBackend.resetSystem()
            }
        }
    }

    // Listen to backend alarms (mockup connection)
    Connections {
        target: agvBackend
        function onNewAlarm(code, message, level) {
            // In a real app, we would append to the model
            console.log("New Alarm:", code, message)
        }
    }
}

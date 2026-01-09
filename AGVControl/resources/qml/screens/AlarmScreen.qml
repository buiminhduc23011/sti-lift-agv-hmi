import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: root
    background: Rectangle { color: window.cBackground }

    header: Header {
        title: "AGV-04"
        mode: agvBackend.mode
        connected: agvBackend.connected
        battery: agvBackend.batteryLevel

        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            StatusBadge { text: "MODE: " + agvBackend.mode; color: window.cGreen; textColor: "#000000" }
            StatusBadge { text: "FAULT"; color: window.cRed; textColor: "#ffffff"; visible: agvBackend.currentAlarmCount > 0 }
        }
    }

    // Mock Model
    ListModel {
        id: alarmModel
        ListElement { level: "CRITICAL"; code: "E-102"; msg: "E-STOP PRESSED: REAR PANEL"; time: "10:42:05"; colorCode: "#ff1744" }
        ListElement { level: "WARN"; code: "W-204"; msg: "PATH OBSTACLE DETECTED"; time: "10:41:15"; colorCode: "#ff9100" }
        ListElement { level: "INFO"; code: "I-301"; msg: "MAINTENANCE DUE SOON"; time: "08:00:00"; colorCode: "#2979ff" }
    }

    contentItem: RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        // Left: Alarm List
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10

            Row {
                spacing: 10
                Label { text: "ACTIVE ALARMS"; color: "#ffffff"; font.bold: true; font.pixelSize: 16 }
                StatusBadge { text: agvBackend.currentAlarmCount.toString(); color: window.cRed; height: 20 }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: alarmModel
                spacing: 10

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 60
                    color: model.colorCode
                    radius: 8
                    opacity: 0.2 // Background opacity

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"
                        border.color: model.colorCode
                        border.width: 1
                        radius: 8

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15

                            // Icon box
                            Rectangle {
                                width: 40; height: 40
                                color: Qt.lighter(model.colorCode, 1.2)
                                radius: 8
                                Label {
                                    anchors.centerIn: parent
                                    text: model.level === "CRITICAL" ? "✋" : (model.level === "WARN" ? "⚠️" : "ℹ️")
                                    font.pixelSize: 20
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2
                                Label {
                                    text: "[" + model.level + "] " + model.code
                                    color: model.colorCode // Text color matches level
                                    font.bold: true
                                }
                                Label {
                                    text: model.msg
                                    color: "#ffffff"
                                    font.pixelSize: 12
                                }
                            }

                            Label {
                                text: model.time
                                color: window.cTextSecondary
                                font.pixelSize: 12
                            }
                        }
                    }
                }
            }
        }

        // Right: Acknowledge & Reset
        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            spacing: 20

            // Acknowledge Button (Big Blue)
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: window.cBlue
                radius: 12

                ColumnLayout {
                    anchors.centerIn: parent
                    Label { text: "✅"; font.pixelSize: 48; Layout.alignment: Qt.AlignHCenter }
                    Label { text: "ACKNOWLEDGE\nFAULT"; color: "#ffffff"; font.bold: true; font.pixelSize: 20; horizontalAlignment: Text.AlignHCenter; Layout.alignment: Qt.AlignHCenter }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: agvBackend.acknowledgeAlarm()
                }
            }

            // Reset Button (Darker)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: window.cCardBg
                radius: 12

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 10
                    Label { text: "🔄"; font.pixelSize: 24 }
                    Label { text: "RESET"; color: "#ffffff"; font.bold: true; font.pixelSize: 18 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: agvBackend.resetSystem()
                }
            }
        }
    }

    footer: Footer {
        NavButton {
            text: "HOME"
            iconText: "🏠"
            onClicked: window.goHome()
        }

        NavButton {
            text: "BACK"
            iconText: "⬅️"
            onClicked: window.popScreen()
        }

        // This is the active screen
        Rectangle {
            width: 120
            height: parent.height
            color: window.cRed
            Label {
                anchors.centerIn: parent
                text: "ALARMS"
                color: "#ffffff"
                font.bold: true

                Label {
                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "🔔"
                    font.pixelSize: 24
                    anchors.bottomMargin: 5
                }
            }
        }
    }
}

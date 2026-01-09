import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: root
    background: Rectangle { color: window.cBackground }

    header: Header {
        title: "AGV-04"
        mode: "MANUAL"
        connected: agvBackend.connected
        battery: agvBackend.batteryLevel

        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            StatusBadge { text: "MANUAL MODE"; color: window.cBlue; textColor: "#ffffff" }
            StatusBadge { text: "FRONT CLEAR"; color: agvBackend.frontClear ? window.cGreen : window.cRed; textColor: "#000000" }
            StatusBadge { text: "REAR CLEAR"; color: agvBackend.rearClear ? window.cGreen : window.cRed; textColor: "#000000" }
        }
    }

    contentItem: RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        // Left Column: D-Pad and Toggle
        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.4
            spacing: 20

            // Manual Enable Toggle
            Rectangle {
                Layout.fillWidth: true
                height: 50
                color: "transparent"

                RowLayout {
                    anchors.right: parent.right
                    Label {
                        text: "MANUAL CONTROL ENABLE"
                        color: window.cText
                        font.bold: true
                    }
                    Switch {
                        checked: agvBackend.manualControlEnabled
                        onToggled: agvBackend.manualControlEnabled = checked
                    }
                }
            }

            // D-Pad Grid
            GridLayout {
                Layout.alignment: Qt.AlignCenter
                columns: 3
                rows: 2
                columnSpacing: 10
                rowSpacing: 10

                // Row 1
                Item { width: 80; height: 60 } // Spacer
                DashboardCard {
                    Layout.preferredWidth: 100; Layout.preferredHeight: 80
                    title: "FWD"
                    iconSource: "⬆️"
                    active: false
                    onClicked: agvBackend.manualMove("FORWARD")
                    enabled: agvBackend.manualControlEnabled
                    opacity: enabled ? 1.0 : 0.5
                }
                Item { width: 80; height: 60 } // Spacer

                // Row 2
                DashboardCard {
                    Layout.preferredWidth: 100; Layout.preferredHeight: 80
                    title: "LEFT"
                    iconSource: "⬅️"
                    onClicked: agvBackend.manualMove("LEFT")
                    enabled: agvBackend.manualControlEnabled
                    opacity: enabled ? 1.0 : 0.5
                }
                 DashboardCard {
                    Layout.preferredWidth: 100; Layout.preferredHeight: 80
                    title: "RIGHT"
                    iconSource: "➡️"
                    onClicked: agvBackend.manualMove("RIGHT")
                    enabled: agvBackend.manualControlEnabled
                    opacity: enabled ? 1.0 : 0.5
                }
                 // Row 3 (Rev) - actually need 3 rows

            }

            // Separate Rev button below or part of grid? Design shows DPad.
            // Let's add REV below
             DashboardCard {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 100; Layout.preferredHeight: 80
                title: "REV"
                iconSource: "⬇️"
                onClicked: agvBackend.manualMove("REVERSE")
                enabled: agvBackend.manualControlEnabled
                opacity: enabled ? 1.0 : 0.5
            }
        }

        // Center: Stop & Speed
        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            spacing: 20
            Layout.alignment: Qt.AlignTop

            // Stop Button
            Rectangle {
                Layout.preferredWidth: 200
                Layout.preferredHeight: 140
                Layout.alignment: Qt.AlignHCenter
                color: window.cRed
                radius: 12

                ColumnLayout {
                    anchors.centerIn: parent
                    Label { text: "🛑"; font.pixelSize: 48; Layout.alignment: Qt.AlignHCenter }
                    Label { text: "STOP"; color: "#ffffff"; font.bold: true; font.pixelSize: 24; Layout.alignment: Qt.AlignHCenter }
                }

                MouseArea { anchors.fill: parent; onClicked: console.log("ESTOP") }
            }

            // Speed Selectors
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                DashboardCard {
                    Layout.preferredWidth: 90; Layout.preferredHeight: 80
                    title: "SLOW"
                    iconSource: "🐢"
                    active: true // Default
                }
                DashboardCard {
                    Layout.preferredWidth: 90; Layout.preferredHeight: 80
                    title: "FAST"
                    iconSource: "🚀"
                    active: false
                }
            }
        }

        // Right: Forklift & Reset
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20

            Label { text: "FORK LIFT"; color: window.cTextSecondary; font.bold: true; Layout.alignment: Qt.AlignHCenter }

            DashboardCard {
                Layout.preferredWidth: 120; Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                title: ""
                iconSource: "⬆️"
                onClicked: agvBackend.toggleForkLift()
            }

            DashboardCard {
                Layout.preferredWidth: 120; Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignHCenter
                title: ""
                iconSource: "⬇️"
                onClicked: agvBackend.toggleForkLift()
            }

            Item { Layout.fillHeight: true }

            DashboardCard {
                Layout.preferredWidth: 160; Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter
                title: "RESET FAULT"
                iconSource: "🔄"
                onClicked: agvBackend.acknowledgeAlarm()
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
            text: "ALARMS (" + agvBackend.currentAlarmCount + ")"
            iconText: "⚠️"
            activeColor: window.cOrange
            isActive: agvBackend.currentAlarmCount > 0
            onClicked: window.navigateTo("screens/AlarmScreen.qml")
        }

        NavButton {
            text: "BACK"
            iconText: "⬅️"
            onClicked: window.popScreen()
        }
    }
}

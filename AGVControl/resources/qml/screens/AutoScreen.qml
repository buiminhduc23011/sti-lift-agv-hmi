import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Page {
    id: root
    background: Rectangle { color: window.cBackground }

    header: Header {
        title: "AGV-04"
        mode: "AUTO"
        connected: agvBackend.connected
        battery: agvBackend.batteryLevel

        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            StatusBadge { text: "AUTO MODE"; color: window.cGreen; textColor: "#000000" }
        }
    }

    contentItem: RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        // Left: Controls
        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.45
            spacing: 15

            // Start
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 140
                color: window.cGreen
                radius: 12

                ColumnLayout {
                    anchors.centerIn: parent
                    Label { text: "▶️"; font.pixelSize: 48; Layout.alignment: Qt.AlignHCenter }
                    Label { text: "START"; color: "#ffffff"; font.bold: true; font.pixelSize: 24; Layout.alignment: Qt.AlignHCenter }
                }
                MouseArea { anchors.fill: parent; onClicked: console.log("Start Auto") }
            }

            // Pause & Stop
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                spacing: 15

                Rectangle {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    color: window.cOrange
                    radius: 12
                     ColumnLayout {
                        anchors.centerIn: parent
                        Label { text: "⏸️"; font.pixelSize: 32; Layout.alignment: Qt.AlignHCenter }
                        Label { text: "PAUSE"; color: "#ffffff"; font.bold: true; font.pixelSize: 18; Layout.alignment: Qt.AlignHCenter }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    color: window.cRed
                    radius: 12
                     ColumnLayout {
                        anchors.centerIn: parent
                        Label { text: "⏹️"; font.pixelSize: 32; Layout.alignment: Qt.AlignHCenter }
                        Label { text: "STOP"; color: "#ffffff"; font.bold: true; font.pixelSize: 18; Layout.alignment: Qt.AlignHCenter }
                    }
                }
            }
        }

        // Right: Status & Steps
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 15

            // Auto Control Toggle Panel
            Rectangle {
                Layout.fillWidth: true
                height: 60
                color: window.cCardBg
                radius: 8

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15

                    Column {
                        Label { text: "Auto Control"; color: "#ffffff"; font.bold: true }
                        Label { text: agvBackend.systemReady ? "System Ready" : "Not Ready"; color: agvBackend.systemReady ? window.cBlue : window.cTextSecondary; font.pixelSize: 12 }
                    }

                    Item { Layout.fillWidth: true }

                    Switch {
                        checked: true
                    }
                }
            }

            // Current Step Panel
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: window.cCardBg
                radius: 12

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 10

                    Label { text: "CURRENT STEP"; color: window.cTextSecondary; font.pixelSize: 12 }
                    Label { text: agvBackend.currentStep; color: "#ffffff"; font.pixelSize: 64; font.bold: true }
                    Label { text: agvBackend.stepDescription; color: window.cTextSecondary; font.pixelSize: 16 }

                    // Progress Bar
                    Rectangle {
                        Layout.preferredWidth: 200
                        height: 4
                        color: window.cBlue
                        radius: 2
                    }
                }
            }

            // Status Cards
            RowLayout {
                Layout.fillWidth: true
                height: 80
                spacing: 10

                Rectangle {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    color: window.cCardBg; radius: 8
                    RowLayout {
                        anchors.centerIn: parent
                        Label { text: agvBackend.frontClear && agvBackend.rearClear ? "✅" : "⚠️"; font.pixelSize: 24 }
                        Column {
                            Label { text: "Safety"; color: "#ffffff"; font.bold: true }
                            Label { text: "Zone Clear"; color: window.cTextSecondary; font.pixelSize: 10 }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    color: window.cCardBg; radius: 8
                     RowLayout {
                        anchors.centerIn: parent
                        Label { text: "📶"; font.pixelSize: 24 }
                        Column {
                            Label { text: "Comms"; color: "#ffffff"; font.bold: true }
                            Label { text: "Connected"; color: window.cTextSecondary; font.pixelSize: 10 }
                        }
                    }
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

        NavButton {
            text: "ALARMS"
            iconText: "🔔"
             onClicked: window.navigateTo("screens/AlarmScreen.qml")
        }
    }
}

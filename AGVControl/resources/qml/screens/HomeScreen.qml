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

        // Custom middle content for Home
        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            StatusBadge {
                text: agvBackend.connected ? "ONLINE" : "OFFLINE"
                color: agvBackend.connected ? window.cGreen : window.cRed
                textColor: "#000000"
            }
        }
    }

    contentItem: RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Left Panel: Stats
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.4
            color: window.cCardBg // Transparent or Card BG? Image shows dark panel
            radius: 12

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Label {
                    text: "CURRENT STATE"
                    color: window.cTextSecondary
                    font.pixelSize: 12
                }

                Label {
                    text: agvBackend.speed > 0 ? "RUN" : "IDLE"
                    color: agvBackend.speed > 0 ? window.cGreen : window.cText
                    font.pixelSize: 48
                    font.bold: true
                }

                Label {
                    text: "MODE: " + agvBackend.mode
                    color: window.cTextSecondary
                    font.pixelSize: 14
                }

                Item { Layout.fillHeight: true }

                // Speed & Battery
                GridLayout {
                    columns: 2
                    columnSpacing: 10
                    rowSpacing: 10
                    Layout.fillWidth: true

                    Label { text: "⏱️ Speed"; color: window.cTextSecondary }
                    Label {
                        text: agvBackend.speed.toFixed(1) + " m/s"
                        color: window.cText; font.bold: true
                        Layout.alignment: Qt.AlignRight
                    }

                    Label { text: "⚡ Battery"; color: window.cTextSecondary }
                    Label {
                        text: agvBackend.batteryLevel + "%"
                        color: window.cText; font.bold: true
                        Layout.alignment: Qt.AlignRight
                    }
                }

                // Progress Bar
                ProgressBar {
                    Layout.fillWidth: true
                    value: agvBackend.batteryLevel / 100.0
                    from: 0
                    to: 1

                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 6
                        color: "#424242"
                        radius: 3
                    }

                    contentItem: Item {
                        implicitWidth: 200
                        implicitHeight: 4

                        Rectangle {
                            width: parent.visualPosition * parent.width
                            height: parent.height
                            radius: 2
                            color: agvBackend.batteryLevel > 20 ? window.cGreen : window.cRed
                        }
                    }
                }
            }
        }

        // Right Panel: Grid
        GridLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            columns: 2
            columnSpacing: 10
            rowSpacing: 10

            DashboardCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                title: "AUTO"
                iconSource: "🤖"
                active: agvBackend.mode === "AUTO"
                onClicked: {
                    agvBackend.mode = "AUTO"
                    window.navigateTo("screens/AutoScreen.qml")
                }
            }

            DashboardCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                title: "MANUAL"
                iconSource: "🕹️"
                active: agvBackend.mode === "MANUAL"
                onClicked: {
                    agvBackend.mode = "MANUAL"
                    window.navigateTo("screens/ManualScreen.qml")
                }
            }

            DashboardCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                title: "SETTING"
                iconSource: "⚙️"
                onClicked: window.navigateTo("screens/SettingsScreen.qml")
            }

            DashboardCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                title: "ALARM"
                iconSource: "🔔"
                onClicked: window.navigateTo("screens/AlarmScreen.qml")
            }
        }
    }

    footer: Footer {
        NavButton {
            text: "HOME"
            iconText: "🏠"
            isActive: true
        }

        NavButton {
            text: "BACK"
            iconText: "⬅️"
            onClicked: window.popScreen() // Likely won't do anything on home
        }

        NavButton {
            text: "STOP"
            iconText: "⚠️"
            isStop: true
            onClicked: console.log("Stop pressed")
        }
    }
}

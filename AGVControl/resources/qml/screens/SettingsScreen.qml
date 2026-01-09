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
            StatusBadge { text: "MANUAL MODE"; color: window.cGreen; textColor: "#ffffff" }
        }
    }

    contentItem: RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        // Left Column: Speed Configuration
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10

            Label { text: "SPEED CONFIGURATION"; color: window.cTextSecondary; font.bold: true; font.pixelSize: 12 }

            // Manual Speed
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: window.cCardBg
                radius: 12

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    RowLayout {
                        Layout.fillWidth: true
                        Label { text: "MANUAL SPEED"; color: "#ffffff"; font.bold: true; Layout.fillWidth: true }
                        Label { text: "m/s"; color: window.cBlue }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Button {
                            text: "−"
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 60
                            background: Rectangle { color: "#2d2d2d"; radius: 8 }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60
                            color: "#1a1d26"
                            radius: 8
                            Label {
                                anchors.centerIn: parent
                                text: "1.2"
                                color: "#ffffff"
                                font.pixelSize: 32
                                font.bold: true
                            }
                        }

                        Button {
                            text: "+"
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 60
                            background: Rectangle { color: "#2d2d2d"; radius: 8 }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }
            }

            // Auto Max Limit
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: window.cCardBg
                radius: 12

                 ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    RowLayout {
                        Layout.fillWidth: true
                        Label { text: "AUTO MAX LIMIT"; color: "#ffffff"; font.bold: true; Layout.fillWidth: true }
                        Label { text: "m/s"; color: window.cBlue }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Button {
                            text: "−"
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 60
                            background: Rectangle { color: "#2d2d2d"; radius: 8 }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60
                            color: "#1a1d26"
                            radius: 8
                            Label {
                                anchors.centerIn: parent
                                text: "2.5"
                                color: "#ffffff"
                                font.pixelSize: 32
                                font.bold: true
                            }
                        }

                        Button {
                            text: "+"
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 60
                            background: Rectangle { color: "#2d2d2d"; radius: 8 }
                            contentItem: Text {
                                text: parent.text
                                color: "#ffffff"
                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }
            }
        }

        // Right Column: Dynamics & System
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10

            Label { text: "DYNAMICS & SYSTEM"; color: window.cTextSecondary; font.bold: true; font.pixelSize: 12 }

            // Accel Profile
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: window.cCardBg
                radius: 12

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    Label { text: "ACCEL PROFILE"; color: "#ffffff"; font.bold: true }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 0

                        Repeater {
                            model: ["SOFT", "NORMAL", "HARD"]
                            delegate: Rectangle {
                                Layout.fillWidth: true
                                height: 50
                                color: agvBackend.accelProfile === modelData ? window.cBlue : "#1a1d26"
                                border.width: 1
                                border.color: "#2d2d2d"

                                Label {
                                    anchors.centerIn: parent
                                    text: modelData
                                    color: agvBackend.accelProfile === modelData ? "#ffffff" : window.cTextSecondary
                                    font.bold: true
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: agvBackend.accelProfile = modelData
                                }
                            }
                        }
                    }
                }
            }

            // System Info (User Level & PLC)
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: window.cCardBg
                radius: 12

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    RowLayout {
                        Layout.fillWidth: true
                        Label { text: "🆔 USER LEVEL"; color: "#ffffff"; font.bold: true }
                        Item { Layout.fillWidth: true }
                        Label { text: agvBackend.userLevel; color: window.cBlue; font.bold: true }
                    }

                     Rectangle { Layout.fillWidth: true; height: 1; color: "#2d2d2d" }

                     RowLayout {
                        Layout.fillWidth: true
                        Label { text: "💾 PLC STATUS"; color: "#ffffff"; font.bold: true }
                        Item { Layout.fillWidth: true }
                        StatusBadge { text: agvBackend.plcStatus ? "CONNECTED" : "DISCONNECTED"; color: "transparent"; textColor: window.cGreen }
                    }
                }
            }
        }
    }

    footer: Footer {
        NavButton {
            text: "BACK"
            iconText: "⬅️"
            onClicked: window.popScreen()
        }

        NavButton {
            text: "HOME"
            iconText: "🏠"
            isActive: true // Visually highlighted in image
            onClicked: window.goHome()
        }

        NavButton {
            text: "ALARM (" + agvBackend.currentAlarmCount + ")"
            iconText: "🔔"
            activeColor: window.cRed
            isActive: agvBackend.currentAlarmCount > 0
             onClicked: window.navigateTo("screens/AlarmScreen.qml")
        }
    }
}

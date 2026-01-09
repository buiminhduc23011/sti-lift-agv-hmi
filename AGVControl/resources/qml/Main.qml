import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "components"

ApplicationWindow {
    id: window
    width: 800
    height: 480
    visible: true
    title: "AGV HMI"
    color: "#1a1d26"

    // Global Palette
    property color cBackground: "#1a1d26"
    property color cCardBg: "#242835"
    property color cGreen: "#00e676"
    property color cRed: "#ff1744"
    property color cBlue: "#2979ff"
    property color cOrange: "#ff9100"
    property color cText: "#ffffff"
    property color cTextSecondary: "#b0bec5"

    // No standard ToolBar/TabBar, we delegate to screens

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "screens/HomeScreen.qml"

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }

    // Global functions for navigation if needed, or just pass stackView
    function navigateTo(screenPath) {
        stackView.push(screenPath)
    }

    function popScreen() {
        stackView.pop()
    }

    function goHome() {
        stackView.pop(null) // Pop to root
    }
}
